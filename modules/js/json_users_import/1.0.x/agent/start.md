<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Json Users Import (json_users_import) — agent index
**Admin form that batch-creates active user accounts from pasted JSON, with configurable field mapping and an optional welcome email.**

- **Version:** 1.0.x
- **Core:** ^8.8 || ^9 || ^10 · **Depends:** smtp
- **Routes:** `/admin/people/json_users_import` (import form) and `/admin/config/people/json_users_import_config` (field/email config) — both require `_permission: 'json import users'`.
- **Configure:** `json_users_import.import_configuration`
- **Key code:** `src/Form/JsonUsersImport.php`, `src/Controller/JsonUsersImportController.php` (`createUser()`), batch in `json_users_import.module`.
- **Security (reported):**
  - **No role assignment** — `createUser()` sets accounts active with a random password but never calls `addRole()`; no privesc to elevated roles.
  - **Undefined permission** — no `permissions.yml` ships, so `json import users` is undefined and both forms are effectively user-1-only (locked down, not anon/overbroad).
  - Bulk creation of *active* login-enabled accounts is possible for whoever holds the (currently uid-1-only) access; no anonymous access. Email body is `Html::escape()`d.

See [configure/import.md](configure/import.md).