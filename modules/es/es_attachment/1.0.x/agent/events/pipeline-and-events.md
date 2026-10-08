<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pipeline lifecycle, indexing, query rewrite & Helpers

All behavior hangs off three `elasticsearch_connector` events plus the shared `Helpers` service. Services declared in `es_attachment.services.yml`. No route, permission or settings form.

## Helpers service (`src/Helpers.php`, `es_attachment.helpers`)
Constructor args: `@config.factory`, `@entity_type.manager`. Reads immutable config `search_api_attachments.admin_config` once.
- `processorEnable(IndexInterface $index): bool` — TRUE only when the index has processor `file_attachments` (an instance of `search_api_attachments\Plugin\search_api\processor\FilesExtractor`) AND config `extraction_method === 'es_pipeline_extractor'`. This gate guards all three subscribers.
- `getDocumentFields(IndexInterface $index): array` — field identifiers whose name starts with `FilesExtractor::SAA_PREFIX` (first 4 chars), i.e. the attachment fields.
- `loadIndex(string $indexName): ?Index` — loads a `search_api_index` entity.

## Pipeline lifecycle — UpdateIndexSettingsEvent
File: `src/EventSubscriber/UpdateIndexSettingsEvent.php`. Subscribes to `AlterSettingsEvent` at priority 999. Pipeline name constant: `es_attachment`.
- `managePipeline()`: if `processorEnable()` → `setupPipeline()`, else `unSetupPipeline()`.
- Client obtained from the index's server: `$index->getServerInstance()->getBackend()->getClient()` (an `Elastic\Elasticsearch\Client` supplied by Elasticsearch Connector — this module makes no HTTP client of its own and holds no connection credentials).
- `setupPipeline()`: `getPipeline` / `deletePipeline` (drop any stale one), then `addPipeline()`.
- `addPipeline()`: `putPipeline` with id `es_attachment`, body = one `foreach` processor per attachment field, each running the ES `attachment` processor on `_ingest._value.data` → `_ingest._value.attachment`, `indexed_chars: -1` (no length limit), `remove_binary: TRUE`, `properties: ['content']`, `ignore_missing: TRUE`.
- `unSetupPipeline()`: deletes the pipeline if present.

## Indexing — IndexItemEvent
File: `src/EventSubscriber/IndexItemEvent.php`. Subscribes to `IndexParamsEvent` at priority 101.
- `pipelineProcessing()`: loads the index, returns early unless `processorEnable()`. For each body item, for each attachment field (`getDocumentFields`), rewrites each file value to `['data' => <base64>]` and sets `$params['body'][$key - 1]['index']['pipeline'] = 'es_attachment'` on the preceding bulk action line so Elasticsearch runs the ingest pipeline for that document.

## Query rewrite — QueryEvent
File: `src/EventSubscriber/QueryEvent.php`. Subscribes to `QueryParamsEvent` at priority 90.
- `alterQuery()`: no-ops when the query option `no_attachments === TRUE`, when the processor is not enabled, when there are no query keys, when the trimmed query string is empty, or when the index has no attachment fields.
- Derives the query string per Search API parse mode (`terms` → imploded keys; `phrase` → `match_phrase`; else `direct`/first key) and the conjunction (`and` for `direct`, else the keys' `#conjunction`).
- Converts the existing `bool.must` into a `bool.should` with `minimum_should_match: 1`, then appends, per attachment field, a `nested` query (`path` = field) wrapping a `constant_score` filter of `match`/`match_phrase` on `<field>.attachment.content`. Each attachment field is also added to `_source.excludes`, so the raw indexed file value is not returned in results.

## Operating it
1. Install `search_api`, `elasticsearch_connector`, `search_api_attachments`, then `es_attachment` (`drush en es_attachment -y`).
2. Have a Search API index on an Elasticsearch Connector server; add attachment field(s) via Search API Attachments and enable its `file_attachments` processor.
3. In Search API Attachments config, set the extraction method to `ElasticSearch Pipeline Extractor` (`es_pipeline_extractor`). Saving index settings triggers pipeline creation.
4. Reindex; searching a word that appears only inside a PDF returns the parent content.
- Programmatic opt-out per query: `$query->setOption('no_attachments', TRUE)` in a `hook_search_api_query_alter` (see module README).
- Media-attached documents (nested) may need the Search API Attachments patch from issue 3008580.
