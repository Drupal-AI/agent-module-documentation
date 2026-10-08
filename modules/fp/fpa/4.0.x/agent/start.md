# fpa — agent index

Fast Permissions Administration enhances Drupal core's permissions page
(`/admin/people/permissions`) with a live client-side filter, a module list, a role
filter, and a status filter. It is a UI enhancement only — no plugins, entities, or
Drush commands. Depends on `js_cookie`.

Key facts:
- Enhanced page: `/admin/people/permissions` (core route `user.admin_permissions`, taken
  over by FPA's `RouteSubscriber` → `FPAController::permissionsList`). Save behavior is
  unchanged from core.
- Filter syntax on that page: `permission@module` (e.g. `admin@system`). Matches on the
  human label OR the system/machine name.
- Settings form: `/admin/config/people/fpa-settings` (route `fpa.settings`), the
  `configure` route. Lets you disable individual UI sections.
- One config object: `fpa.settings`, key `disabled_sections`.
- One permission: `manage fast permissions administration settings`.

Docs:
- [configure/fpa.md](configure/fpa.md) — the settings form, the `fpa.settings` config
  object, `disabled_sections` values, and how to set them by config/drush.
- [permissions/fpa.md](permissions/fpa.md) — the permission FPA defines and the core
  permission that still gates the permissions page itself.
