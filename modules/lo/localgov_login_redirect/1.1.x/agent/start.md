<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Login Redirect (localgov_login_redirect) — agent index

Sends a user to one admin-configured path after they log in, instead of to `/user/{uid}`.
The whole behavior is `hook_user_login()` in `localgov_login_redirect.module`: it sets the
request's `destination` query parameter to the configured path so core performs the redirect.
Depends on core `user`. Core requirement `^10.2 || ^11`. No permissions, plugins, or Drush of its own.

- **The settings form, the config object + schema, how to set it via Drush/PHP, and exactly what happens at login** → [configure/login-redirect.md](configure/login-redirect.md)

Key facts:
- Config object `localgov_login_redirect.settings`, keys: `enabled` (bool, default `true`),
  `redirect_path` (string, default `/admin/content`).
- Settings form `\Drupal\localgov_login_redirect\Form\LoginRedirectSettingsForm`
  (form id `localgov_login_redirect_settings_form`) at route `localgov_login_redirect.settings`,
  path `/admin/config/system/localgov_login_redirect`, gated by core permission
  `administer site configuration`. Menu link under `system.admin_config_system`.
- The destination is a single global path, not per-role. Different users land in different
  places only because the target is passed through `path.validator`'s `getUrlIfValid()`, which
  access-checks the path for the logging-in user; if they lack access, no redirect is set and
  core's default `/user/{uid}` applies.
- The hook returns early (no redirect) when `enabled` is not `TRUE`, when the current route is
  `user.reset` / `user.reset.login` (one-time login / password-reset links), or when the request
  already carries a `destination` query parameter.
