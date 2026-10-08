# Metatags Import Export CSV — agent index

Two batch admin forms to bulk **export** and **import** Metatag values as CSV. Depends on
Metatag + Token. Defines only two permissions; no config of its own.

- **The two forms/routes, permissions, and the exact CSV column format (import & export)** →
  [configure/import-export.md](configure/import-export.md)

Key facts: Export form route `metatag_import_export_csv.download`
(`/admin/config/search/metatag/download`, permission `metatag import export csv download`);
Import form route `metatag_import_export_csv.upload`
(`/admin/config/search/metatag/upload`, permission `metatag import export csv upload`). Import
rows identify the entity by `entity_type`+`entity_id` OR by `path_alias`, require a
`field_machine_name` column (the entity's Metatag field), and accept an optional `language`
column; empty cell = leave tag unchanged, `_blank` = clear it.
