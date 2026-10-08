<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Storage service, results table, Views report & hooks

## Service `analyze_ai_sentiments.storage` → `SentimentsStorageService`
`src/Service/SentimentsStorageService.php` (`final`, uses `DependencySerializationTrait`). Args:
`@database`, `@config.factory`, `@entity_type.manager`, `@renderer`, `@datetime.time`. Two concerns:
score cache (DB table) and dimension CRUD (config; see [config/dimensions.md](../config/dimensions.md)
— `getAllSentiments`, `getSentiment`, `saveSentiment`, `deleteSentiment`, `sentimentExists`,
`getSentimentOptions`, `getDefaultSentiments`).

### Score cache methods
- `getScores($entity)`: SELECT `sentiments_id, score` from `analyze_ai_sentiments_results` filtered by
  entity_type/id, langcode, **content_hash** and **config_hash**; `floatval` mapped. A content or
  config change ⇒ different hash ⇒ cache miss.
- `saveScore` / `saveScores`: `merge()` on unique key `(entity_type, entity_id, sentiments_id,
  langcode)`; stores revision id, clamped score, both hashes, `time->getRequestTime()`.
- `deleteScores($entity)`, `invalidateConfigCache()` (deletes rows whose `config_hash` != current).
- Aggregates: `getStatistics()`, `getAverageScores()`, `countAnalyzedEntities($type,$bundle)` (joins
  `node_field_data` on `type` when entity type is `node`).

### Hashing
- `generateContentHash`: `sha256` of `getEntityContent()` — same render/strip-tags/normalize pipeline
  as the analyzer's `getHtml`, using the entity's own language.
- `generateConfigHash`: `md5(serialize(ksort(sentiments config)))`.

All DB access uses the Drupal query builder / `merge` / placeholders — no string-concatenated SQL.

## Table `analyze_ai_sentiments_results` (`.install` `hook_schema`)
Columns: `id` (serial PK), `entity_type`, `entity_id`, `entity_revision_id`, `langcode`,
`sentiments_id`, `score` (numeric 3,2), `content_hash` (sha256), `config_hash` (md5),
`analyzed_timestamp`. Unique key `(entity_type, entity_id, sentiments_id, langcode)`; indexes on
content_hash, sentiments_id, analyzed_timestamp, and `(entity_type, entity_id)`. `hook_uninstall`
empties the table.

### Update hooks
`_update_8001` renames the plugin id `ai_sentiments_analyzer` → `analyze_ai_sentiments_analyzer` in
`analyze.settings` `status`. `_update_8002` / `_update_8003` rebuild the report View (analyze_select
sentiments filter, language + content-type filters, created/analyzed_timestamp fields, time_diff).

## Views
- `.views.inc` `hook_views_data`: exposes `analyze_ai_sentiments_results` (base table, field
  handlers) for the report.
- Bundled View `config/install/views.view.ai_sentiments_analysis_results.yml`, id
  `ai_sentiments_analysis_results`, display `page_1`. **Access: `type: perm`, `perm: view analyze
  results`** (an Analyze-provided permission). Uses `views_color_scales` for color-coded score
  columns.

## Hooks (`.module`)
- `hook_views_color_scale_popover_alter`: for the results base table, replaces the popover with an
  `analyze_gauge` built from the dimension's labels (looks the dimension up via the storage service).
- `hook_views_pre_view`: on `ai_sentiments_analysis_results:page_1`, adds a "Configure settings"
  button when the user has `administer analyze`.
- `hook_entity_update` / `hook_entity_delete`: delete cached scores for "supported" entities.
  CAVEAT: the guard `_analyze_ai_sentiments_is_supported_entity()` checks
  `status[...]['ai_sentiments_analyzer']` — the **pre-`_update_8001`** plugin id — while the analyzer
  writes/reads the new id `analyze_ai_sentiments_analyzer`. On upgraded/new sites this guard no longer
  matches, so edit/delete-triggered invalidation may not fire; stale scores are still avoided on read
  because the content hash changes on edit.
