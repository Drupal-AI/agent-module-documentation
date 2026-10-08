<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reports (entity_reports) — agent index

Admin/developer reporting module. For every fieldable entity type it renders a report page
listing each bundle's fields (machine name, type, required, cardinality, translatable, target)
plus per-bundle statistics (instance counts per language), and offers JSON / XML / CSV
downloads of the same data. Report pages live under `/admin/reports/entity`.

- Dependencies: core `field`, `node`, `taxonomy`. Core: `^10.1 || ^11`. No composer requirements.
- Configure route: `entity_reports.settings_form` → `/admin/config/development/entity-reports`.
- Defines 2 permissions and 2 events. No plugin types of its own, no drush, no blocks/fields.
- Submodule: `entity_reports_csv` (adds the CSV export format; needs `csv_serialization`).

Solution docs:
- **See/operate the report pages and download JSON/XML/CSV** → [api/report-pages.md](api/report-pages.md)
- **Call the report data from PHP** (`entity_reports.generator` service) → [api/report-generator.md](api/report-generator.md)
- **Choose which entity types are reported and which columns show** → [configure/settings.md](configure/settings.md)
- **Grant access to the reports** → [permissions/permissions.md](permissions/permissions.md)
- **Register a new export format (e.g. CSV)** → [events/export-formats.md](events/export-formats.md)

Key facts (real machine names):
- Static routes: `entity_reports.entity_types` (`/admin/reports/entity`, landing list),
  `entity_reports.settings_form` (`/admin/config/development/entity-reports`, settings).
- Generated routes (via `route_callbacks` → `\Drupal\entity_reports\Routing\EntityReportsRoutes::getRoutes`,
  not visible in `routing.yml`): `entity_reports.entity_structure.{entity_type_id}`,
  `entity_reports.entity_structure.{entity_type_id}.{format}`, `entity_reports.statistics.{format}`.
- Config object: `entity_reports.settings` — keys `reported_entity_types` (sequence), `report_fields` (sequence of {machine_name,label,weight,status}).
- Service: `entity_reports.generator` = `\Drupal\entity_reports\ReportGenerator`.
- Permissions: `view entity reports`, `administer entity reports`.
- Controller: `\Drupal\entity_reports\Controller\EntityReportsController`.
- Events: `entity_reports_export_formats`, `entity_reports_export_processors` (classes in `src/Event/`).
- Default formats: `json`, `xml` (`EntityReportsExportFormats::DEFAULT_EXPORT_FORMATS`); `csv` via the submodule.
