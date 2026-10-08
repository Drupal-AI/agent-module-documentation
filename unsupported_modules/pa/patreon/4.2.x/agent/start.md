<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Patreon (patreon) — agent index

**Connects Drupal to the Patreon API (creator data, campaigns) with submodules for patron login and role assignment.**

- **Version:** 4.2.x
- **Core:** ^10 || ^11
- **Submodules:** `patreon_user` (patron login + roles), `patreon_extras` (tokens/helpers)
- **Permissions:** `administer patreon`
- **Routes:** `patreon.settings_form` (`/admin/config/services/patreon/settings`, `administer patreon`); `patreon.patreon_controller_oauth_callback` (`patreon/oauth`, `administer patreon`, verifies OAuth `state`); submodule `patreon_user.patreon_user_controller_oauth` (`/patreon_user/oauth`, **`_access: 'TRUE'`**)
- **Service:** `patreon.api` → `PatreonService`
- **Configure:** `patreon.settings_form`

**Security:** Admin API/config routes are gated by `administer patreon` and the parent OAuth callback validates `state` against the session. However the `patreon_user` submodule login callback `/patreon_user/oauth` is `_access:'TRUE'`, reads only `?code=`, and `user_login_finalize()`s with **no `state`/CSRF check** → login CSRF on patron sign-in (patreon/modules/patreon_user/src/Controller/PatreonUserController.php:~74-95). Anonymous-only guard and login-mode settings apply, but the state check is missing.

See [api/service.md](api/service.md)
