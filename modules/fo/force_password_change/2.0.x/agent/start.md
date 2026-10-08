<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Force Password Change — agent index

Forces users to change their password by **role**, **individual user**, **first login**, or
**timed expiry**. Enforced on next page load (default) or next login (`check_login_only`).
Settings form: `/admin/config/people/force_password_change` (route `force_password_change.admin`).

- **Settings keys, config object, disabling in settings.php, DB tables, `user.data` keys** →
  [configure/settings.md](configure/settings.md)
- **Force a change from code (the service) and how a pending force is stored/checked** →
  [api/service.md](api/service.md)
- **The one permission and what it gates** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `force_password_change.settings`: `enabled`, `check_login_only` (bool: every page vs login-only),
  `first_time_login_password_change`, `expire_password`, `installation_date`.
- A pending force for a user is `user.data` module `force_password_change`, key `pending_force` = 1.
- Emergency off-switch: `$config['force_password_change.settings']['enabled'] = FALSE;` in `settings.php`.
- No Drush commands, no plugins. Custom DB tables: `force_password_change_roles`, `_expiry`, `_uids`.
