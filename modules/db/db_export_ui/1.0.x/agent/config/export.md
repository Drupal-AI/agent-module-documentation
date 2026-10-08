<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# db_export_ui — export form, service, route & operation

## Install / enable

```
drush en db_export_ui -y
```

Depends only on core `system`. Requires the `mysqldump` and `gzip` binaries to be on `PATH` for
the web-server user (the service falls back to `/opt/homebrew/bin/mysqldump` if that file exists).
MySQL/MariaDB only. No `config/install`, no `config/schema`, nothing to configure beyond the
permission — `data.json`'s `configure` route simply reopens the export form.

## Route & permission

- Route `db_export_ui.form` — `GET /admin/config/development/db-export`, `_form =>
  \Drupal\db_export_ui\Form\DatabaseExportForm`, `_title: 'Database Export'`
  (`db_export_ui.routing.yml`).
- Requirement: `_permission: 'administer db exports'`
  (`db_export_ui.permissions.yml`: title *Administer DB exports*, description *Export and
  sanitize database dumps.*). This is a single dedicated permission — grant it only to trusted
  administrators; it authorizes generating a full database dump.
- Menu link `db_export_ui.form` places it under *Configuration › Development*
  (`system.admin_config_development` parent, `db_export_ui.links.menu.yml`).

## The form — `Form\DatabaseExportForm`

- `FormBase`, id `db_export_ui_form`, DI-constructed via `create()` pulling
  `db_export_ui.database_export`.
- `buildForm()` renders exactly two elements: a `sanitize_users` checkbox (`#default_value =>
  TRUE`) and an *Export Database* submit button. Being a `FormBase`, POST is CSRF-token
  protected by core.
- `submitForm()` builds `['sanitize_users' => <bool>]` and calls
  `$this->exportService->export($options)`, then prints two status messages including the
  returned file path via `messenger()`.

## The service — `Service\DatabaseExportService`

Service id `db_export_ui.database_export`, `autowire: true` (`db_export_ui.services.yml`),
constructed with core `FileSystemInterface` and `Connection`.

`export(array $options): string` steps:

1. `$timestamp = date('Y-m-d-H-i-s')`; `$directory = 'public://db_exports'`.
2. `prepareDirectory()` → `fileSystem->prepareDirectory($directory, CREATE_DIRECTORY |
   MODIFY_PERMISSIONS)`; throws `\RuntimeException` on failure.
3. Builds `$filepath = "$directory/dump-$timestamp.sql"`, resolves `realpath()`, throws if
   unresolvable.
4. `runDumpCommand($realpath)` — reads `connection->getConnectionOptions()` (`host`, `username`,
   `password`, `database`) and runs, via `exec()`:
   `<mysqldump> --single-transaction --quick --lock-tables=false --host=<h> --user=<u>
   --password=<p> <db> --result-file=<dest>`. The binary is passed through `escapeshellcmd`, and
   host/user/pass/db/dest through `escapeshellarg`. Non-zero exit → `\RuntimeException('Database
   export failed.')`. **No request-supplied value enters the command** — arguments come only from
   the DB connection config and the timestamped path, so there is no command-injection or
   table/filename-injection surface.
5. If `options['sanitize_users']` is truthy → `sanitizeUsers()`: `file_get_contents` the dump and
   `preg_replace` any `…@…` email pattern with `user@example.com`, then `file_put_contents`.
   (Note: this rewrites email-shaped strings only.)
6. If `options['remove_watchdog']` is truthy → `removeTableData($file,'watchdog')` strips
   `INSERT INTO \`watchdog\` …;` statements. This key is **not exposed by the form** — only a
   custom caller of `export()` can set it.
7. `compressFile()` runs `gzip -f <path>` (arg escaped); non-zero exit → `\RuntimeException`.
8. Returns `"$filepath.gz"` (the `public://…/dump-<timestamp>.sql.gz` stream path).

## Operating it

- Grant `administer db exports` only to trusted admins.
- Visit `/admin/config/development/db-export`, choose whether to sanitize, click *Export
  Database*. The success message shows the generated `public://db_exports/dump-<timestamp>.sql.gz`
  path.
- No cleanup/rotation, no restore, no scheduling, no remote destinations, no selective-table UI
  are provided. Manage retention and safe handling of generated dump files yourself.

## Extending

- The shipped `sanitizeUsers()` only rewrites email-shaped strings; to add broader sanitization
  or table selection for your project, decorate or replace `db_export_ui.database_export` and
  reimplement `export()`. The form passes its whole options array straight through, and the
  service already supports a `remove_watchdog` option you can extend to other tables via
  `removeTableData()`.
