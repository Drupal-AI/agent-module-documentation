<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Custom Table — agent index

Registers arbitrary database tables (even in secondary databases) as **Views base tables**
via `hook_views_data()`, so you can build Views over non-entity / legacy / custom tables. State
lives in the `view_custom_table.tables` config object; the admin UI is at
`/admin/structure/views/custom_table` (configure route `view_custom_table.customtable`).

- **Register / edit / remove a custom table, the config object shape, relations, permissions** →
  [configure/custom-tables.md](configure/custom-tables.md)
- **How tables become Views data (column→handler mapping, `mysql_date`, relationships)** →
  [api/views-integration.md](api/views-integration.md)

Key facts:
- A registration is a keyed entry in `view_custom_table.tables`:
  `<table>.{table_name, table_database, description, column_relations (PHP-serialized), created_by}`.
- The table must already exist and have a **primary key**; entity/table relation columns must be
  **numeric**. After adding/changing a registration, **clear caches** so Views data rebuilds.
- Date/time columns are handled by this module's `mysql_date` Views field + filter plugins; it
  defines **no plugin type** of its own.
- Permissions: `add custom table in views`, `remove custom table in views`,
  `administer own custom table in views`, `administer all custom table in views`.
