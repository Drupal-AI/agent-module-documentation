# Report pages and exports

The module's user-facing surface is a set of admin pages plus downloadable exports.
Controller: `\Drupal\entity_reports\Controller\EntityReportsController`. All routes are
admin routes (`_admin_route: TRUE`) requiring the `view entity reports` permission.

## Routes

Two routes are declared in `entity_reports.routing.yml`; the rest are generated at
runtime by `\Drupal\entity_reports\Routing\EntityReportsRoutes::getRoutes()` (wired via
`route_callbacks:`), one set per entity type that implements `FieldableEntityInterface`
and passes the `reported_entity_types` filter. Grepping `routing.yml` alone will not reveal them.

| Route name | Path | Controller method | Shows |
|---|---|---|---|
| `entity_reports.entity_types` | `/admin/reports/entity` | `availableEntityTypes` | Landing page: a "Statistics export links" fieldset + a "Structure report" fieldset listing each reportable entity type as a link |
| `entity_reports.settings_form` | `/admin/config/development/entity-reports` | (form) | Settings — see configure/settings.md (needs `administer entity reports`) |
| `entity_reports.entity_structure.{entity_type_id}` | `/admin/reports/entity/{entity_type_id}` | `displayReport` | The structure report for one entity type |
| `entity_reports.entity_structure.{entity_type_id}.{format}` | `/admin/reports/entity/{entity_type_id}.{format}` | `exportReport` | File download of that entity type's structure |
| `entity_reports.statistics.{format}` | `/admin/reports/entity_statistics.{format}` | `exportStatisticsReport` | File download of site-wide per-bundle statistics |

`{format}` is one of the registered export format machine names: `json`, `xml` by default,
plus `csv` when `entity_reports_csv` is enabled. Menu link and local-task tabs for each
generated report page are produced by the derivers in `src/Plugin/Derivative/`
(`EntityReportsMenuLinks`, `EntityReportsLocalTasks`).

## What a structure report page contains

`displayReport()` renders one collapsible `details` element per bundle of the entity type,
each holding two tables:

- **Statistics** — headers: Label, Machine name, Translatable, # entities, then one column
  per language (including `LANGCODE_NOT_SPECIFIED`). Values come from
  `ReportGenerator::generateEntityStatisticsReport()`.
- **Structure** — one row per configured (non-base) field; columns are exactly the enabled
  `report_fields` (default: Field name, Machine Name, Description, Data type, Required,
  Translatable, Target, Cardinality). Multi-column field storage adds one sub-row per column
  keyed `field_name.column_name`.

At the top, an info line offers the same data as download links in every registered format.

## Exports

- `exportReport($entity_type, $format)` calls `ReportGenerator::getEntityTypeStructure()`,
  wraps it as `['bundles' => $structure]`, and serializes:
  - `json` -> `json_encode()` (default), `Content-Type: application/json`.
  - `xml` -> `\SimpleXMLElement` tree (`Content-Type: application/xml`); array keys
    `contentTypes`/`vocabularies`/`fields`/`terms` map to singular element names with an `id` attribute.
  - any **non-default** format -> dispatches `EntityReportsExportProcessors` so a subscriber
    fills `$event->content` and response headers (this is how CSV works). See events/export-formats.md.
- `exportStatisticsReport($format)` builds `['bundles' => [], 'entity_types' => $statistics]`
  where `$statistics[entity_type][bundle]` is that bundle's statistics row, then serializes the same way.

The built-in JSON/XML paths set only a `Content-Type` header; the browser names the file from
the URL (e.g. `node.json`). A custom-format subscriber may add its own headers.
