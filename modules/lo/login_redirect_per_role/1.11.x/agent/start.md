<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Login And Logout Redirect Per Role — agent index

Redirects a user after **login** or **logout** to a URL chosen by their **role**, with a
per-role **priority (weight)**. One admin form, one config object, one service, two hooks.
No permissions of its own (uses core *administer site configuration*), no Drush, no plugins.

- **Configure redirects / read where they are stored** (config object, keys, route, drush) →
  [configure/redirect-settings.md](configure/redirect-settings.md)
- **How the redirect actually happens** (service, `hook_user_login`/`hook_user_logout`,
  weight-based priority, `destination`, URL formats, skipped routes) →
  [api/service.md](api/service.md)

Key facts:
- Config object: **`login_redirect_per_role.settings`**, top-level keys **`login`** and
  **`logout`**, each a map `role_id → { redirect_url, allow_destination, weight }`.
- It ships **no** `config/install` default — the object does not exist until the form is
  saved (or you write it). Empty/absent config = default Drupal behavior.
- Configure route: `login_redirect_per_role.redirect_url_admin_settings`
  → `/admin/people/login-and-logout-redirect-per-role`.
- Lowest `weight` wins; the **first** role the user has with a **non-empty** `redirect_url`
  decides the destination.
