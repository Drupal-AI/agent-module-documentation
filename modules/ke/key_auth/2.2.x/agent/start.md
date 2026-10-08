<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key Authentication (key_auth) — agent index

Adds an authentication provider (`key_auth`, priority 200) that lets a request authenticate
as a Drupal user via a per-user API key, sent as an HTTP header and/or query parameter. Each
user's key lives in an `api_key` base field on the User entity; a request only authenticates
if the matched user's roles have the **`use key authentication`** permission.

- **Site-wide settings** (parameter name, detection methods, key length, auto-generation) and
  the configure route → [configure/settings.md](configure/settings.md)
- **The `key_auth` service, the `api_key` field, and how the auth provider validates a
  request** → [api/service.md](api/service.md)

Key facts:
- Config object `key_auth.settings`; configure route `key_auth.settings` at
  `/admin/config/services/key-auth` (permission `administer site configuration`).
- Default settings: `param_name: api-key`, `key_length: 32`, `detection_methods: [header, query]`,
  `auto_generate_keys: true`.
- A client sends the key as the header named by `param_name` (e.g. `api-key: <key>`) and/or as a
  query parameter `?<param_name>=<key>` (e.g. `?api-key=<key>`), depending on which
  `detection_methods` are enabled.
- Each user manages their own key at `/user/{user}/key-auth` (route `key_auth.user_key_auth_form`).
- No plugins, no Drush commands.
