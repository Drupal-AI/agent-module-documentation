# Entity Export CSV — agent index

Exports content entities to CSV. Two layers: a global **settings** step that whitelists
exportable entity types/bundles, and an **export** form / saved **export config entities**
that map fields to columns. Per-field rendering is done by a `field_type_export` plugin.

- **Settings, routes, permissions, and the `entity_export_csv` config entity (delimiter,
  per-field map)** → [configure/settings.md](configure/settings.md)
- **The `field_type_export` plugin type: annotation, built-in exporters, how to add one** →
  [plugins/field-type-export.md](plugins/field-type-export.md)
- **The manager service (`entity_export_csv.manager`) and the two alter events** →
  [api/manager-and-events.md](api/manager-and-events.md)

Key facts:
- Configure route: `entity_export_csv.settings` → `/admin/config/content/entity-export-csv/settings`
  (config object `entity_export_csv.settings`). Export form: `/admin/content/entity-export-csv`.
- Config entity type id: `entity_export_csv` (config prefix `entity_export_csv.entity_export_csv`).
- Plugin type: `field_type_export`, manager `plugin.manager.field_type_export`,
  base `FieldTypeExportBase`, annotation `@FieldTypeExport`.
- Permissions: `administer entity export csv`, `use entity export csv`.
