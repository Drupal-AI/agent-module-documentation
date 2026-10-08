<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A block that outputs a signed JWT for the current user/context.

---

JWT Block provides a block that outputs a signed JSON Web Token — so a page can embed a JWT (for the current user/context) that a client-side app or an external service consumes to authenticate, bridging server-side identity to a JS frontend.

The signing is handled by the JWT module (keys via the Key module, env-backed); scope the token's claims and lifetime carefully, and cache the block per-user. Depends on core `block`, `key`, and `jwt`; supports Drupal 10 and 11.

---

- Output a signed JWT in a block.
- Provide a token for the current context.
- Bridge server identity to a JS app.
- Let clients/services authenticate.
- Sign via the JWT module.
- Manage keys via the Key module.
- Scope claims/lifetime carefully.
- Cache per-user.
- Depend on core `block`, `key`, `jwt`.
- Support Drupal 10 and 11.
- Aid decoupled auth.
- Embed tokens
- Support Drupal.
- Support Drupal.
- Support Drupal.
