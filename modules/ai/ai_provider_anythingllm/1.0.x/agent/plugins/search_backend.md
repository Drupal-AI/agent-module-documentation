<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API backend: `search_api_ai_anythingllm`

`src/Plugin/search_api/backend/SearchApiAiAnythingllmBackend.php` —
`@SearchApiBackend(id = "search_api_ai_anythingllm", label = "AI Search with AnythingLLM")`, extends
`BackendPluginBase`, implements `PluginFormInterface`. Use it by creating a Search API **server** of
this type, then an **index** and a search view.

## Configuration

`buildConfigurationForm()` requires at least one provider that supports the `ai_search_api` operation
type (else it renders an error linking to the AI providers page). It offers one `chat_model` select
whose options are `"<provider_id>__<workspace/model>"` gathered from every such provider
(`getProvidersForOperationType('ai_search_api')`). `getClient()` later explodes that value to pick
the provider instance. `getDiscouragedProcessors()` flags `html_filter`, `stemmer`, `tokenizer`,
`number_field_boost`, `type_boost` as pointless for vector indexing.

## Indexing — `indexItems($index, $items)`

For each item: resolve the entity, gather Search API fields (+ special fields), and call
`groupFieldData()`:

- Fulltext/text fields → `content`; other fields → `meta`. Entity-reference values are converted to
  labels; **file** fields are collected into `uploads` (`filename => file URI`).
- Field values run through `HtmlConverter` (`strip_tags`, `strip_placeholder_links`, table support)
  → Markdown, which LLMs ingest better.
- Fires `hook_search_api_anythingllm_data_alter(&$data, $fields, $context)` before joining `content`.

Then it builds `meta` (`docLang`, `docSource` = the Search API id, `title`, `description` = JSON of
the meta array), deletes any prior copy, and calls the provider's `storeText()`. On success it
records the item's uploaded document names via `AnythingllmItemRepository::upsert()` and uploads each
file field with `storeDocument()`. Returns the list of stored ids.

## Search — `search(QueryInterface $query)`

- Options honored: `search_api_bypass_access` (default FALSE), `search_api_ai_max_pager_iterations`
  (default 10), `search_api_ai_get_chunks_result` (default FALSE), `limit`, `offset`.
- `doSearch()` (recursive) calls the provider's `searchDocuments()` (→ AnythingLLM vector search).
  Because AnythingLLM cannot paginate, when access checks are on it requests `limit * 2` per pass and
  re-queries with a growing offset until it has `limit` accessible hits, `maxAccessRetries` is hit,
  or the source is exhausted.
- **Access control**: unless `search_api_bypass_access` is set, each hit's `docSource`
  (`entity:<type>/<id>:<lang>`) is loaded and checked with
  `$entity->access('view', $this->currentUser)` (`checkEntityAccess()`); denied or unloadable
  entities are skipped. Metadata filters are then applied with the provider's `checkFilters()`.
- **Excerpt/output**: `$match['text']` (after the `</document_metadata>` marker) is converted
  Markdown→HTML with `CommonMarkConverter(['html_input' => 'strip', 'allow_unsafe_links' => FALSE])`
  before being set as the item excerpt; a file extract is prefixed via
  `$this->t('<p>Extract from @file:</p>', ['@file' => …])` (the filename is a `@`-placeholder, so it
  is escaped). Scores below 0.0001 are dropped; duplicate ids keep the higher score.

Results carry extra data `real_offset`, `reason_for_finish`, `current_vector_score`, and can be
sorted by `search_api_relevance`.

## Delete

`deleteItems()` looks up each item's stored document names in the repository, appends the derived
attachment ids, deletes the DB row, and calls the provider's `deleteDocuments()`.
`deleteAllIndexItems()` calls `deleteIndex()` and truncates the repository table.

## Notes

- `viewSettings()` shows the chosen provider label and workspace on the server page.
- All remote calls flow through the selected provider's `ai_provider_anythingllm.api` client (Guzzle
  default TLS, on). Indexing/search run in normal Drupal request/cron contexts, not via any route
  this module defines.
