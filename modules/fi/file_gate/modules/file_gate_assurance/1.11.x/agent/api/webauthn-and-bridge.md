<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Assurance — step-up, session bridge & WebAuthn endpoints

Routes from `file_gate_assurance.routing.yml`. The plain-link flow: a browser GET to the signed download without
assurance fails; the visitor completes step-up (OIDC or WebAuthn); a short-lived HttpOnly bridge cookie is set;
the same signed URL then downloads normally.

## Step-up page — `GET /api/file-gate/assurance/step-up` (`BridgeController::stepUpPage`)
`_access: TRUE`. Serves a minimal, `noindex`, `no-store` HTML page (self-contained JS) that either runs the OIDC
flow (try same-origin SSO bridge, else use a client-supplied access token) or the WebAuthn assertion
(`mode=webauthn`). Every URL it embeds is built server-side and JSON-encoded into JS. The IdP `login_url` comes
**only** from the field's `step_up_login_url` setting (never the query) and is validated by `StepUpAuthorizeUrl`;
`login_url` is stripped from any forwarded query (open-redirect defense, GH #40/#62/#63).

## Bridge — `POST /api/file-gate/assurance/bridge` (`BridgeController::establish`)
`_access: TRUE`, `_auth: ['cookie']`. Validates the grant signature first (`Assurance::signatureValid`, no usage
burn) → 403 if invalid. Then runs live assurance (`liveAssuranceSatisfied`) using the presented Bearer/DPoP
Authorization (read via `AuthorizationShield`, which stashed it pre-routing past a global provider) or, when
absent and `session_bridge_sso` is on, a same-origin openid_connect session token (`SessionOidcToken`). On success
mints the `FG_AB` cookie (`SessionBridge::mintCookie`) and returns `{ok, path, bridge_ttl}`; on failure returns an
RFC 9470-style `insufficient_user_authentication` challenge.

### `SessionBridge` cookie (`FG_AB`)
HMAC-signed `payload.mac` (base64url) over `{v,f,exp,gexp,aal,sh,jti,sig}`, signed with the grant's secret
material (`k`), path `/api/file-gate`, HttpOnly, SameSite lax, secure on HTTPS, clamped 15–600 s and capped by the
grant expiry. `isSatisfied()` verifies the MAC (`hash_equals`, current + retired materials), that `f` matches, the
cookie is unexpired, and — **anti-swap** — that the request's `sig`/`jti`/`aal`/`sh` equal the values bound in the
cookie. So a bridge cookie only satisfies the exact grant URL it was minted for.

## WebAuthn registration (permission-gated)
Routes require `register file gate webauthn+administer file gate`:
- `POST /api/file-gate/webauthn/register/options` (`registerOptions`) — creation options for the current user
  (handle = uid).
- `POST /api/file-gate/webauthn/register` (`registerComplete`) — verifies the attestation and stores the
  credential.
- `GET /api/file-gate/webauthn/credentials` (`listCredentials`) / `POST .../credentials/delete`
  (`deleteCredential`) — list/delete the current user's own credentials (delete checks the row's `user_handle`
  matches the current uid).
- Account UI form `/user/{user}/file-gate-webauthn` (`WebAuthnEnrollmentForm`) — custom access: self with
  `register file gate webauthn`, or `administer file gate`.

## WebAuthn assertion (grant-bound, public but gated by the grant)
- `POST /api/file-gate/webauthn/assert/options` (`assertOptions`) — `_access: TRUE`, `_auth: ['cookie']`. Requires
  a valid grant signature; resolves the WebAuthn user handle from the grant (`userHandleFromGrant`: fixed handle,
  field subject, or query `wh=` — and when the grant carries `sh`, the handle **must** hash to it via `hash_equals`
  so a `wh=` cannot open another user's credentials); returns options bound to a grant fingerprint.
- `POST /api/file-gate/webauthn/assert` (`assertComplete`) — verifies the assertion (challenge is single-use and
  bound to the grant fingerprint via `hash_equals`; the asserting credential's `user_handle` must match), then
  mints the `FG_AB` bridge cookie and returns `{ok, path}`.

## Ceremony & storage
`WebAuthnCeremony` (`file_gate_assurance.webauthn_ceremony`) wraps `web-auth/webauthn-lib`: user-verification
required, ES256/RS256, none attestation, allowed origins from field `origins` (or `$settings['file_gate.
webauthn_origins']`), single-use challenges (`file_gate_webauthn_challenges`, 300 s), signature-counter tracked.
`WebAuthnCredentialStorage` (`file_gate_assurance.webauthn_storage`) persists to the
`file_gate_webauthn_credential` table (unique `credential_id`, index `user_handle`; public key + counter for
assertion). `file_gate_assurance_uninstall()` clears the DPoP-jti and challenge key-value collections; the table
drops with the module schema.
