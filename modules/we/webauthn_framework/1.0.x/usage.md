<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WebAuthn Framework adds webauthn-framework as a Drupal service.

---

WebAuthn Framework **wraps the web-auth/webauthn-lib library as a Drupal service** — providing the WebAuthn
building blocks (credential creation/request options, attestation and **assertion verification**) that passkey/
security-key modules build on. It works across core 10–11.

Use it as the base library service for WebAuthn features. It is an authentication-framework module and it is the
**security core** of passkey auth: it performs the WebAuthn ceremony verification (challenge, origin, relying-
party id, signature, user verification, sign counter) via the well-maintained web-auth library — so the security
of dependent passkey modules rests on this being configured/used correctly (correct RP id/origin, HTTPS). On its
own it exposes no user-facing auth; consuming modules wire it up. It has no access-control role of its own.
Depend on it from passkey modules.

---

- Wrap web-auth/webauthn-lib.
- Provide WebAuthn building blocks.
- Verify WebAuthn ceremonies.
- Serve as the passkey base.
- Serve authentication.
- Handle attestation/assertion.
- BE the security core of passkey auth.
- Verify challenge/origin/RP-id/signature/counter.
- Rest security on correct config (RP-id/origin, HTTPS).
- Expose no user-facing auth on its own.
- Have no access-control role of its own.
- Be used by passkey modules.
- Handle WebAuthn.
- Verify assertions.
- Configure via consumers.
- Provide the library.
- Handle the ceremony.
- Support passkeys.
- Configure it correctly.
- Provide the WebAuthn framework.
