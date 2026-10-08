<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JWT Path Authentication — agent index

Authenticates requests carrying a JWT in the `?jwt=` query string, but only on
whitelisted path prefixes (default private files). Depends on `jwt`.

- **The allowed-paths config, route & form, how to read/set the prefix list** →
  [configure/paths.md](configure/paths.md)
- **How the provider matches (query param, path prefix, required token claims)** →
  [api/provider.md](api/provider.md)

Key facts:
- Config object `jwt_path_auth.config` -> `allowed_path_prefixes` (sequence of strings),
  shipped default `['/system/files/']`. Each prefix must start with `/`.
- Config form route `jwt_path_auth.config_form` at `/admin/config/system/jwt/path-auth`
  (permission `administer jwt`). Module `configure` in info.yml is unset (null).
- Auth provider service `jwt_path_auth.authentication.jwt` (id `jwt_path_auth`, global,
  priority 50). Token in `?jwt=`, signed with the site key; required claims
  `drupal.path_auth.uid` and `drupal.path_auth.path`.
