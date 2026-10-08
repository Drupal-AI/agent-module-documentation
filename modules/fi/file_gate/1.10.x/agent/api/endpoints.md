<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — HTTP API (routes, permissions, request/response)

All API routes are declared in `file_gate.routing.yml` with `_access: 'TRUE'` and `no_cache: TRUE`. `_access:
TRUE` is deliberate: each controller **authenticates itself** (shared secret, or validates the grant it is
handed). None of these is gated by a Drupal permission — the settings route is the only permissioned one.

## Server-to-server auth model
Mint, revoke, otp, grants, and grants/revoke-bulk share `SharedSecretAuthTrait::authenticateSharedSecret()`:
- **Fail closed:** `503 {"error":"File Gate is not configured."}` when no secret material exists.
- Credentials from Basic-auth password (username = secret id, optional) or `X-File-Gate-Secret[-Id]` headers,
  resolved + compared with `hash_equals` by `SecretRegistry::resolveCredentials()`.
- **Failed-auth flood:** 10 tries / 60 s per IP → `429`, else `401` (`WWW-Authenticate: Basic realm="file-gate"`).
- **Success flood:** configured `flood_limit`/`flood_window` per IP → `429`.
- On success the resolved secret id is stashed on the request (`SecretRegistryInterface::REQUEST_ATTR_SECRET_ID`,
  NULL = legacy) and drives field-scope checks (`SecretRegistry::allowsField()`) and HMAC key selection.

`AuthorizationShield` (`http_middleware.file_gate_authorization_shield`, priority 180) strips a Bearer/DPoP
`Authorization` header on `/api/file-gate/download` and `/api/file-gate/assurance/bridge` before routing (so a
global auth provider like simple_oauth cannot 401 a foreign IdP token pre-routing) and stashes it for the
assurance handlers; Basic credentials and all other routes pass through untouched.

## `GET /api/file-gate/download` — `DownloadController::download`
Public; validates the grant itself. Query: `f` = file UUID, plus whatever the method needs (signed_url: `exp`,
`sig`, optional `nbf`, `jti`, `max`, `k`; token: `token`, `sig`, …; otp: `email`+`otp` or the `FG_OTP` cookie).
Flow: load file by UUID → `404` if unknown; `getGateForFile()` → `404` if not gated (never an open proxy); `404`
if bytes missing on disk (before running the gate, so a one-time use is not burned); per-IP denied-download flood;
`$method->grants($file, $request)` → on FALSE optionally emits a `ChallengeAwareGateMethodInterface` challenge,
registers the flood hit, logs/audits `download_denied`, throws `403`. On success streams a `BinaryFileResponse`
with `X-Content-Type-Options: nosniff`, `Cache-Control: private, no-store, max-age=0`, and inline disposition
**only** for a hard-coded safe-MIME allowlist (SVG/HTML excluded — anti stored-XSS); otherwise attachment.

## `POST /api/file-gate/mint` — `MintController::mint`
Shared-secret auth. Body: `{"file":"<uuid>"}` or `{"media":"<uuid>"}` (published media only, resolved by
`FileTargetResolver`), optional `field` (`entity_type.field_name`, required when a file is gated by >1 field),
optional `account` (user UUID) / `uid` (identity-aware mint). Checks: file gated → else `422`; secret allowed for
the resolved field (`allowsField()`) → else `403`; identity required (global `require_acting_account` or field
`require_identity_mint`) → `403` if no `account`/`uid`; when an acting account is named, `HostAccess::
actingAccountMayReach()` requires that user to have `download` on the file and `view` on referencing entities,
the field, and every parent → else `403`. Then `$method->mint()` (or `mintWithContext()` for
`ContextualMintInterface`). Returns `{path, expires, ttl, field, method}` where `path` is a **root-relative,
host-agnostic** download URL (the front end prepends its own origin). A closed availability window → `410`; a
method that does not mint → `400`.

## `POST /api/file-gate/revoke` — `RevokeController::revoke`
Shared-secret auth. Body `{"token":"<plaintext>"}` (token method) or `{"jti":"…","ttl":<seconds?>}` (signed_url
grant). Token revoke deletes the stored token-hash row under the token lock (so a concurrent redeem cannot
resurrect it) and enforces the credential's field scope from the stored row. Jti revoke (`revokeSignedJti`)
requires inventory meta to exist, the secret to be allowed for the grant's stored field, and (named secrets) the
stored `k` to match; it writes a kill-mark that outlives the grant. `204` on success; `400`/`403`/`404`/`429`/`503`.

## `POST /api/file-gate/otp` — `OtpController::request`
Shared-secret auth. Body `{"file"|"media":"<uuid>","email":"<addr>"}`; file must be `otp`-gated and the secret
allowed for its field. Per-`(file,email)` send throttle (3 / 600 s). Generates a CSPRNG numeric code
(`random_int`), stores only its HMAC (`Otp::codeHash`, keyed with the authenticated secret material), e-mails it
(`hook_mail` key `otp`), and returns `204`. A failed send rolls back the stored code and refunds the throttle
slot. The code itself is never logged.

## `POST /api/file-gate/otp/session` — `OtpController::establishSession`
Public (no mint secret): validates `{"file"|"media","email","otp"}` via `Otp::consumeCode()` (single-use,
attempt-locked) and, on success, sets a short-lived HttpOnly `FG_OTP` cookie (`OtpSession`, path
`/api/file-gate`, SameSite lax, HMAC-signed) so the subsequent `GET download` needs no `email`/`otp` in the query
(keeps secrets out of logs/Referer). Returns `{ok:true, path}`. 20 / 60 s per-IP flood.

## `GET /api/file-gate/grants` — `GrantInventoryController::list`
Shared-secret auth. Query `field` (required) — must be allowed for the secret. Lists non-expired usage-limited
`signed_url` grants for that field from `GrantInventory` (named secrets see only their own `k` rows). Returns
`{field, count, grants:[{jti,f,field,exp,max,sh,k,created}, …]}` — **no secret material**. (Only usage-limited
grants are recorded, so an empty list does not mean no live link exists.)

## `POST /api/file-gate/grants/revoke-bulk` — `GrantInventoryController::revokeBulk`
Shared-secret auth. Body `{field, jtis:[…]}` or `{field, all:true, sh?, ttl?}` — only jtis the secret may see for
that field are revoked (kill-marks written via `GrantInventory::revokeJti()`). Returns `{revoked:<n>}`.

## Audit & logging
Every mint/download/deny/revoke/otp event is logged to the `file_gate` logger channel and passed to
`FileGateAudit` (`file_gate.audit`), which forwards to `audit_chain.logger` when the optional Audit Chain module
is installed (hash-chained durable log).
