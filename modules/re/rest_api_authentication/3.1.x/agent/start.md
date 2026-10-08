<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST & JSON API Authentication — agent index

miniOrange module that secures REST / JSON:API endpoints by registering a Drupal
**authentication provider** (`RestAPI`, id `rest_api_authentication`, priority 150). When
`enable_authentication` is `1`, it requires valid credentials (API key / Basic Auth / OAuth /
JWT) on `/jsonapi/` and `?_format=` requests. All state is the **`rest_api_authentication.settings`**
config object. Config UI: `/admin/config/people/rest_api_authentication/auth_settings` (route
`rest_api_authentication.auth_settings`, permission `administer site configuration`).

- **Config keys (`enable_authentication`, `applications`, `authentication_method`, `api_token`…), the admin forms** →
  [configure/settings.md](configure/settings.md)
- **How the auth provider works: `applies()`, the `auth-method` header, method ids, validators, revoke endpoint** →
  [api/auth-provider.md](api/auth-provider.md)

Key facts:
- No permissions of its own (forms gate on core `administer site configuration`); no plugins,
  no Drush. Provides config schema and a DB-backed audit logger (`rest_api_authentication.logger`).
- Auth method ids: `0` basic_auth, `1` api_key, `2` oauth, `3` jwt, `4` external_oauth.
- OAuth/JWT/headless-SSO/multi-application are premium miniOrange features; the config surface
  and provider mechanics are inspectable offline (no external calls needed to read them).
- Install-default config sets only miniOrange customer/licensing fields; `enable_authentication`
  is unset until you turn protection on.
