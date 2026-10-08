<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Gate Assurance gates file delivery behind hardware-backed, phishing-resistant OIDC or WebAuthn assurance.

---

File Gate Assurance is an optional submodule of File Gate that adds an `assurance` gate method: a gated file is
delivered only when a hardware-backed, phishing-resistant assurance level (PIV/CAC or FIDO2/WebAuthn) is proven,
either at any standards-compliant OIDC IdP or natively with File Gate as the WebAuthn relying party. It depends on
`file_gate`; OIDC needs `firebase/php-jwt` and native WebAuthn needs `web-auth/webauthn-lib`. It is
provider-agnostic (OIDC discovery + JWKS): a field lists one or more trusted issuers, each with its own expected
audience and accepted `acr` values, and a presented token is matched to exactly one issuer by its `iss` claim. The
signing algorithm is pinned to the issuer's published JWKS — never the token header — which defeats alg-confusion
and `none`/HMAC; issuer, audience and expiry are enforced against the matched entry only. DPoP (RFC 9449)
sender-constraining and RFC 7662 introspection are opt-in. Verification can run at redemption (live token, Model
B), at mint (trust the stepped-up caller, Model A, optionally with A2 mint-time OIDC), via edge mTLS (a validated
client-certificate subject from a trusted proxy header plus a required allowlist), or via native WebAuthn. A
short-lived HttpOnly session-bridge cookie lets the same signed URL download as an ordinary browser link after a
successful step-up. Enable with `drush en file_gate_assurance`.

---

- Require hardware-backed, phishing-resistant authentication before a gated file downloads (`assurance` method).
- Gate on a PIV/CAC (HSPD-12 / FIPS 201) or FIDO2/WebAuthn assurance level proven at an OIDC IdP.
- Work with any standards-compliant IdP via OIDC discovery + JWKS (provider-agnostic).
- List several trusted issuers per field, each with its own audience and accepted `acr` values.
- Match a token to exactly one issuer by `iss`; never cross-apply another issuer's audience or acr.
- Pin the JWT algorithm to the issuer's published keys, defeating alg-confusion and `none`/HMAC.
- Enforce issuer, audience and a required expiry on every token; empty acr list denies (fail closed).
- Sender-constrain the token with an opt-in DPoP proof (RFC 9449), bound to this exact access token.
- Replay-protect DPoP proofs and require a fresh `iat` within a 60-second window.
- Add a live revocation check with opt-in RFC 7662 token introspection over HTTPS only.
- Verify at redemption (Model B), at mint (Model A / A2), via edge mTLS, or via native WebAuthn.
- Bind an asserted assurance level (`aal`) and an optional subject hash into the signed grant (downgrade-proof).
- Enforce per-user binding: a subject-bound grant only redeems for a token whose subject matches.
- Register and manage WebAuthn security keys per user at `/user/{user}/file-gate-webauthn`.
- Act as the native WebAuthn relying party with a grant-bound assertion ceremony.
- Set a short-lived HttpOnly session-bridge cookie so the same signed URL opens as a normal browser download.
- Use a same-origin Drupal SSO access token (openid_connect) to satisfy the bridge without sessionStorage.
- Trust a validated client-certificate subject from a reverse proxy, with a mandatory subject allowlist.
- Force the IdP to prompt for hardware ACR by appending `acr_values` to a field-configured step-up login URL.
- Block open redirects: the step-up login URL comes only from field config, never from the query string.
