<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission watchdog (permission_watchdog) — agent index

Logs changes to **role permissions** made on the core permissions form: which permission was
**added/removed**, on which role, by which user, when. Stores each change as a `role_change_log`
content entity and exposes the history as an admin Views report. Version **2.1.0**
(doc dir `2.x`). Core `^10.3 || ^11`. License GPL-2.0-or-later. No hard module dependencies
(the report needs core **Views**, shipped as `config/optional`; **Devel** is an optional suggest).

## What it provides (from source)

- **Hooks** — `Drupal\permission_watchdog\Hook\PermissionWatchdogHooks` (autowired service, invoked
  via `#[LegacyHook]` shims in `permission_watchdog.module`):
  - `form_user_admin_permissions_alter` — snapshots tracked roles' current permissions into the form
    and adds a submit callback that diffs and writes the log.
  - `form_views_exposed_form_alter` — turns the report's `role` filter into a role select.
- **Content entity** `role_change_log` (`src/Entity/RoleChangeLog.php`, base table `role_change_log`):
  base fields `role` (→ `user_role`), `uid` (→ `user`), `timestamp`, `actions` (unlimited
  `permission_action` items). Constants `PERMISSION_ADDED='added'` / `PERMISSION_REMOVED='removed'`.
- **Field type** `permission_action` (`no_ui`, `src/Plugin/Field/FieldType/PermissionActionItem.php`)
  — two columns `permission`/`action`; and **formatter** `permission_action_default`
  (`src/Plugin/Field/FieldFormatter/PermissionActionDefaultFormatter.php`).
- **Settings form** `SettingsForm` at route `permission_watchdog.settings`
  (`/admin/config/people/permission-watchdog`); config object `permission_watchdog.settings`.
- **Report** — Views view `roles_change_log`, page display at `/admin/reports/permission-watchdog`.
- **Permissions** — `administer permission_watchdog configuration` (restrict access) gates settings;
  `access permission_watchdog report` gates the report.
- **Devel integration** — `RoleChangeDevelGenerate` plugin (id `role_change`) generates sample logs.
- `hook_requirements()` (`.install`) warns on the status report if not all roles are monitored.

## Solution docs

- **Configure which roles are watched (settings, config, schema, requirements)** →
  [config/settings.md](config/settings.md)
- **How changes are captured (hooks, entity, field type)** →
  [logging/capture.md](logging/capture.md)
- **The report route, its permission, and how entries render** →
  [logging/view.md](logging/view.md)
