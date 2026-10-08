<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins — the `AuditExport` plugin type (writing a custom audit)

`audit_export_core` defines one plugin type. An audit is a class in any module's
`src/Plugin/AuditExport/`, carrying the `@AuditExport` annotation, extending
`AuditExportPluginBase`, and implementing `AuditExportPluginInterface`. Discovery is via
`plugin.manager.audit_export_audit` (dir `Plugin/AuditExport`, annotation
`Drupal\audit_export_core\Annotation\AuditExport`, alter hook `audit_export_info`).

## Annotation keys

| Key | Meaning |
|---|---|
| `id` | Machine name (also the `audit_export_report.audit` key and the derived-tool suffix). |
| `label` | `@Translation` human name. |
| `description` | `@Translation` shown in the overview and drush list. |
| `group` | Grouping bucket (e.g. `content`, `users`, `modules`, `general`). |
| `data_type` | `flat` (default), `process`, or `cross` — controls the processing path. |
| `identifier` | The column/field that uniquely identifies a row (e.g. `machine_name`). |
| `dependencies` | Array of dependencies (informational; shown in drush list). |

## Required methods (`AuditExportPluginInterface`)

- `prepareData(): array` — return the list of items to iterate (row seeds). Called once.
- `processData(array $params): array` — given `['row_data' => $item]`, return one output row (a flat
  array matching the headers). Called per item.
- Header handling lives in `AuditExportPluginBase`: set columns with `setHeaders([...])` (typically
  in the constructor), read with `getHeaders()`. Cross-tab reports add a leading label via
  `setCrossTabHeaderLabel()`.
- `AuditExportPluginBase` also supplies `label()`, `getModule()`, `getDataType()`, `getIdentifier()`,
  `getGroup()`, `getDependencies()`, `getClassName()`, and no-op `prepareCrossTabScripts()` /
  `processDataPreProcess()` you can override for `cross` audits.

`AuditExportPluginBase::create()` injects `entity_type.manager`. Note the bundled plugins mostly
use `\Drupal::service(...)` statics inside their methods and several define a no-arg constructor
that only calls `setHeaders()` — follow the bundled examples for the exact shape.

## `data_type` behaviour

- **`flat`** — the common case: `prepareData()` returns seeds, `processData()` maps each to a row.
- **`process`** — same loop; used when `prepareData()` already returns richer per-row structures
  (e.g. `views_audit`, `site_report`).
- **`cross`** — cross-tab. The controller additionally calls `prepareCrossTabScripts()` and
  `processDataPreProcess()` and appends their results (e.g. `active_users_roles_audit` builds a
  users×roles matrix).

## Bundled audits (in the parent `audit_export` module, `src/Plugin/AuditExport/`)

| id | group | data_type | identifier | What it inventories |
|---|---|---|---|---|
| `content_type_audit` | content | flat | `machine_name` | Content types. |
| `entities` | entities | flat | `entity_type` | Entity types / fields. |
| `blocks_enabled` | content | flat | `block` | Placed/enabled blocks. |
| `menus_audit` | content | flat | `menu` | Menus. |
| `views_audit` | general | process | `view` | Views + displays. |
| `site_report` | general | process | `report_name` | General site report rows. |
| `active_users_roles_audit` | users | cross | `source_module` | Active users × roles matrix. |
| `taxonomy_vocabulary` | taxonomy | flat | `id` | Vocabularies / terms. |
| `enabled_modules` | modules | flat | `module_name` | Enabled modules with current version, latest release, security-update status, type, parent. |

`enabled_modules` reads `extension.list.module` and, when the `update` module is enabled, calls
`update_get_available()` / `update_calculate_project_data()` to report the recommended release and
flag `(Security update!)`.
