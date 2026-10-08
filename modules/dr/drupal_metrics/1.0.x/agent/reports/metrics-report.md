<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Metrics report (routes, controller, permission, menu)

## Install & enable

```bash
composer require drupal/drupal_metrics
drush en drupal_metrics -y
drush cr
```

No dependencies beyond Drupal core (`core_version_requirement: ^10 || ^11`). No settings form, no config to import, no config schema, no Drush commands. After enable, grant the `view metrics` permission and open **Administration > Reports > Metrics** (`/admin/reports/metrics`).

## Permission

`drupal_metrics.permissions.yml` defines one permission:

- **`view metrics`** — title "View Metrics", description "Allows users to view the application metrics report."

It gates **all four** routes. It is administrative operational data (schema names + aggregate counts), so grant it only to trusted roles. (It is not marked `restrict access: TRUE`.)

## Routes (`drupal_metrics.routing.yml`)

All under `/admin/reports/metrics`, all `_permission: 'view metrics'`, all `options._admin_route: TRUE`.

| Route | Path | Controller method | Title |
|---|---|---|---|
| `drupal_metrics.metrics_page` | `/admin/reports/metrics` | `MetricsController::metricsPage` | "Drupal Metrics" |
| `drupal_metrics.entity_overview` | `/admin/reports/metrics/entities` | `MetricsController::entityOverview` | "Entity Overview" |
| `drupal_metrics.entity_bundles` | `/admin/reports/metrics/entities/{entity_type_id}` | `MetricsController::entityBundles` | `entityBundlesTitle()` |
| `drupal_metrics.entity_bundle_fields` | `/admin/reports/metrics/entities/{entity_type_id}/{bundle}` | `MetricsController::bundleFields` | `bundleFieldsTitle()` |

## Menu & local tasks

- `drupal_metrics.links.menu.yml`: link **"Metrics"** under `system.admin_reports` (the core Reports menu), weight 100.
- `drupal_metrics.links.task.yml`: two tabs on `base_route: drupal_metrics.metrics_page` — **"Database"** (weight 0, the metrics page) and **"Entities"** (weight 1, the entity overview). The two drill-down routes have no tabs.

## Controller (`src/Controller/MetricsController.php`)

Extends `ControllerBase`; `create()` injects `database` (`Connection`) and `entity_field.manager` (`EntityFieldManagerInterface`). Uses `entityTypeManager()` from the base class.

### `metricsPage()` — Database tab

Attaches library `drupal_metrics/drupal_metrics.styles`. Builds a query:

```php
$query = $this->database->select('information_schema.tables', 't');
$query->addField('t', 'table_name', 'name');
$query->addExpression('ROUND((data_length + index_length), 2)', 'size');
$query->condition('table_schema', $this->database->getConnectionOptions()['database']);
$query = $query->extend('Drupal\Core\Database\Query\TableSortExtender');
$query->orderByHeader($header);
```

The `size` header defaults to `sort: desc`. Each row shows the table name and `ByteSizeMarkup::create($row->size)`; a summary container (`class drupal-metrics-summary`) prints **Total Database Size** as `ByteSizeMarkup` of the summed sizes. `#empty` → "No database tables found." (This reads MySQL/MariaDB-style `information_schema.tables` with `data_length`/`index_length`; those columns are engine-specific.)

### `entityOverview()` — Entities tab

Iterates `entityTypeManager()->getDefinitions()`; for each type implementing `ContentEntityInterface`, if it has a bundle entity type it counts bundles:

```php
$bundle_count = $bundle_storage->getQuery()->accessCheck(FALSE)->count()->execute();
```

Renders a table of Entity Type (linked to `drupal_metrics.entity_bundles`) and Bundle Count.

### `entityBundles($entity_type_id)`

Loads all bundle entities of the type; for each bundle, gets `entityFieldManager->getFieldDefinitions($entity_type_id, $bundle_id)` and counts **Base Fields** (`getFieldStorageDefinition()->isBaseField()`) vs **Additional Fields**. Each bundle links to `drupal_metrics.entity_bundle_fields`.

### `bundleFields($entity_type_id, $bundle)`

- Base fields: `entityFieldManager->getBaseFieldDefinitions($entity_type_id)`.
- Additional fields: `field_config` storage `loadByProperties(['entity_type' => …, 'bundle' => …])`.
- Entity count: `getStorage($entity_type_id)->getQuery()->accessCheck(FALSE)->condition(<bundle key>, $bundle)->count()->execute()`.
- Translation count (only if `$entity_type->isTranslatable()`): loads the bundle's entities and sums non-default translation languages via `getTranslationLanguages(TRUE)`.

Renders three tables: a **summary** (bundle, entity count, translations, base-field count, additional-field count) and two field tables (**Default (base) fields** and **Additional (configurable) fields**) each with Field Name / Label / Type / Cardinality (`-1` → "Unlimited").

### Title callbacks

`entityBundlesTitle($entity_type_id)` → "Bundles for @entity"; `bundleFieldsTitle($entity_type_id, $bundle)` → "Fields for @bundle bundle of @entity".

## Operating notes

- Counts are `accessCheck(FALSE)` raw totals (intended for an admin audit), not filtered by the viewer's content access; only aggregate numbers and schema/structure names are shown — no entity titles or URLs.
- All output is placed into `#theme => 'table'` `data` cells (escaped by the table theme). Route params drive entity-type/entity-query lookups (parameterized), and the DB query is core-query-builder based — no string-concatenated SQL and no request body / query-string input.
- If the Metrics link or tabs don't show after enabling, rebuild caches (`drush cr`).
