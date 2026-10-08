<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST & JSON API Authentication — agent index

miniOrange module that secures REST / JSON:API endpoints by registering a Drupal
**authentication provider** (`RestAPI`, id `rest_api_authentication`, priority 150). When
`enable_authentication` is `1`, it requires valid credentials (API key / Basic Auth / OAuth /
JWT) on `/jsonapi/` requests and requests carrying a `_format` query parameter. All state is the
**`rest_api_authentication.settings`** config object. Config UI:
`/admin/config/people/rest_api_authentication/auth_settings` (route
`rest_api_authentication.auth_settings`, permission `administer site configuration`).

- **Config keys (`enable_authentication`, `applications`, `authentication_method`, `api_token`, `custom_header`…), the admin forms** →
  [configure/settings.md](configure/settings.md)
- **How the auth provider works: `applies()`, the `auth-method` header, method ids, validators, revoke endpoint** →
  [api/auth-provider.md](api/auth-provider.md)

Key facts:
- No permissions of its own (forms gate on core `administer site configuration`); no plugins,
  no Drush. Provides config schema and a DB-backed audit logger (`rest_api_authentication.logger`)
  writing to the `rest_api_authentication_logs` table.
- Auth method ids: `0` basic_auth, `1` api_key, `2` oauth, `3` jwt, `4` external_oauth. The
  free surface handles `0` and `1`; `2`/`3`/`4` fall through (premium miniOrange features).
- The request gate (`applies()`) matches on the routed path (`getPathInfo()`) for `/jsonapi/`
  and on `$request->query->has('_format')` — not raw-URI substring matching. A functional test
  (`tests/src/Functional/RestApiFormatGateBypassTest.php`) pins this so a REST request is gated
  regardless of query-parameter order.
- API-key validation loads the user by name, rejects blocked users, and compares the presented
  token to `api_token` with constant-time `hash_equals()`. Basic auth defers to core `user.auth`.
- `/rest_api/revoke` is `_access: 'TRUE'` but Basic-Auth-gated, flood rate-limited
  (5 failures / 300s / IP), and POST-only inside the controller; it returns a premium notice.
- Application management controllers (`delete-application`, `set-default-application`) validate a
  CSRF token before mutating config.
- OAuth/JWT/headless-SSO/multi-application/token-revocation are premium miniOrange features; the
  config surface and provider mechanics are inspectable offline (no external calls needed to read them).
- Install-default config sets only miniOrange customer/licensing fields; `enable_authentication`
  and `api_token` are unset until you turn protection on and configure a method.
