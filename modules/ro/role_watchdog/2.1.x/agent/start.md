<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Role Watchdog — agent index

Automatically logs every user-role add/remove as a `role_watchdog` entity, shows a per-user role-history
tab, and optionally mirrors to dblog and/or emails watched-role changes. Depends on core `user` + `views`.
Config UI at `admin/config/people/role_watchdog` (`configure` route
`role_watchdog.role_watchdog_settings_form`).

- **Settings form + config keys (dblog mirror, monitor roles, notify email) and how logging/notification fire** →
  [configure/settings.md](configure/settings.md)
- **Permissions this module defines vs. the entity-CRUD permissions it references but doesn't declare** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Capture: `role_watchdog_user_update/insert/delete` diff `$account` roles and call
  `role_watchdog_save_entity()` (action `ROLE_ADDED`=1 / `ROLE_REMOVED`=0, actor uid, target uid, rids).
- Config `role_watchdog.settings`: `role_watchdog_use_watchdog` (bool, mirror to logger — default true),
  `role_watchdog_monitor_roles` (sequence), `role_watchdog_notify_email` (string).
- Notifications send only when `role_watchdog_notify_email` is non-empty (`hook_mail` key `notification`).
- Bundled Views: `role_watchdog_history`, `track_role_history`, `track_role_grants`.
