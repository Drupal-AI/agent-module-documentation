<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAI VDB Provider (ai_vdb_provider_openai) — agent index

Registers **OpenAI's hosted Vector Store** as a vector-database provider (plugin id
**`openai_vector_store`**, label *"OpenAI Vector Store"*) for the AI module's **AI Search** submodule.
Content is uploaded to OpenAI as Markdown files; OpenAI does the chunking/embedding/storage; search is a
**text query** (OpenAI embeds it server-side). Package *AI Vector Database Providers (Experimental)*. Core
`^10.4 || ^11`. License GPL-2.0-or-later. Version 1.0.0-alpha3 (version-dir `1.0.x`). **Alpha — not
production-ready.**

Dependencies (info.yml): `ai:ai`, `ai:ai_search (^1.2)`, `key:key`, `ai_provider_openai:ai_provider_openai`.

- **Install, the per-server Vector Store ID setting, the mapping table, cron** →
  [config/settings.md](config/settings.md)
- **The provider plugin, the OpenAI client, indexing/search/filters, reconciler, the query-rewrite processor** →
  [api/provider.md](api/provider.md)

## What it actually is

- VDB provider plugin `OpenAiVectorStoreProvider` (`src/Plugin/VdbProvider/…`), `#[AiVdbProvider]`, extends
  `Drupal\ai\Base\AiVdbProviderClientBase`. Injected with the two services below plus config/key/entity
  managers.
- Service **`ai_vdb_provider_openai.vector_store`** = `OpenAiVectorStoreClient` (arg `@ai.provider`) — wraps
  the OpenAI PHP SDK (obtained from the `ai_provider_openai` provider) for file upload / vector-store
  attach / search / delete / poll.
- Service **`ai_vdb_provider_openai.mapping_store`** = `OpenAiVectorStoreMappingStore` (args `@database`,
  `@datetime.time`) — the item↔file mapping table (`ai_vdb_provider_openai_mapping`, defined in
  `hook_schema()`), all access via the Drupal DB API.
- Service **`ai_vdb_provider_openai.reconciler`** = `OpenAiVectorStoreReconciler` — cron drift/retry logic.
- Search API processor plugin `RewriteQuery` (id **`openai_rewrite_query`**) — toggles OpenAI's
  `rewrite_query` at search time.
- Logger channel `logger.channel.ai_vdb_provider_openai`.
- Hooks (`.module`): `hook_cron` (→ reconciler), `hook_form_search_api_index_fields_alter` (warn over the
  16-attribute limit).
- **No routes, no permissions.yml, no config schema, no Drush, no submodules.** The only persistent config is
  the per-server *Vector Store ID* on the Search API backend form.

## Mechanism (from source)

- `indexItems()` builds Markdown from the item (`buildItemContent()` via the embedding strategy's
  `groupFieldData()`/`buildBaseMetadata()`), checksums it, and — if unchanged & completed — skips;
  otherwise deletes the prior file and `createItem()`s a new one (`OpenAiVectorStoreClient::createItem` →
  upload file, attach to the store), persists the mapping, then polls to a terminal status. Only `completed`
  files count as indexed.
- Vector stores are referenced by an existing **ID** (`vs_...`) per Search API server; the module never
  creates/drops stores, so `createCollection()`/`dropCollection()`/`insertIntoCollection()` are no-ops.
- `vectorSearch()` ignores the pre-computed vector and calls `OpenAiVectorStoreClient::search()` with the
  raw query text; `requiresQueryEmbedding()` returns FALSE so the backend skips its own embedding.
- `prepareFilters()` builds OpenAI attribute filters as structured arrays (`{type,key,value}` with `and`/`or`
  groups), always including `index_id = <index>`; operators map `=`→`eq`, `IN`→`in`, etc.
- Attributes: max 16 per file (`MAX_ATTRIBUTES`), keys ≤64 / string values ≤512 chars; `index_id` reserved.
- `hook_cron` → reconciler: retries `delete_failed` rows and, at most daily, sweeps drift (logs orphans,
  removes dangling mappings + re-queues those items).

## Notes

- Requires an OpenAI API key configured on the **`ai_provider_openai`** provider (Key module); this module
  fetches the SDK client from that provider and holds no key of its own.
- Alpha: facet counts and custom field sorting are unsupported; results are relevance-ranked only.
