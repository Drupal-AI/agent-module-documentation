<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paranoia is a site-hardening module for sysadmins who do not trust CMS admins to safely execute arbitrary PHP: it disables PHP execution, blocks the granting of dangerous permissions, and prevents privilege escalation to the admin/superuser role.

---

On install and thereafter, Paranoia (a) uninstalls the core `php` module (and `skinr_ui`) and hides both PHP and Paranoia itself from the module admin/uninstall pages via `hook_system_info_alter`; (b) strips the "admin" flag from every role (`ParanoiaDefanger::unsetAdminRole()`) and blocks any later attempt to set a role admin through `hook_user_role_presave`, logging an alert; (c) alters the permissions form (`user_admin_permissions`) to remove a banned list of PHP/eval-related permissions and to force every `restrict access: true` permission to stay OFF for Anonymous and Authenticated, and revokes those banned permissions from all roles on submit; (d) hides the admin-role selector on the user account settings form and locks name/mail/password editing of user/1 unless you *are* user/1; (e) disables specified "risky" forms (e.g. `devel_execute_php`) with a hard-fail validator to prevent `unserialize()`-style RCE; and (f) blocks specified routes (e.g. `devel.execute_php`) via a route subscriber. Modules, permissions, routes, and forms to neutralize are all extensible through `hook_paranoia_*` hooks so other modules can register their own risky items. By design it cannot be uninstalled from the UI — remove it with `drush pm:uninstall paranoia` or by deleting the module directory and clearing config cache. It provides one config value, `delete_blocked_users`, and a status-report requirement that errors if the PHP module was force-enabled in the database.

---

- Harden a production site so no admin can run arbitrary PHP through the core PHP module.
- Automatically uninstall and hide the `php` module so it cannot be re-enabled from the UI.
- Prevent granting the `use PHP for settings` / `use text format php_code` permissions to any role.
- Revoke already-granted risky PHP permissions across all roles on install and on each permission-form save.
- Force all `restrict access: true` permissions to stay unchecked for Anonymous and Authenticated roles.
- Block privilege escalation by stripping the "admin" (superuser-equivalent) flag from every role.
- Detect and block any attempt to mark a role as admin, logging a security alert.
- Protect the user/1 superuser account from having its name, email, or password edited by anyone but user/1.
- Hide the admin-role selector on the account settings form so no role can be promoted to admin.
- Disable Devel's "Execute PHP" form and route to prevent one-off PHP execution.
- Disable forms that accept serialized PHP arrays to mitigate `unserialize()` RCE.
- Register additional modules to auto-disable via `hook_paranoia_disable_modules()`.
- Register additional modules to hide from the admin pages via `hook_paranoia_hide_modules()`.
- Register additional permissions to remove from the permissions form via `hook_paranoia_hide_permissions()`.
- Register additional routes to lock down via `hook_paranoia_hide_routes()`.
- Register additional risky forms to disable via `hook_paranoia_risky_forms()`.
- Surface a status-report error when the PHP module has been force-enabled directly in the database.
- Enforce a locked-down security baseline that survives config imports and module installs.
- Remove the `execute php code` (Devel), `use PHP for tracking visibility` (Google Analytics), and similar contrib PHP permissions from the UI.
- Provide a defense-in-depth layer on top of Drupal core's permission model for multi-admin sites.
