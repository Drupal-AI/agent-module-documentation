<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ES Attachment (es_attachment) — agent index

Indexes the text **inside** attached documents (PDF & co) using the Elasticsearch **ingest "attachment" pipeline**. Text extraction runs in Elasticsearch, not PHP. Package `Search`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version dir 1.0.x (release 1.0.2).

Fork/rewrite of `search_api_elasticsearch_attachments`, modernized for Elasticsearch Connector 8.x/9.x + Search API Attachments 10.x.

## Dependencies (all required, from `es_attachment.info.yml`)
- `search_api:search_api`
- `elasticsearch_connector:elasticsearch_connector` (composer `^8.0 || ^9.0`)
- `search_api_attachments:search_api_attachments` (composer `^10.0`)

No settings form, no route, no permission, no config schema, no `.module`/`.install`, no submodules. Configured via existing Search API + Search API Attachments setup (pick extraction method `es_pipeline_extractor` in config `search_api_attachments.admin_config`).

## What it provides
- **Plugin** `EsPipelineExtractor` (`src/Plugin/search_api_attachments/EsPipelineExtractor.php`) — a `@SearchApiAttachmentsTextExtractor` (id `es_pipeline_extractor`) extending `TextExtractorPluginBase`. Does NOT extract in PHP; `extract()` base64-encodes the raw file for Elasticsearch. No config.
- **Service** `es_attachment.helpers` (`src/Helpers.php`, class `Helpers`) — index/field/processor helpers, injected into all three subscribers.
- **Event subscribers** on `elasticsearch_connector` events (`es_attachment.services.yml`):
  - `IndexItemEvent` → `IndexParamsEvent` (prio 101): wraps file content as `['data' => …]` and sets `index.pipeline = es_attachment` per item.
  - `UpdateIndexSettingsEvent` → `AlterSettingsEvent` (prio 999): creates/deletes the ES ingest pipeline `es_attachment`.
  - `QueryEvent` → `QueryParamsEvent` (prio 90): rewrites queries into nested `should` matches on `<field>.attachment.content`; honors `no_attachments` query option.

## Solution docs
- Extractor plugin, its behavior and config → [plugins/es-pipeline-extractor.md](plugins/es-pipeline-extractor.md)
- Pipeline lifecycle, indexing, query rewrite, Helpers, operating it → [events/pipeline-and-events.md](events/pipeline-and-events.md)
