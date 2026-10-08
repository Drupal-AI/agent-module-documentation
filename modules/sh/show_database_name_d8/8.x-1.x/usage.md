<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Show Database Details shows the current DB host/name in the toolbar, a block and the status report.

---

Show Database Details (on-disk `show_database_name_d8`, machine name `show_database_name`) reads the default database connection info and surfaces the host and database name in three places: a toolbar item (`hook_toolbar`), a 'Database Host & Name' block, and the runtime status report (`hook_requirements`). Every surface checks the `access database information` permission (declared `restrict access: TRUE`), so the infrastructure detail is only shown to explicitly-trusted roles. Useful for telling environments apart. Depends on core `block`.

---

- Tell which database an environment is using.
- Show DB host + name in the admin toolbar.
- Place a block showing DB host and name.
- Add DB host/name to the status report.
- Distinguish prod/stage/dev at a glance.
- Restrict visibility to a trusted permission.
- Link the toolbar item to the status report for admins.
- Avoid guessing connection details during ops.
- Help debugging of multi-DB setups.
- Gate exposure with `restrict access: TRUE`.
- Require core block module.
- Run on Drupal 8, 9 and 10.
- Cache the toolbar item per user permissions.
- Provide a lightweight environment indicator.
- Keep infrastructure detail off anonymous pages.
- Read connection info from Database::getConnectionInfo.
