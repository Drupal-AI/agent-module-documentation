<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Gate Assurance (file_gate_assurance) — agent index

Optional submodule of **File Gate** adding the `assurance` gate method: deliver a gated file only when a
hardware-backed, phishing-resistant assurance level (PIV/CAC or FIDO2/WebAuthn) is proven at an OIDC IdP or
natively. Version **1.10.x**, core `^11.4 || ^12`, package Security. Depends on `file_gate:file_gate`; OIDC needs
`firebase/php-jwt`, native WebAuthn needs `web-auth/webauthn-lib`. Enable with `drush en file_gate_assurance`.

## Provides
- **Gate method** `assurance` — `\Drupal\file_gate_assurance\Plugin\GateMethod\Assurance` (extends `SignedUrl`,
  implements `ContextualMintInterface`, `ChallengeAwareGateMethodInterface`, `MintTimeOidcInterface`). Binds the
  asserted `aal` and an optional subject-hash `sh` into the signed grant; checks assurance **before** the
  inherited signature so a failure never burns a usage-limited grant.
- **Verifier** `file_gate_assurance.verifier` = `AssuranceVerifier` (`AssuranceVerifierInterface`) — OIDC + DPoP.
- **Services** `file_gate_assurance.session_bridge` (`SessionBridge`, `FG_AB` cookie),
  `.session_oidc_token` (`SessionOidcToken`, duck-typed openid_connect), `.step_up_authorize_url`
  (`StepUpAuthorizeUrl`, open-redirect-safe URL builder), `.webauthn_ceremony` (`WebAuthnCeremony`),
  `.webauthn_storage` (`WebAuthnCredentialStorage`, table `file_gate_webauthn_credential`).
- **Permission** `register file gate webauthn` — register/manage WebAuthn credentials.
- **Routes** (`file_gate_assurance.routing.yml`): `step_up` (GET HTML), `bridge` (POST), the WebAuthn register/
  assert/credentials endpoints, and the enrollment form `/user/{user}/file-gate-webauthn`.

## Verification modes (field `verify_at`)
- `redeem` (Model B) — live OIDC token at download (or via the bridge).
- `mint` (Model A) — trust the stepped-up caller; the asserted `aal` is bound into the signature (optionally A2:
  `verify_oidc_at_mint` verifies a Bearer/DPoP token at mint).
- `client_cert` — edge mTLS: a validated cert subject from a trusted proxy header, with a **required** allowlist.
- `webauthn` — File Gate is the native WebAuthn RP; only the bridge (after an assertion) satisfies the gate.

## Solution docs
- [The `assurance` method, trusted issuers, verifier & verification modes](plugins/assurance.md) — OIDC/DPoP
  verification, acr enforcement, trusted-issuer set, field settings.
- [Step-up, session bridge & WebAuthn endpoints](api/webauthn-and-bridge.md) — routes, the plain-link bridge, and
  the WebAuthn registration/assertion ceremony.
