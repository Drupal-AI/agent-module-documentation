<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom SQL Migrate Source Plugin provides a Migrate source plugin (`custom_sql_query`) that runs an arbitrary hand-written SQL string, defined in the migration YAML, as the source of a migration.

---

Migrate's built-in SQL sources expect you to describe tables, columns and joins through the query builder; importing from a bespoke or legacy database schema is often easier to express as a single hand-written SQL statement. This module's `CustomSQLQuery` plugin (extends core's `SqlBase`) lets you paste a full `SELECT` string into the migration's `source.sql_query` key and returns every selected column as a field on the migrate row, so any process plugin or destination field can reference it. It targets a database connection named by the migration's `key` (a connection you define in `settings.php`), optionally uses a separate `sql_count_query` for the row count, and declares the source's unique key(s) via the `keys` list. It is developer/CLI infrastructure: the SQL is authored by the person who writes the migration configuration and migrations are run under Drush or the admin migrate UI, so writing correct, well-formed queries against the source database is the developer's responsibility. Note the maintainer's caveat: because the query lives in the migration config, editing the SQL requires re-installing the custom migration module (`drush pmu <module> -y && drush en <module> -y`) for the change to take effect.

---

- Import content from a bespoke legacy database schema that does not map cleanly to Migrate's table-based SQL sources.
- Use a full hand-written `SELECT` statement as a migration source instead of the query builder.
- Migrate rows from a MySQL/MariaDB legacy database defined in `settings.php` into Drupal nodes.
- Pull data from a non-Drupal application database (custom CMS, framework app) into Drupal content.
- Select computed/derived columns (e.g. `CONCAT('/', slug) AS slug`) directly in SQL and map them to fields.
- Join multiple legacy tables in one query and expose the joined result as a single migrate row.
- Provide a custom `sql_count_query` so long migrations report accurate progress totals.
- Define multiple unique source keys via the `keys` list for composite-key sources.
- Feed the returned columns into any Migrate process plugin (`default_value`, `migration_lookup`, etc.).
- Map a SQL column to a node's path alias, title, body, or any entity field.
- Point different migrations at different source connections by setting each migration's `key`.
- Stand up a repeatable, config-driven import of legacy content run entirely from Drush.
- Migrate taxonomy terms, users, or other entities from a legacy schema by writing the matching query.
- Prototype a migration quickly by iterating on a raw SQL string rather than a query-builder definition.
- Import article/resource records from a legacy table into an article content type.
- Combine with `migrate_plus` migration groups and `migrate_tools` Drush commands for orchestration.
- Reuse an existing reporting SQL query as the basis for a content import.
- Filter and shape source rows with SQL `WHERE`/`ORDER BY`/`GROUP BY` instead of extra process steps.
- Keep migration logic close to the data by expressing extraction in native SQL.
- Enable only while a migration is being built or run, and keep it disabled on sites that do not migrate.
