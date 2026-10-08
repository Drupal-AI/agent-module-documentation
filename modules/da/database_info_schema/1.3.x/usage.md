<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Reports on the site's own database — tables, columns, indexes, sizes and row counts — through a Drush command and two admin pages.

---

Database Info (info.yml name "Database Info Drush Command", machine name `database_info_schema`) is a lightweight developer and DBA diagnostic tool. It queries the active database connection's `INFORMATION_SCHEMA` plus per-table `DESCRIBE` and `SHOW INDEX` output and presents the database name, character set / collation, total size in MB, a size-sorted list of tables with row counts and per-table sizes, and — when you drill into one table — its columns (name, type, null, key) and indexes (name, column, uniqueness, type). The same data is available from the command line via `drush db:info` (alias `dbi`) with an optional table-name argument. It has no settings form, defines no permissions or config schema, and pulls in no dependencies; it targets MySQL/MariaDB and supports Drupal 10 and 11. The web pages live under `/admin/database/...` and require the `access content` permission.

---

- Inspect the structure of the site's database without an external client.
- Get the database name and total on-disk size at a glance.
- See the database's default character set and collation.
- List every table in the database, sorted by size (largest first).
- Read per-table row counts to gauge data volume.
- Read per-table on-disk size (data length + index length) in MB.
- Drill into one table to view its column definitions (name, type, null, key, default).
- View a table's indexes, including which are unique and their index type.
- Run `drush db:info` to print database name, collation, size and the table list on the CLI.
- Run `drush db:info <table>` (e.g. `drush db:info users`) for one table's structure and indexes.
- Use the `dbi` alias as shorthand for `drush db:info`.
- Support onboarding by giving new developers immediate structural context on a project's schema.
- Spot oversized tables or indexes when planning capacity or performance tuning.
- Compare index coverage across tables during query optimization.
- Reach the report UI from Administration » Configuration (menu link "Database Information").
- Browse the table report at `/admin/database/info` and each table at `/admin/database/table/{tablename}`.
- Script schema snapshots into build or diagnostic tooling via the Drush command.
- Confirm that a migration or install created the expected tables and indexes.
- Use on Drupal 10 or 11 sites running MySQL/MariaDB.
