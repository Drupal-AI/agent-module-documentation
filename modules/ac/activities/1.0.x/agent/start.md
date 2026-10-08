<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activities — agent index

Logs user **create / update / delete / view** operations on entities into a `user_activities`
content entity (an audit trail). You opt in per entity type + operation (+ optional bundles).
Depends on `views`. Configure route: `activities.config_form` (`/admin/config/activities`).

- **Choose what to log (per entity type/op/bundle), view-throttle security, purge settings,
  routes & permissions** → [configure/settings.md](configure/settings.md)
- **Services (logger / manager / purge), the `user_activities` entity, the alter hook, Views
  plugins** → [api/services.md](api/services.md)

Key facts:
- All config in **`activities.settings`** (ships empty → nothing is logged until you enable it):
  per-entity-type maps like `node: {create: create, update: update, delete: 0, view: 0,
  bundles: [...]}`, plus `security.view_throttle_window` (int, default 60) /
  `security.exclude_anonymous_views` (bool, default true), plus a `purge` map
  (`purge_method` = `never`|`time_based`|`count_based`, `time_value`, `time_unit`,
  `count_limit`).
- Logging is driven by core entity hooks; an op is logged only when its config value is
  non-zero. Purging runs on cron.
- Permissions: `can view users activity`, `administer users activity`,
  `purge activities` (restricted).
- Submodule **activities_data_export** adds a Views page + CSV/XLS export (documented
  separately under `modules/activities_data_export/`).
