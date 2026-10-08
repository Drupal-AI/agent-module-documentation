<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Persistent Login — agent index

Adds a "Remember me" checkbox to the login form and keeps the user signed in with its own
hashed, single-use cookie token, independent of the PHP session lifetime.

Key facts:

- Config object **`persistent_login.settings`**; form route `persistent_login.settings` →
  `/admin/config/system/persistent_login` (permission `administer site configuration`).
  Keys: `lifetime`, `extend_lifetime`, `max_tokens`, `login_form.field_label`, `cookie_prefix`.
- Own database table **`persistent_login`** (`uid, series, instance, created, refreshed,
  expires`), values hashed with `Crypt::hashBase64`.
- Services: `persistent_login.token_manager`, `persistent_login.token_handler` (a global
  `authentication_provider` at priority **1**, above cookie auth) and
  `persistent_login.cookie_helper`.
- **No permissions of its own, no plugin types, no Drush commands.**
- **Install requirement:** `session.storage.options.cookie_lifetime` must be `0` in
  `services.yml`, otherwise `hook_requirements()` reports an error.
- Per-user list of active tokens: `/user/{uid}/persistent-logins`.

Docs:

- **All settings keys, drush recipes, the cookie name rules** →
  [configure/settings.md](configure/settings.md)
- **Services, token lifecycle, authentication flow, cache interaction** →
  [api/tokens.md](api/tokens.md)
