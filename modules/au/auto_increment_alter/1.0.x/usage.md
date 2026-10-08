<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AUTO_INCREMENT Alter lets administrators change the AUTO_INCREMENT (next-ID) value of MySQL database tables, either through an admin UI, a service, or Drush commands.

---

AUTO_INCREMENT Alter is a MySQL-only developer/maintenance tool that sets the `AUTO_INCREMENT` starting value of database tables and of content-entity base/revision tables. Its primary purpose is to avoid entity-ID collisions during migrations and Drupal 6/7-to-newer upgrades, where you want new node/user/term IDs to begin above the highest ID already imported. It ships an admin interface under Configuration → Development (added in alpha5), an `auto_increment_alter.mysql` service implementing `AutoIncrementAlterInterface`, and a family of Drush commands. Single operations take an explicit table (or content-entity machine name) plus an integer value; bulk operations read the `auto_increment_alter_tables` and `auto_increment_alter_content_entities` arrays from `settings.php`. Content-entity commands resolve the base and revision tables through the `entity_type.manager` service. Everything is gated behind the `administer auto_increment table values` permission (marked `restrict access: true`), and the module refuses to run on non-MySQL drivers and refuses negative values.

---

- Raise a table's AUTO_INCREMENT so new rows start at a chosen number.
- Prevent entity-ID conflicts when upgrading from Drupal 6/7 to a newer version.
- Reserve an ID range before importing legacy content via migrations.
- Set the `node` table's next node ID (e.g. start at 500).
- Set the `users` table's next user ID above an imported range.
- Bump `taxonomy_term_data` / `taxonomy_term_revision` next-IDs together.
- Adjust `file_managed`, `media`, and `media_revision` counters in one pass.
- Alter a single table from the UI at `/admin/config/development/auto-increment-alter/table`.
- Pre-populate the single-table form via the `?name=<table>` query-string parameter.
- Alter one content entity's base (and optional revision) table by machine name.
- Bulk-alter many tables from a confirm form driven by `$settings['auto_increment_alter_tables']`.
- Bulk-alter many content entities from a confirm form driven by `$settings['auto_increment_alter_content_entities']`.
- Run `drush auto-increment-alter:table node 500` in deploy/migration scripts.
- Run `drush auto-increment-alter:content-entity node 500 1000` to set base and revision values.
- Run `drush auto-increment-alter:tables` / `:content-entities` to apply the settings-driven configuration.
- List all tables and their current AUTO_INCREMENT values (`:values`, UI list page).
- Read a single table's current AUTO_INCREMENT value (`drush auto-increment-alter:value node`).
- Include tables without an AUTO_INCREMENT set using `drush auto-increment-alter:values --all`.
- List all entity types, optionally filtered by `--group=content` or `--group=configuration`.
- List raw database tables with `drush auto-increment-alter:table-list`.
- Restrict the operation to trusted administrators through the `administer auto_increment table values` permission.
- Confirm the module skips gracefully on non-MySQL databases (logs an error, makes no change).
- Rely on the built-in guard that rejects negative AUTO_INCREMENT values.
- Reset an ID counter upward after test/QA content has been deleted.
