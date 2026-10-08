# Settings, routes, permissions & the export config entity

## Routes (from `entity_export_csv.routing.yml`)

| Route | Path | Purpose | Permission |
|---|---|---|---|
| `entity_export_csv.settings` | `/admin/config/content/entity-export-csv/settings` | Global settings form (the `configure` route) | `administer entity export csv` |
| `entity_export_csv.config_content` | `/admin/config/content/entity-export-csv` | Admin menu block | `administer entity export csv` |
| `entity_export_csv.export_form` | `/admin/content/entity-export-csv` | The interactive export form | `use entity export csv` |
| `entity_export_csv.download` | `/admin/content/entity-export-csv/download` | Streams the generated CSV | `use entity export csv` |
| `entity.entity_export_csv.collection` | `/admin/config/content/entity-export-csv/configurations` | Manage saved export configs | (config entity) |

## Global settings — config `entity_export_csv.settings`

Form id `entity_export_csv_settings` (class `EntityExportCsvSettings`). Default install config:

```yaml
entity_types:
  node:
    enable: true
    limit_per_bundle: {}   # empty = all bundles allowed
    bundles: {}
multiple:
  columns: '3'             # default number of columns offered for multi-value splitting
```

Per entity type you set `entity_types.<id>.enable` (bool) and optionally
`entity_types.<id>.limit_per_bundle` (a map of bundle → bundle, empty means "all bundles").
Only **content** entity types are offered. If the private filesystem is not configured the
form warns that exports fall back to the temporary filesystem.

## Saved export configurations — config entity `entity_export_csv`

Reusable export definitions are `entity_export_csv` **config entities** (ConfigEntityType id
`entity_export_csv`, config prefix `entity_export_csv.entity_export_csv.*`). Exported schema
keys (`config_export`): `id`, `label`, `uuid`, `status`, `langcode`, `entity_type_id`,
`bundle`, `fields`, `delimiter`.

- `entity_type_id` + `bundle` — what this export targets.
- `delimiter` — the CSV delimiter string.
- `fields` — a sequence keyed by field machine name; each entry:
  - `enable` (bool), `order` (int),
  - `exporter` (the chosen `field_type_export` plugin id, e.g. `default_export`, `link_export`),
  - `form.options` — `header` (header label type), `property` (which field properties to
    export), `property_separator`, `property_separate_column` (int flag: single column with
    separator vs one column per property), `format`.

Manage these at `/admin/config/content/entity-export-csv/configurations`; the collection has
add / edit / delete / **enable** / **disable** / **duplicate** operations (see the entity's
`handlers.form`). Because they are config entities they export/import with configuration
management and deploy across environments.

## Permissions (`entity_export_csv.permissions.yml`)

- `administer entity export csv` — reach the settings form and manage export configurations.
- `use entity export csv` — run the export form and download CSVs.
