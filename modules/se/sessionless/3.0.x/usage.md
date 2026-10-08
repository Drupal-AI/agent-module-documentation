<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sessionless provides an API for sessionless (stateless) features via cryptographic tokens.

---

Sessionless API provides an API for sessionless features via cryptography — enabling stateless flows where a cryptographically-signed token carries the needed state instead of a server session, useful for high-scale or decoupled scenarios where avoiding session storage is desirable.

Because it relies on cryptographic tokens, the signing key/material must be stored securely (env-backed) and token validation must be correct; it's a developer/security building block with no content role of its own. Supports Drupal 10 and 11.

---

- Provide a sessionless API.
- Enable stateless flows.
- Carry state in signed tokens.
- Avoid server sessions.
- Suit high-scale/decoupled scenarios.
- Use cryptographic tokens.
- Store signing material securely (env-backed).
- Require correct token validation.
- Act as a developer/security building block.
- Carry no content role.
- Support Drupal 10 and 11.
- Support stateless features.
- Sign tokens
- Validate tokens
- Avoid session storage.
- Support scaling.
- Handle crypto tokens.
- Provide statelessness
