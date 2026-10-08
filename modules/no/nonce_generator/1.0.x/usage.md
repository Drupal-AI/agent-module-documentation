<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Nonce Generator generates nonces.

---

Nonce Generator provides a service to **generate nonces** — one-time/unique tokens — for use by other
modules (e.g. for CSP script nonces, one-time markers, or anti-replay tokens). It is in the Security package.

Use it as a source of nonces in custom code. This is a **security-positive** primitive and it is implemented
correctly: the nonce is `hash('sha256', random_bytes(16))` — seeded from PHP's **`random_bytes()` CSPRNG**
(cryptographically secure), so nonces are unpredictable (verified). It has no access-control role. Use its
service to obtain a nonce.

---

- Generate nonces.
- Provide unique one-time tokens.
- Serve other modules.
- Use random_bytes() (CSPRNG).
- Produce unpredictable nonces.
- Support CSP/anti-replay tokens.
- Be a security-positive primitive.
- Have no access-control role.
- Use its service for a nonce.
- Handle nonce generation.
- Generate tokens.
- Provide the service.
- Create nonces.
- Handle the generator.
- Produce nonces.
- Use the CSPRNG.
- Handle tokens.
- Generate secure tokens.
- Obtain a nonce.
- Provide nonces.
