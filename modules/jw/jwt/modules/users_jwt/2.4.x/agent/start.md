<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Users' JWT Authentication — agent index

Lets each Drupal user register RSA/Ed25519 **public keys** and authenticate by signing a
JWT with the matching private key. Global `authentication_provider`
`users_jwt.authentication.jwt` (provider_id `users_jwt_auth`, priority 150) reads a raw JWT
from `Authorization: UsersJwt <token>` (fallback `JWT-Authorization: UsersJwt <token>`),
uses the token header's `kid` to look up the signing user's stored key, verifies the
signature and that `alg` matches, then loads the user named in the payload's `drupal.uid` /
`drupal.uuid` / `drupal.name` claim — requiring that user's uid to match the key's owner.
No permissions.yml (uses `_entity_access: user.update`); no Drush; no plugins.

- **The per-user key repository (`users_jwt.key_repository`), the `UsersKey` object, and
  how keys live in `user.data`** → [api/key-repository.md](api/key-repository.md)
- **The `users_jwt.config` `max_expiration` setting: what it is and its current (unwired)
  status** → [configure/max-expiration.md](configure/max-expiration.md)

Key facts an agent should not have to re-derive from source:

- Keys are stored in the core `user.data` store, module name `users_jwt`, keyed by a
  globally-unique key ID (`kid`) — not by uid, so `getKey($id)` is a direct lookup.
- A JWT must carry `iat` and `exp`, and `exp - iat` must not exceed 24 hours
  (`UsersJwtAuth::authenticate()`), regardless of `users_jwt.config`.
- The module has **no `config/install`**, so `users_jwt.config` does not exist until
  something (a form, `drush cset`, or code) creates it.
- Per-user UI: `/user/{user}/jwt-keys` (list/add/generate/edit/delete), gated by
  `_entity_access: user.update` — no custom permission.
