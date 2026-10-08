<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT Authentication Consumer — agent index

The submodule that makes a signed JWT actually log a user in. One event subscriber,
zero configuration — enabling it is the whole setup.

- **How a token maps to a user (claims, order, blocking) & how to wire the auth on an endpoint** →
  [api/authentication.md](api/authentication.md)

Key facts:
- Service `jwt_auth_consumer.subscriber` (`JwtAuthConsumerSubscriber`) subscribes to
  `JwtAuthEvents::VALIDATE` (validate + back-fill uid) and `::VALID` (load account).
- Identity claim lookup order: nested `drupal.uid` -> `drupal.uuid` -> `drupal.name`
  (first populated wins). Missing user or blocked user => token invalidated.
- No config, no schema, no permissions, no routes. Depends on `jwt` (and thus `key`).
- Requires a signing key configured on the base module (`jwt.config` key_id) to verify tokens.
