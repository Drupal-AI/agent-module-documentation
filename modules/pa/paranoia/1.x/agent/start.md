<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paranoia — agent index

Security-hardening module. Disables PHP execution, blocks risky/`restrict access` permission grants, strips the admin-role flag (privilege-escalation guard), protects user/1, and disables risky forms/routes. No config UI (`configure` null), no permissions of its own. Provides a config schema (`paranoia.settings`) and a runtime status requirement. Hardening runs automatically via hooks — enabling the module *is* the setup.

- **What it disables/hides, the `delete_blocked_users` setting, install behavior, and how to uninstall (drush only)** → [configure/hardening.md](configure/hardening.md)
- **Extension hooks to register more modules / permissions / routes / forms to neutralize** → [hooks/extend.md](hooks/extend.md)

Key facts:
- Uninstalls & hides `php` and `skinr_ui`; hides `paranoia` itself from module admin/uninstall forms.
- Removes admin flag from all roles; `hook_user_role_presave` blocks re-adding it and logs an alert.
- Permissions form: banned PHP permissions removed; every `restrict access: true` perm forced OFF for Anonymous/Authenticated; banned perms revoked from all roles on submit.
- Disables Devel `devel_execute_php` form + `devel.execute_php` route by default.
- Not uninstallable from the UI by design: `drush pm:uninstall paranoia`.
