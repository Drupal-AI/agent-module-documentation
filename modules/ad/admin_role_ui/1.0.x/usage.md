<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Role UI overrides Drupal core to align the administrator-role UI with how admin roles work in code (the is_admin flag), preventing admins from locking themselves out.

---

Install the module. It alters the core role settings form (role_settings) to disable the core 'Administrator role' selector and instead shows which roles currently have is_admin set. Admin roles are then managed via configuration (the is_admin flag) rather than the UI.

---

- Disable the core 'Administrator role' selector.
- Prevent admins from inadvertently locking themselves out.
- List roles that currently have is_admin true.
- Align the UI with code-based admin role config.
- Alter the role_settings form via hook_form_alter.
- Hide the submit button when only the admin role remains.
- Link to help for changing the administrator role.
- Manage admin status via the is_admin config flag.
- Query user_role storage for is_admin roles.
- Provide help text explaining the behaviour.
- Serve as an administration/UX safeguard.
- Require no additional permissions of its own.
- Work with core user roles.
- Reduce lockout risk on multi-admin sites.
- Surface admin-role state to site builders.
- Complement configuration management workflows.
- Have no routes or services of its own.
- Act purely as a form/UI override.
