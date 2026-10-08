<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The OpenAI Vector Store provider, client, mapping & reconciler

Four classes work together: the VDB plugin, the OpenAI SDK wrapper, the mapping store, and the cron
reconciler — plus a search processor.

## Provider plugin — `OpenAiVectorStoreProvider`

`src/Plugin/VdbProvider/OpenAiVectorStoreProvider.php`, `#[AiVdbProvider(id: 'openai_vector_store', label:
'OpenAI Vector Store')]`, extends `AiVdbProviderClientBase`. `getClient()` returns the vector-store client;
`getConfig()` → `ai_vdb_provider_openai.settings` (no schema shipped). Constants: `MAX_ATTRIBUTES=16`,
`MAX_ATTRIBUTE_LENGTH=512`, `MAX_ATTRIBUTE_KEY_LENGTH=64`.

OpenAI's model differs from a raw vector DB, so most primitives are intentionally empty and the high-level
methods are overridden:

| Method | Behaviour |
|---|---|
| `createCollection` / `dropCollection` / `insertIntoCollection` / `deleteFromCollection` / `getVdbIds` | no-ops (`[]`) — stores are external and referenced by ID. |
| `getCollections` | `OpenAiVectorStoreClient::getVectorStoreIds()`. |
| `indexItems` | build Markdown + attributes → checksum → dedupe/re-poll or (delete old +) `createItem` → persist mapping → poll to terminal. Only `completed` counts. |
| `deleteIndexItems` / `deleteAllIndexItems` | look up mapping, `deleteItem` remotely; on remote-delete failure mark row `delete_failed` and keep it. |
| `vectorSearch` | ignores the input vector; `doTextSearch()` with the raw query keys. |
| `querySearch` | returns `[]` (no scalar-only mode). |
| `requiresQueryEmbedding` | FALSE — OpenAI embeds the query, so the backend skips embedding. |
| `prepareFilters` | structured OpenAI attribute filters (below). |
| `buildSettingsForm` / `validateSettingsForm` | the Vector Store ID field + existence check. |

- `buildItemContent()` — uses the embedding strategy's `groupFieldData()`/`buildBaseMetadata()` (only when it
  is an `EmbeddingBase`) to assemble `# title` + contextual + main content as Markdown and a metadata set.
- `prepareAttributes()` — starts with `index_id`, then adds metadata up to 16 entries, truncating keys to 64
  and string values to 512 chars; arrays collapse to their first scalar.
- `doTextSearch()` — flattens query keys (`normalizeSearchKeys`), calls the client `search()` with
  `limit+offset`, the filters, an optional score threshold (`ai_search_score_threshold` processor), and the
  rewrite flag; each returned chunk is given a unique `id` (`file_id:ordinal`) and its content is prefixed
  with the source entity's Title/ID/URI (`prependResultContext()`, loading the entity in the right
  translation).

### Filter building (`prepareFilters` / `processConditionGroup`)

Produces OpenAI's structured filter objects — `['type' => 'eq', 'key' => <field>, 'value' => <value>]`, with
nested `['type' => 'and'|'or', 'filters' => […]]` groups — always including an `index_id eq <index id>`
clause. Operators map via `mapConditionOperator()` (`=`→`eq`, `<>`→`ne`, `>`→`gt`, `>=`→`gte`, `<`→`lt`,
`<=`→`lte`, `IN`→`in`, `NOT IN`→`nin`); unknown operators/fields are dropped. Values are carried as array
data and handed to the OpenAI SDK as request parameters.

## OpenAI client — `OpenAiVectorStoreClient`

`src/Service/OpenAiVectorStoreClient.php` (arg `@ai.provider`). `client()` resolves the OpenAI SDK client via
`aiProviderManager->createInstance('openai')->getClient()` (throws if the provider is not usable) — so the
API key/transport come from `ai_provider_openai`, not this module.

- `createItem()` — `uploadMarkdownFile()` (writes the Markdown to a temp file created with
  `random_bytes`-named 0700 dir, uploads with `purpose: assistants`, then unlinks) → `attachFileToVectorStore()`
  (`vectorStores()->files()->create` with `attributes` + `chunking_strategy`).
- `deleteItem()` — detaches the file from the store (looking the ref up if not supplied) then deletes the
  underlying file.
- `search()` — `vectorStores()->search($id, {query, max_num_results, rewrite_query, filters?,
  ranking_options?})`, normalizing each hit to `{file_id, filename, score, attributes, content}`.
- `pollItemState()` / `getItemState()` — poll `vectorStores()->files()->retrieve` until a terminal status
  (`completed`/`failed`/`cancelled`) or the 15s budget elapses.
- `getVectorStoreIds()` / `listVectorStoreFileRefs()` / `vectorStoreExists()` / `ping()` — listing &
  reachability helpers. `isAvailable()` = the OpenAI provider is usable.

## Mapping store — `OpenAiVectorStoreMappingStore`

`src/Service/…` (args `@database`, `@datetime.time`). Table `ai_vdb_provider_openai_mapping`. Every method
uses the Drupal DB API query builder (`select`/`merge`/`update`/`delete` with `condition()` placeholders):
`getByItem`, `getByFileId`, `getByIndex`, `getByStatus`, `upsert` (merge on index_id+item_id), `update`,
`getDistinctVectorStoreIds`, `getRefsByVectorStore`, `deleteByItem`, `deleteByIndex`. Statuses:
`in_progress`, `completed`, `failed`, `cancelled`, `delete_failed`.

## Reconciler — `OpenAiVectorStoreReconciler`

`runCron()` (from `hook_cron`, only when the provider is available):
- `retryFailedDeletions()` — re-attempts up to 50 `delete_failed` rows; drops or clears each on success.
- `sweepDrift()` — throttled to once per 86400s: for each referenced store, lists remote files vs local
  refs; logs orphans (remote-only), and for dangling rows (local-only, past a 300s grace, in a trackable
  status) removes the mapping and `markItemForReindex()` (`trackItemsUpdated`).

## Query-rewrite processor — `RewriteQuery`

`src/Plugin/search_api/processor/RewriteQuery.php`, `#[SearchApiProcessor(id: 'openai_rewrite_query')]`,
stage `preprocess_query`. `supportsIndex()` requires the `search_api_ai_search` backend with database
`openai_vector_store`. `preprocessSearchQuery()` sets the `ai_vdb_provider_openai_rewrite_query` query option,
which `doTextSearch()` reads to pass `rewrite_query: true` to OpenAI.

## Operate it

- One OpenAI file ↔ one Drupal item; a search may return several chunks of that file, each surfaced as a
  distinct result id so chunked-result mode does not collapse them.
- Entity access is enforced downstream by the AI Search backend via `drupal_entity_id`; this provider just
  supplies content + the entity reference.
- Indexing is synchronous (upload + poll); cron only heals deletions and drift.
