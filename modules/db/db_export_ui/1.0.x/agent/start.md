<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database Export UI (db_export_ui) — agent index

A minimal admin tool that runs **`mysqldump`** and writes a compressed, optionally sanitized
**`.sql.gz`** dump of the site's MySQL/MariaDB database. One route, one form, one service.
Package: none declared. Depends only on core **`system`**. Core requirement `^10.3 || ^11`.
License GPL-2.0-or-later. Version 1.0.5 (dir `1.0.x`).

- **The export form, the service, the route/permission, config and how to operate it** →
  [config/export.md](config/export.md)

## What it actually is

- One route: **`db_export_ui.form`** → `GET /admin/config/development/db-export`, `_form` =>
  `DatabaseExportForm`, requirement `_permission: 'administer db exports'`
  (`db_export_ui.routing.yml`). Linked under *Configuration › Development* via
  `db_export_ui.links.menu.yml`. `configure` in `.info.yml` points at this same route.
- One permission: **`administer db exports`** (`db_export_ui.permissions.yml`) — a dedicated,
  restricted admin permission; nothing here is granted to anonymous or `access content`.
- One form: `Form\DatabaseExportForm` (`FormBase`, id `db_export_ui_form`) — a `sanitize_users`
  checkbox (default on) and an *Export Database* submit; standard Drupal form (CSRF token). On
  submit it calls the service and prints the result path via `messenger()`.
- One service: **`db_export_ui.database_export`** =>
  `Service\DatabaseExportService` (autowired). `export(array $options)` prepares
  `public://db_exports`, builds a timestamped `.sql`, shells out to `mysqldump`
  (all connection values `escapeshellarg`'d), optionally sanitizes, optionally strips a table's
  INSERTs, then `gzip`s the file and returns the `public://…/dump-<timestamp>.sql.gz` path.
- No entities, no plugin types, no Drush commands, no hooks, no `config/install`, no
  `config/schema`. External requirements: the `mysqldump` and `gzip` binaries.

## Mechanism (from source)

- `DatabaseExportService::runDumpCommand()` reads `$connection->getConnectionOptions()` and
  composes `mysqldump --single-transaction --quick --lock-tables=false --host=… --user=…
  --password=… <db> --result-file=<path>` with `escapeshellcmd` on the binary and
  `escapeshellarg` on every value; no request input reaches the command (no shell-injection
  surface). `mysqldump` path falls back to `/opt/homebrew/bin/mysqldump` if present.
- `sanitizeUsers()` only regex-replaces email addresses (`…@…` → `user@example.com`) in the dump
  text; `removeTableData($file,'watchdog')` (reachable via the undocumented `remove_watchdog`
  option, not exposed by the form) strips `INSERT INTO \`watchdog\`` statements.
- `compressFile()` runs `gzip -f <path>` (`escapeshellarg`'d).
- Output lives under the timestamped filename `dump-Y-m-d-H-i-s.sql`, gzipped, in
  `public://db_exports`.
