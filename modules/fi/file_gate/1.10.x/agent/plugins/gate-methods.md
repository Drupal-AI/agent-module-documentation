<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate — the `GateMethod` plugin type and the five core methods

A **gate method** answers one question: *has this request passed the gate for this file?* It is the pluggable
core of File Gate.

## Plugin type
- Attribute: `\Drupal\file_gate\Attribute\GateMethod(id, label, description)` (`src/Attribute/GateMethod.php`).
- Manager: `plugin.manager.file_gate.gate_method` = `GateMethodManager` (annotation-less attribute discovery,
  namespace `Plugin/GateMethod`).
- Interface: `GateMethodInterface`; base: `GateMethodBase` (provides `label()`/`description()`, a default
  `create()`, and the optional `fieldSettingsValidate()`).
- Optional extra interfaces a method may implement, feature-detected by the mint/download controllers:
  `ContextualMintInterface::mintWithContext()` (bind request-scoped claims at mint),
  `ChallengeAwareGateMethodInterface::challenge()` (return a step-up `Response` when `grants()` fails),
  `MintTimeOidcInterface::assertMintTimeOidc()` (verify an OIDC token at mint).

Contract:
- `grants(FileInterface $file, Request $request): bool` — **must fail closed**; decide access at delivery.
- `mint(FileInterface $file): ?array` — return query params to append to the download URL, or `NULL` for
  live-decision methods (access decided in `grants()`).
- `fieldSettingsForm(array $settings)` / `fieldSettingsSubmit(array $values)` — the per-field UI + normalization.

## Signing (shared by URL methods)
`GrantSigner` (`file_gate.grant_signer`, `GrantSignerInterface`) computes
`HMAC-SHA256(resource_id . "|" . canonical(claims), secret)`. `canonical()` ksorts and `rawurlencode`s every
key/value (injective — no claim-folding bypass). `validate()` fails closed on missing material, requires `exp`
in the future (and `nbf` in the past when present), and compares with `hash_equals`, trying current then retired
keys. The `resource_id` is the file's normalized `private://` URI (`FileResourceIdTrait`), so a grant minted for
one file cannot be replayed against another.

## The five core methods

### `signed_url` (`SignedUrl`)
Mint binds `exp` (`ttl` or global default, capped by `available_until`) and, when `max_uses > 0`, a random `jti`
+ `max`. Redemption reconstructs exactly the signed claim set from the query (`signedClaimKeys()`), validates the
HMAC, re-checks field scope at redemption (narrowing a secret revokes outstanding grants), and — for usage-limited
grants — burns one use under a per-jti lock (`consumeUse()`, fail-closed on lock contention). Usage-limited grants
are indexed in `GrantInventory` for list/bulk-revoke. Field settings: `ttl`, `available_until`, `max_uses`,
`require_identity_mint`.

### `authenticated` (`AuthenticatedAccess`)
`mint()` returns `NULL` (live). `grants()` requires an authenticated user; with a configured role list, the user
must hold at least one. **Empty role list = any logged-in account** (a documented enterprise footgun — prefer an
allowlist for sensitive files). Field setting: `roles`.

### `token` (`Token`)
Mint issues a random bearer `token`, stores only its SHA-256 hash (the revocation gate), and binds the hash into
the signature (`th` claim). Redemption with a `sig` commits to the minted path: derive the hash from the presented
token (never read from the URL), validate the HMAC, check field scope, and consume one use under the token lock
(no live row ⇒ revoked/never-issued ⇒ deny). Without a `sig`, the presented token's hash is matched against the
field's pre-shared campaign-token allowlist (`hash_equals`, optional per-entry `exp`/`max`). Field settings:
`ttl`, `available_until`, `max_uses`, `tokens` (hashes only), `require_identity_mint`.

### `referrer_lock` (`ReferrerLock` extends `SignedUrl`)
Adds an Origin/Referer allowlist **before** the inherited signature check (a disallowed origin never burns a use).
Documented as hardening, not authorization — the header is spoofable, the signature is the boundary. Empty
allowlist denies (fail closed); `on_missing_referrer` picks deny/allow when no origin is parseable. Field
settings: signed_url's + `allowed_origins`, `on_missing_referrer`.

### `otp` (`Otp`)
`mint()` returns `NULL`; the code is issued by `POST /api/file-gate/otp` and redeemed at download via `email`+`otp`
query or (preferred) the `FG_OTP` cookie from `POST /api/file-gate/otp/session`. Codes are CSPRNG numeric, stored
only as an HMAC keyed with the authenticated secret material, single-use, TTL-limited, and attempt-locked;
comparison uses `hash_equals`. Field settings: `ttl` (≥30), `max_attempts`, `code_length` (4–10).

## Submodule methods
`form` (file_gate_form), `commerce` (file_gate_commerce), and `assurance` (file_gate_assurance) register the same
way and are documented under each submodule's `1.10.x/` docs.

## Implementing a custom method
Create a class in your module's `Plugin/GateMethod`, add `#[GateMethod(id: 'my_method', label: …, description: …)]`,
extend `GateMethodBase` (or `SignedUrl` to inherit HMAC signing), implement `grants()` (fail closed) and `mint()`,
and expose options via `fieldSettingsForm()`/`fieldSettingsSubmit()`. It appears automatically in the field-config
method select. If you bind extra signed claims, override `extraMintClaims()` **and** `signedClaimKeys()` so
redemption reconstructs the exact signed payload (any missing/extra key fails the HMAC closed).
