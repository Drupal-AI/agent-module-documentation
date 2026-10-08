<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Fields Report — routes, query, export

Install: `drush en entity_fields_report` (pulls core `node` + contrib `paragraphs`). No settings
form and no config objects — behaviour is driven entirely by query params on the routes below.

## Routes & permissions (`entity_fields_report.routing.yml`)

| Route | Path | Controller method | Permission |
|-------|------|-------------------|------------|
| `entity_fields_report.main` | `/admin/reports/entity-fields-report` | `ReportController::reportPage` | `view entity_fields_report report` |
| `entity_fields_report.entity_display` | `/admin/reports/entity-field-report` | `EntityController::entityReport` | `access content overview, access content, view entity_fields_report report` (all required) |
| `entity_fields_report.update_filters` | `.../entity-fields-report/update-filters` | `ReportController::updateFilters` | `access content` |
| `entity_fields_report.export_csv` | `.../entity-fields-report/export-csv` | `ReportController::exportCsv` | `access content` |

Permission `view entity_fields_report report` is defined `restrict access: true`
(`entity_fields_report.permissions.yml`). `updateFilters`/`exportCsv` read only the current user's
own private tempstore, which is populated solely by the (restricted) main report page.

## Main report — `ReportController::reportPage()`

- `groupBy` query param, whitelisted to `field | entity_type | entity_bundle | widget_type |
  widget_module` (falls back to `field`). Optional filter params: `field`, `entity_type`,
  `entity_bundle`, `widget_type`, `widget_module`.
- `getAllFields($groupBy)` loads all `field_storage_config` entities, then for each its
  `field_config` instances via `loadByProperties(['field_name' => …])`. Per instance it reads
  storage/config metadata (`getName`, `getTargetEntityTypeId`, `getType`, `getTypeProvider`,
  `getTargetBundle`, `getLabel`) and runs an **access-checked** count query:
  `entityTypeManager->getStorage($entity_type)->getQuery()->exists($field_name)`, adding a bundle
  condition when the entity type `hasKey('bundle')`, then `->accessCheck(TRUE)->execute()`.
  Result rows carry `usage_count` (= `count($entity_ids)`) and `used_in` (the id list), keyed by
  the chosen `groupBy` value. Note: field name `field_geo_location` is hard-skipped.
- `applyFilters()` filters those rows in PHP; `getFilterOptions()` builds the sorted dropdown
  option lists. Full dataset is stored in private tempstore key `report_data` (collection
  `entity_fields_report`) for the drill-down / export routes.
- Renders `#theme => 'entity_fields_report'` (template `templates/entity-fields-report.html.twig`)
  with the `EntityFieldsFilterForm` and the `entity_fields_report/entity_report` library. All cell
  values are printed through Twig `{{ }}` auto-escaping.

## Filter form — `Form\EntityFieldsFilterForm`

Id `entity_fields_filter_form`. Selects for Group By + each filter dimension (each defaulting to
`all`). `submitForm()` builds a `query` array (dropping any `all` value) and redirects to
`entity_fields_report.main` with those query params. An "Export All to CSV" link points at
`entity_fields_report.export_csv`.

## Drill-down — `updateFilters()` → `EntityController::entityReport()`

`updateFilters()` takes `type` + `id` query params, looks up that row in tempstore `report_data`,
stores an `entity_filters` array (`order`, `sort=title`, `type`, `id`, `entity_type`, `used_in`),
then redirects to `entity_fields_report.entity_display`. `entityReport()` reloads `entity_filters`,
validates `sort` against a whitelist (`title,type,status,created,changed,revision_count,
moderation_state`; default `changed`), loads each entity in `used_in`, resolves its title via a
per-entity-type field map (`node`→title, `taxonomy_term`/`user`/`media`→name, `block_content`→info,
else `label()`), and builds rows with canonical link, id, status, created/changed, and an edit link
shown only when the user `hasPermission('edit any <bundle> content')`. Renders
`#theme => 'entity_field_report'` (`templates/entity-field-report.html.twig`).

## CSV export — `ReportController::exportCsv()`

Reads `report_data` from tempstore and streams CSV to `php://output` with header row
`field_id, field_name, entity_type, entity_bundle, widget_type, widget_module, usage_count,
used_in`. Scope depends on params: `type`+`id` → one row; `type` only → all rows in that group;
neither → the entire report. Filename `entity_fields_report_<Y-m-d>_<type>.csv`. It emits raw
`header()` calls and `exit()`s (bypasses the normal Drupal response).

## Hooks (`Hook\EntityFieldsReportHooks`)

`help` (route `help.page.entity_fields_report`) echoes README.md inside `<pre>` via
`htmlspecialchars()`. `theme` registers the two report themes. `.module` keeps `#[LegacyHook]`
wrappers delegating to this class.
