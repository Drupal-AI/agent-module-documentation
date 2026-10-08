# Plausible — agent index

Adds the Plausible Analytics tracking `<script>` to page heads with page/role/admin-route visibility
rules, and embeds the Plausible dashboard in Drupal. Config object `plausible.settings`; settings form
`plausible.admin_settings_form` (*Config › Web services › Plausible*, `/admin/config/services/plausible`).
No external deps; Gin/Markdown optional. No Drush.

- **All settings keys, visibility rules, snippet versions, dashboard, permissions, cache** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Snippet injected by `plausible_page_attachments()` in `plausible.module`; two generations:
  `script.version = october-2025` (new: `plausible.init()`) vs legacy (`data-domain`/`data-api`).
- Visibility: `visibility.enable` (global), `request_path_mode`/`request_path_pages` (by path),
  `user_role_mode`/`user_role_roles` (by role), `admin_route_mode` (admin pages). Modes are ints
  (0 = off/all, 1 = exclude-listed, 2 = only-listed).
- 403/404 custom events via `events.403` / `events.404`.
- Permissions (`plausible.permissions.yml`): `administer plausible configuration` (settings form),
  `view plausible dashboard` (`/admin/reports/plausible`, iframe of `dashboard.shared_link`).
- Custom cache context service `cache_context.route.is_admin` (`RouteIsAdminCacheContext`); contexts
  added only when the matching visibility mode is active.
