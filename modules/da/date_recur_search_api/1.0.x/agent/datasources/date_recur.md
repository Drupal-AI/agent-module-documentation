<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date occurrences datasource (`date_recur`)

`src/Plugin/search_api/datasource/DateRecur.php` — `@SearchApiDatasource(id = "date_recur", label = "Date
occurrences", deriver = DateRecurDatasourceDeriver)`. Extends Search API's core
`Drupal\search_api\Plugin\search_api\datasource\ContentEntity`, so entity rendering and access checking are
inherited. One derivative is created per `date_recur` field (see the deriver doc); a derivative's full plugin id
is `date_recur:<entity_type>__<field_name>`.

## Install & enable on an index

1. `drush en date_recur_search_api` (pulls date_recur, search_api, computed_field, datetime_range).
2. Edit/create a Search API index (`/admin/config/search/search-api`).
3. On the index's datasource list, enable **Date occurrences: <entity type> (<field name>)** for the field you
   want to index — use it *instead of* the core Content datasource for that entity type. Mixing with the Content
   datasource for bundles that lack a date_recur field is fine.
4. Add the computed `<field>_occurrence` date-range field to the index (used for sorting/filtering/display).
5. Choose a view mode that shows the `<field>_occurrence` field for search results.

## Configuration (config schema `plugin.plugin_configuration.search_api_datasource.date_recur:*`)

Inherits all core ContentEntity datasource config (`bundles`, `languages`) plus:

- **`pre_create`** (string, default `P2Y`) — how far into the future occurrences are generated. Any valid PHP
  `DateInterval` string. `buildConfigurationForm()` exposes it as the "Pre-create period for occurrences"
  textfield; `validateConfigurationForm()` rejects a value that `new \DateInterval($value)` cannot parse.
- **`bundles`** — `default` (bool: exclude-selected vs include-selected) + `selected` (sequence of bundle names).
- **`languages`** — `default` (bool) + `selected` (sequence of langcodes).
- **`disable_db_tracking`** (bool) — declared in schema (mirrors the core option); the datasource itself relies
  on an entity query for tracking (see `getItemIds()` @todo about a direct DB query).

`defaultConfiguration()` merges `pre_create => 'P2Y'` onto the parent defaults.

## Item-ID scheme

Each item id joins four parts with `:` (`generateEntityItemIds()`):

`<entity_id>:<langcode>:<field_delta>:<occurrence_delta>`

where `<occurrence_delta>` is the occurrence's start and end datetimes joined with `--`, each formatted
`Y-m-d-H-i-s` in the storage timezone (`OCCURRENCE_DELTA_DATETIME_FORMAT`, built by
`buildOccurrenceDeltaIdentifier()`, reversed by `getDateRangeFromOccurrenceDeltaIdentifier()`).
`getItemId()` returns `NULL` (occurrence items have no single stable id — see search_api issue 3447818).

## Tracking — `getItemIds($page)`

- Entity query with `accessCheck(FALSE)` + `exists(<field>)`, optionally constrained to enabled bundles, paged
  by `tracking_page_size`. Returns `NULL` when a page is empty (stops the pager). `accessCheck(FALSE)` is correct
  for indexing — result-time access is enforced by the parent ContentEntity datasource, as with all Search API
  content indexing.
- For each entity, `generateEntityItemIds($entity, $field_name)` computes occurrences via the date_recur field
  helper `getOccurrences(NULL, $until)` where `$until = now + pre_create`, intersects the entity's translations
  with the enabled languages, and emits one id per (occurrence × translation). Date_recur fields are assumed
  **not translatable**.

## Loading items — `loadMultiple($ids)`

Splits each id back into its four parts, `loadMultiple()`s the entities, then for each id **clones** the entity
(so setting the occurrence date on one item does not pollute other items sharing the same entity), switches to
the id's translation, reconstructs the `DateRange` from the occurrence delta, and sets it on the computed field:
`$entity-><field>_occurrence->value / ->end_value` (storage format). Returns the entity's typed data. This is
Search API's only path to load an occurrence item, so the per-occurrence date persists through indexing/render.

## Bundles — `getEntityBundles()`

When the datasource has bundles, intersects the entity type's bundle info with the bundles that actually carry
the date_recur field (`entityFieldManager->getFieldMapByFieldType('date_recur')`), so only relevant bundles are
offered.

## Scale note

Item count = occurrences (over `pre_create`) × field deltas × translations, per entity. A monthly recurrence at
`P2Y` = 24 items; with two translations, 48. Keep `pre_create` bounded for large content sets.
