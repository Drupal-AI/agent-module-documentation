<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify Search API (dify_search_api) — agent index

Search API **backend** that indexes Drupal content into a **Dify knowledge base**. Depends on
`dify` (base) and `search_api:search_api`. Package `Dify`. Core `^10 || ^11`, PHP 8.1. Version
2.0.8. Extra libraries: `drupal/search_api:^1.40`, `league/html-to-markdown:^5.1`.

- **Backend plugin, config form, chunking, contextual-field pipeline, file extraction, schema** →
  [backend/indexing.md](backend/indexing.md)

## What it provides (from source)

- **Backend plugin** `SearchApiDifyBackend` (id `dify`),
  `src/Plugin/search_api/backend/SearchApiDifyBackend.php` — `new`s a `DifyClient` from
  State-stored credentials; `indexItems()`, `deleteItems()`, `buildConfigurationForm()`,
  `viewSettings()`. Uses `IdentityCardTrait`.
- **Data type plugin** `DifyExtractedFileDataType` (id `dify_extracted_file`, label *Dify File
  Extraction*, fallback `string`), `src/Plugin/search_api/data_type/`. Marks a file field for
  Workflow extraction; the backend intercepts it in `indexItems()`.
- **Services** (`dify_search_api.services.yml`): `dify_search_api.knowledge_pipeline`
  (`DifyKnowledgePipelineService`, args `@database`, `@logger.factory`, `@datetime.time`) and
  `dify_search_api.file_extractor` (`DifyFileExtractorService`, args `@http_client_factory`,
  `@logger.factory`, `@file_system`).
- **Hooks** (`dify_search_api.module`): `hook_help`; `hook_form_search_api_index_fields_alter`
  turns the *Boost* column into a *Priority* input (saved to index third-party setting
  `field_priorities`, default 50); a submit handler resets boost to neutral;
  `hook_ENTITY_TYPE_predelete` for `search_api_server` deletes the four State credential keys.
- **Schema** (`dify_search_api.install`): table `dify_field_segment_map` (entity_type/entity_id/
  field_name/dataset_id/document_id/segment_id/content_hash/synced_at) for Contextual Field
  differential sync.
- **Config schema** (`config/schema/…`): `search_api.backend.plugin.dify` (chunking + content-URL
  + workflow-output settings). Backend `defaultConfiguration()` documented in the solution doc.
- **Utility** `InlineImageSanitizer::sanitize()` — strips markdown/HTML/bare base64 image payloads
  from indexed text.

## Credentials & config

Entered on the **Search API server** backend form (not a standalone route), stored in **Drupal
State**: `dify_search_api.{server}.base_url` / `.api_key` / `.dataset` / `.workflow_api_key`.
`base_url` is validated with `FILTER_VALIDATE_URL`; `api_key`/`dataset` restricted to
`[a-zA-Z0-9_-]`. All outbound calls use Guzzle default TLS verification. Set index **cron batch
size to 1** (Dify indexes one document per request).

## Install

`composer require drupal/search_api:^1.40 league/html-to-markdown:^5.1` →
`drush en dify_search_api` → create a Search API server with the **Dify** backend → create an
index, set field priorities, index content.
