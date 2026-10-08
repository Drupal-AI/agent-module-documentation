# User Redirect — agent index

Redirects users to a per-role internal/external URL after **login** and **logout**. One
settings form, config object `user_redirect.settings`, one permission, one helper service.
No plugins, no Drush, no config schema (config is created only when you first save the form).

- **Settings form, config keys (`login.<role>`, `logout.<role>`, `ignore`, `ignore_for`),
  where values live, and the permission** → [configure/settings.md](configure/settings.md)
- **How the redirect actually happens (login/logout hooks, the service, role priority,
  internal `destination` vs external `TrustedRedirectResponse`, ignore paths)** →
  [api/service.md](api/service.md)

Key facts:
- Config UI: `/admin/people/users/redirect/form/settings` (route `user_redirect.settings`).
- Permission: `administer user redirect settings`.
- Config lives at `user_redirect.settings` → `login.<role_id>.redirect_url` / `.weight`,
  `logout.<role_id>.redirect_url` / `.weight`, `ignore` (array of path patterns),
  `ignore_for` (map with `login` / `logout`). Default `ignore` seeds `/user/reset/*`.
- Service id: `user_redirect.service` (`Drupal\user_redirect\UserRedirect`).
