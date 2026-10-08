<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dify backend: config, chunking, contextual field, file extraction

`SearchApiDifyBackend` (id `dify`) in `src/Plugin/search_api/backend/SearchApiDifyBackend.php`.

## Credentials (State, keyed by server id)

`buildConfigurationForm()` renders a **credentials** group: `api_key` and `workflow_api_key` are
`#type => password` (autocomplete `new-password`); `base_url` is `#type => url`; plus `dataset`.
`validateConfigurationForm()` checks `base_url` with `FILTER_VALIDATE_URL` and requires
`api_key`/`dataset` to match `^[a-zA-Z0-9_-]+$`. `submitConfigurationForm()` writes non-empty
values to State: `dify_search_api.{server}.api_key` / `.base_url` / `.dataset` /
`.workflow_api_key` (the `stateKey()` helper). `getClient()` throws if base_url/api_key are unset,
otherwise builds two Guzzle clients via `http_client_factory->fromOptions()` (base_uri + Bearer
header; default TLS verification) and `new DifyClient($jsonClient, $fileClient)`.
`viewSettings()` calls `getDocuments(limit:1)` to show connection status + document total.

## Backend `defaultConfiguration()`

`add_content_url` TRUE, `content_url_field_name` `content_url`, `chunking_mode` `parent_child`,
`parent_mode` `full-doc`, `parent_chunk_separator` `\n\n`, `parent_chunk_max_length` 1000,
`chunk_max_length` 1000, `chunk_overlap` 50, `chunk_separator` `[SEARCH:CHUNK]`,
`remove_extra_spaces` TRUE, `remove_urls_emails` FALSE, `workflow_output_variable` `text`. Config
schema is `search_api.backend.plugin.dify` (`config/schema/dify_search_api.schema.yml`).

## Field priorities

`hook_form_search_api_index_fields_alter` replaces the Boost `select` with a `#type => number`
Priority input (default 50, min 0) per field, and the header label *Boost*→*Priority*. On submit
`_dify_search_api_fields_form_submit` reads `fields[*][boost]`, casts to int, stores them on the
**real** index entity as third-party setting `dify_search_api.field_priorities`, and resets each
field's boost to `1.0` so Search API's own submit stays neutral.

## Document assembly (`indexItems` → `buildStructuredDocument`)

Per item, fields are read into `$data` (a `dify_extracted_file` field is replaced by
`extractFileField()` output). Priority bands: **≥100** = parent/identity, **1–99** = child, **0**
= excluded. Each band sorted ascending.

- **full-doc / paragraph**: parent fields joined by `\n` into one context block; child fields each
  become `Label: value`, joined by the `chunk_separator` (`\n`/`\t` escapes decoded). Sent via
  `indexItemAsText()` → `DifyClient::createDocumentFromText/updateDocumentFromText` with options
  from `buildChunkingOptions()`.
- **contextual_field**: `indexItems()` delegates to `pipeline->syncEntity(...)` instead. Each
  content field (1–99) becomes its own parent paragraph prefixed with the identity card
  (`buildIdentityCard`, priority ≥150 compact / 100–149 dedicated lines); heading `##` for
  priority <50 else `###`; paragraphs separated by `[FIELD:BREAK]`. `\n\n` inside fields is
  collapsed to avoid orphan parent chunks; long fields are pre-split at sentence boundaries.

`chunking_mode = parent_child` sets Dify `doc_form=hierarchical_model` (see base
`DifyClient::getTextIndexingOptions`); otherwise `automatic`.

## Content URL metadata

When `add_content_url` is on, `addContentUrlMetadata($document_id, $item)` ensures a metadata
field named `content_url_field_name` on the dataset and assigns the entity's canonical URL, so
retrieved chunks carry a citable source link.

## Contextual-field pipeline (`DifyKnowledgePipelineService`)

`src/Service/DifyKnowledgePipelineService.php` (args `@database`, `@logger.factory`,
`@datetime.time`). Maintains the `dify_field_segment_map` table (created in
`dify_search_api.install`): rows key `entity_type+entity_id+field_name+dataset_id` → Dify
`document_id`/`segment_id` + `content_hash` + `synced_at`. `syncEntity()` creates the document
once, then for each field creates/updates/deletes the corresponding Dify **segment** only when its
content hash changed (differential sync), logging each create/update/delete/orphan-cleanup to the
`dify_search_api` channel. Deletes remove orphan segments and (on entity delete) the document.

## File extraction (`DifyFileExtractorService`)

`src/Service/DifyFileExtractorService.php` (args `@http_client_factory`, `@logger.factory`,
`@file_system`). `extract($fileUri, $mode, $config)` — `mode` `dify_workflow` else NULL. Workflow
path: resolve realpath → `uploadFile()` `POST /v1/files/upload` (multipart, Bearer
`workflow_api_key`) → `runWorkflow()` `POST /v1/workflows/run` (`transfer_method=local_file`,
`response_mode=blocking`) → returns `data.outputs[output_variable]` (default `text`). The backend
passes `base_url` from State and `api_key` from the **workflow_api_key** State entry. Missing
credentials/file are logged and yield NULL. TLS verification is Guzzle default (on).

## InlineImageSanitizer

`src/Utility/InlineImageSanitizer.php`, static `sanitize($text)` — regex-strips markdown image
`![...](data:image/...;base64,...)`, `<img src="data:image/...;base64,...">`, and bare
`image/...;base64,...` payloads, then collapses 3+ newlines. Used to keep base64 blobs out of
indexed content.
