<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Custom Table lets you build Drupal Views over arbitrary custom database tables — including tables in secondary (non-default) databases — that are not Drupal entities, so all of Views' formatting, filtering, sorting and display power works on raw table data.

---

The module implements `hook_views_data()` to turn any registered database table into a Views base table. You register a table through an admin UI at *Structure → Views → View Custom Table* (`/admin/structure/views/custom_table`), giving its table name and the database connection key it lives in; the registration is stored in the `view_custom_table.tables` config object (keyed by table name, with `table_name`, `table_database`, `description`, `column_relations`, `created_by`). At Views-data build time the module introspects the live table via `information_schema.columns`, and maps each column to Views handlers by its SQL type: integer/numeric types get numeric field/sort/filter/argument handlers, text types get standard/string handlers, and date/time types (`date`, `datetime`, `timestamp`, `time`, `year`) get the module's own `mysql_date` field and filter plugins. Each custom table must have a primary key, and any column that references a Drupal entity (or another custom table) must be numeric. Through an "Edit Table Relations" form you can declare that a numeric column points at an entity type (node, user, taxonomy_term, file, …) or another custom table, which adds a Views relationship (and a reverse relationship) so you can join custom-table rows to entities. Permissions gate who can add, remove, and administer their own vs. all custom-table registrations. It requires only Views (Views UI recommended) and no external libraries.

---

- Build a View over a legacy or third-party database table that isn't a Drupal entity.
- Report on data written by a custom module into its own schema table.
- Expose an external (secondary) database's table to Views by choosing its connection key.
- Create sortable, filterable admin listings of raw table rows without writing a controller.
- Add exposed filters over columns of a non-entity table for site builders.
- Format a table's date/time columns with Drupal date formats using the `mysql_date` handler.
- Join a custom table's numeric foreign-key column to the Node entity via a Views relationship.
- Join a custom table to the User entity to show the related account's fields.
- Relate a custom table to a taxonomy_term, file, or any entity type by column relation.
- Relate two custom tables to each other (both in the same database) in one View.
- Surface a reverse relationship from an entity back to referencing custom-table rows.
- Produce CSV/JSON/RSS/table displays of custom-table data using Views display plugins.
- Give editors a filtered dashboard of imported or migrated rows still living in a staging table.
- Paginate large custom tables through Views' pager instead of custom SQL.
- Provide contextual filters (arguments) on custom-table columns for dynamic pages.
- Let non-developers site-build reports over data that predates the site's entity model.
- Combine custom-table data with entity data in a single View through relationships.
- Delegate per-user management of custom-table registrations with the "own" permission.
- Centrally administer all registered custom tables with the "all" permission.
- Register a materialized/aggregate table produced by cron as a Views data source.
- Display analytics or log tables (with a primary key) through Views without ETL into entities.
- Quickly prototype a data view over any table by adding it, clearing cache, and building a View.
