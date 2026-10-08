<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Assurance — the `assurance` method, verifier & verification modes

The assurance field settings appear on each gated file/image field's edit form; global File Gate defaults live at
the settings form below.

![File Gate global settings](../../../../../../../../../screenshots/file_gate/1.10.x/settings-form.png)

## The gate method — `Assurance`
`src/Plugin/GateMethod/Assurance.php`, `#[GateMethod(id: 'assurance', …)]`, `final`, **extends `SignedUrl`** and
implements `ContextualMintInterface`, `ChallengeAwareGateMethodInterface`, `MintTimeOidcInterface`.

- `grants()` checks assurance **first** (`assuranceSatisfied()`), then delegates to `parent::grants()` (the HMAC
  signature + usage burn) — so a failed assurance never spends a one-time link.
- `extraMintClaims()` binds `aal` (asserted level) and, when a subject is asserted, `sh = sha256(subject)`;
  `signedClaimKeys()` adds `aal` + `sh` so both are tamper-proof and cannot be downgraded/swapped.
- `mintWithContext()` reads a caller-asserted `subject` from the mint body (or the A2 verified sub) and binds only
  its hash; a wrong subject gains nothing because redemption still needs a valid token for it.

## Verification modes — field `verify_at`
- **`redeem` (Model B)** — `liveOidcSatisfied()`: verify a live Bearer/DPoP token at download, enforce the matched
  issuer's acr, optional `required_amr`, optional per-user `sh` binding (`hash_equals`), optional introspection.
- **`mint` (Model A)** — trust the stepped-up caller; the asserted level is bound in the signature (verified by
  `parent::grants`), no live check at redeem. Optional **A2** (`verify_oidc_at_mint`): `assertMintTimeOidc()`
  requires a Bearer/DPoP token at mint whose aud matches the field, with sufficient acr (fail closed).
- **`client_cert`** — edge mTLS: `clientCertSatisfied()` trusts a validated cert subject from
  `trusted_proxy_header`, but **fails closed without a non-empty `allowed_subjects` allowlist** (the header is
  spoofable off-proxy; network isolation is the primary control).
- **`webauthn`** — native RP; only the session-bridge cookie (set after a WebAuthn assertion) satisfies the gate.

A short-lived **session-bridge** cookie (`SessionBridge`, on by default) lets the plain signed URL download
without an Authorization header after a successful step-up — see [api/webauthn-and-bridge.md](../api/webauthn-and-bridge.md).

## The verifier — `AssuranceVerifier`
Service `file_gate_assurance.verifier`. `verify(token, config, request)`:
1. Build a `TrustedIssuerSet` from field settings; an empty/incomplete/duplicate-issuer set is invalid → refuse
   everything (logged as a config error).
2. Validate the header `alg` is an allowed **asymmetric** algorithm (ES*/RS*/PS*/EdDSA — never `none`/HMAC).
3. Peek the **unverified** `iss` only to select the matching configured entry (never used as a URL).
4. Load the matched entry's JWKS via OIDC discovery on the **configured** issuer (cached 1 h; one refetch on
   rotation) — so a forged `iss` cannot point verification at attacker keys (no SSRF).
5. `JWK::parseKeySet($jwks, $alg)` pins each key's algorithm; `JWT::decode` rejects `none`, HMAC, and any
   header/key alg mismatch (alg-confusion defense — important because File Gate also holds an HMAC secret).
6. Re-check signature-verified `iss` == entry issuer; require the matched entry's `audience` in `aud`; require an
   `exp` claim.
7. If `dpop`: verify the RFC 9449 proof (`verifyDpopProof()` — asymmetric alg, embedded jwk, htm/htu match, fresh
   `iat` within 60 s, unreplayed `jti`, and `ath` = base64url sha256(token) via `hash_equals`) and require the
   token's `cnf.jkt` to equal the proof's JWK thumbprint (rejects a stolen bearer token).

Returns `{sub, acr, amr, issuer, required_acr}` (the matched entry's own acr list). `acrSatisfied()` requires the
token `acr` to be on that list; an empty list denies (never falls back to the union).

`introspect()` (RFC 7662, opt-in) POSTs the token to `introspection_endpoint`, **HTTPS-only** (or explicit
loopback for dev), with the env-injected `file_gate.settings:introspection_client_secret`; returns `active`.

## Trusted issuers — `TrustedIssuerSet` / `TrustedIssuer`
A field lists up to four issuers (`trusted_issuers`, or the legacy single `issuer`/`audience`/`required_acr`
keys — migrated on save). Each is `{issuer, audience, required_acr[]}`. `isValid()` requires ≥1 entry, every entry
to have an issuer + audience, and no duplicate issuer. `match($iss)` returns the single byte-exact entry.
`acrUnion()` is used **only** for challenge advertisement (WWW-Authenticate acr_values, step-up URL), never for
enforcement.

## Key field settings (from `fieldSettingsForm`/`fieldSettingsValidate`/`fieldSettingsSubmit`)
`verify_at`, `aal`, `trusted_issuers[]` (issuer/audience/required_acr; validated: absolute http(s) issuer, unique,
audience + ≥1 acr required), `required_amr[]`, `bridge` + `bridge_ttl`, `step_up_login_url` (field-only; open-
redirect-safe) + `step_up_append_acr`/`step_up_acr_param`, `session_bridge_sso`, `verify_oidc_at_mint`,
`dpop` + `htu_origin`, `introspect` + `introspection_endpoint`/`introspection_client_id`, `trusted_proxy_header` +
`allowed_subjects` (mTLS), `rp_id`/`rp_name`/`origins`/`webauthn_user_handle` (WebAuthn), `leeway`. It also
inherits signed_url's `ttl`/`available_until`/`max_uses`/`require_identity_mint`.
