<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Fields Report (entity_fields_report) — agent index

Admin report listing every configured entity field (machine name, label, entity type, bundle,
widget/field type, provider module) with an **access-checked usage count** and the entities using
each field. Groupable/filterable, with CSV export and a per-field entity drill-down. Package
`Content`. Depends on core **`node`** and contrib **`paragraphs`**. Core `^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.3. **No config form / no config schema.**

## Solution docs

- **Routes, permissions, controllers, the report-building query, CSV export** →
  [reports/entity-fields-report.md](reports/entity-fields-report.md)

## What it actually is (from source)

- Menu link `entity_fields_report.main` under **Reports** (`system.admin_reports`) →
  `/admin/reports/entity-fields-report` (`entity_fields_report.links.menu.yml`).
- Two controllers in `src/Controller/`:
  - `ReportController` (`report_controller` service, args `@database`, `@tempstore.private`,
    `@entity_type.manager`, `@form_builder`) — builds the main report (`reportPage`), AJAX filter
    redirect (`updateFilters`), and CSV output (`exportCsv`).
  - `EntityController` — per-field entity listing (`entityReport`).
- One form: `Form\EntityFieldsFilterForm` (id `entity_fields_filter_form`) — Group By + filter
  selects + Apply/Export buttons.
- Hooks class `Hook\EntityFieldsReportHooks` (`#[Hook]` attributes, `.module` delegates via
  `#[LegacyHook]`): `help` (dumps README) and `theme` (themes `entity_fields_report` /
  `entity_field_report`, templates in `templates/`).
- One permission `view entity_fields_report report` (`restrict access: true`).
- Frontend library `entity_fields_report/entity_report` (`js/entity_report.js`,
  `css/entity_report.css`; deps core/jquery, core/drupal, core/once).
- Provides: no entities, no plugins, no Drush, no services beyond the controller/hooks above.
