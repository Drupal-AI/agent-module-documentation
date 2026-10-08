<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Metrics (drupal_metrics) — agent index

A read-only **Reports** page that shows **database table sizes** and a **content-entity / bundle / field** structural overview. Package `Statistics`. Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x. **No dependencies** beyond Drupal core, **no settings form**, no config, no config schema, no Drush.

- **All four routes, the controller methods, what each page queries, the permission, and the menu/tab placement** →
  [reports/metrics-report.md](reports/metrics-report.md)

## What it actually is

- One controller: `MetricsController` (`src/Controller/MetricsController.php`, extends core `ControllerBase`), built with the `database` and `entity_field.manager` services (plus `entityTypeManager()` from the base class).
- Four routes (`drupal_metrics.routing.yml`), all `path: /admin/reports/metrics…`, all `_permission: 'view metrics'`, all `_admin_route: TRUE`:
  - `drupal_metrics.metrics_page` → `metricsPage()` — Database tab.
  - `drupal_metrics.entity_overview` → `entityOverview()` — Entities tab.
  - `drupal_metrics.entity_bundles` `/{entity_type_id}` → `entityBundles()` (+ `entityBundlesTitle()`).
  - `drupal_metrics.entity_bundle_fields` `/{entity_type_id}/{bundle}` → `bundleFields()` (+ `bundleFieldsTitle()`).
- One permission (`drupal_metrics.permissions.yml`): **`view metrics`** ("View Metrics").
- Menu link (`.links.menu.yml`) under `system.admin_reports`; two local tasks (`.links.task.yml`): **Database** and **Entities**.
- One CSS library (`drupal_metrics.libraries.yml`): `drupal_metrics/drupal_metrics.styles` → `css/drupal_metrics.css`, attached by `metricsPage()`.

## Mechanism (from source)

- **Database tab** (`metricsPage()`): `select('information_schema.tables', 't')`, field `table_name`, expression `ROUND((data_length + index_length), 2)` as `size`, `condition('table_schema', <current db name>)`, extended with `TableSortExtender` + `orderByHeader()` (sortable, default size desc). Rows render table name + `ByteSizeMarkup::create($size)`; a summary container prints the summed total as `ByteSizeMarkup`.
- **Entities tab** (`entityOverview()`): iterates `entityTypeManager()->getDefinitions()`, keeps types implementing `ContentEntityInterface`, and for each with a bundle entity type counts bundles via `getStorage(bundle_type)->getQuery()->accessCheck(FALSE)->count()`. Each row links to `drupal_metrics.entity_bundles`.
- **Bundles drill-down** (`entityBundles($entity_type_id)`): loads bundle entities, counts base vs additional fields from `entityFieldManager->getFieldDefinitions()` (`getFieldStorageDefinition()->isBaseField()`), links each bundle to `drupal_metrics.entity_bundle_fields`.
- **Bundle fields** (`bundleFields($entity_type_id, $bundle)`): base fields from `getBaseFieldDefinitions()`, configurable fields via `field_config` storage `loadByProperties()`; entity count and (if translatable) translation count via `getQuery()->accessCheck(FALSE)`; renders a summary table plus base-field and additional-field tables with name/label/type/cardinality (`-1` → "Unlimited").

## Notes

- All queries are core query-builder / entity-query based (parameterized); route params `{entity_type_id}` / `{bundle}` feed `entityTypeManager` lookups and entity-query conditions.
- Counts use `accessCheck(FALSE)` — they are raw totals, not access-filtered. Only aggregate counts and schema/structure names are shown (no entity titles or URLs).
- No install/uninstall hooks, no `.module` file; works immediately on enable (clear caches if the Reports link/tabs don't appear).
