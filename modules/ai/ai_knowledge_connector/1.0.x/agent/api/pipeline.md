<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Knowledge Connector — pipeline, services & plugin types

## Indexing flow (from source)

1. **Trigger** — `.module`: `hook_entity_insert` / `hook_entity_update` →
   `ai_knowledge_connector_queue_entity()`. It skips non-content entities, entities whose type is
   not in `enabled_entity_types`, and (when `index_published_only`) unpublished ones, then puts
   `{entity_type, entity_id, revision_id, langcode}` on the `entity_embedding_queue`.
   `hook_entity_delete` → `IndexManager::deleteEntity()`.
2. **Queue** — `Plugin/QueueWorker/EntityEmbeddingQueue::processItem()` loads the entity, switches
   to the requested translation, and calls `IndexManager::indexEntity()`. `ReindexQueue` is a
   subclass alias (same behavior, separate queue id).
3. **Index** — `Service/IndexManager::indexEntity()`:
   - `shouldIndex()` re-checks enabled type + published-only; if not indexable it deletes any
     existing vectors and returns.
   - `findExtractor()` picks the first `EntityExtractor` plugin whose `supports()` is true.
   - `MetadataManager::enrich()` adds `cache_tags`, `cache_contexts`, active `workspace`, and
     `published` to the document metadata.
   - Computes `sha256(content + serialize(metadata))`; `hasChanged()` compares to the stored
     `content_hash` and returns early if unchanged (incremental indexing).
   - Deletes old vectors, then `ChunkManager::chunk()` → for each chunk
     `EmbeddingManager::embed()` → `VectorStore::upsert()`; finally `merge()`s the index-table row.
4. **Bulk** — `Form\ManualReindexForm` → `Service/ReindexScheduler::scheduleAll()` (and
   `IndexManager::reindexAll()`) load all entities of each enabled type with `accessCheck(FALSE)`
   — standard for a background indexer — and enqueue them.

## Extraction & chunking

- `Plugin/EntityExtractor/ContentEntityExtractor::extract()` concatenates `label()` plus every
  field's scalar property values, **`strip_tags()`-ing each value** (no raw HTML kept), skipping
  system fields (`uuid`, `vid`, `langcode`, `target_id`, `format`, …). Builds
  `document_id = type:id:revision:langcode` and metadata (`entity_type`, `entity_id`,
  `revision_id`, `langcode`, `bundle`, canonical `url`).
- `Plugin/ChunkStrategy/FixedSizeChunkStrategy::chunk()` slides a `mb_substr` window of
  `chunk_size` with `chunk_overlap`, emitting `ValueObject/Chunk` items keyed
  `…:chunk:N` with `parent_document_id` + `chunk_delta` metadata.

## Embedding

- `Service/EmbeddingManager::embedText()`: if `embedding_provider !== 'local'` and the optional
  `ai.provider_manager` is present, it calls `$provider->embeddings($text, $model)` and normalizes
  the result (`normalizeProviderEmbedding()` handles a numeric array, an `['embedding' => …]`
  array, or an object with `getEmbedding()`). Any `\Throwable` falls back to the local embedding
  so indexing stays resumable — the module never makes a direct HTTP call itself; remote calls (and
  API keys) are the AI provider's responsibility.
- Local fallback `localEmbedding()`: a deterministic 256-dim vector — token sha256 → bucket, then
  L2-normalized. Produces `Embedding($vector, 'local', 'local-hash-256')`. Not semantically
  meaningful; for development/tests only.

## Vector store (plugin type `VectorStore`)

`Contract/VectorStoreInterface`: `upsert()`, `delete()`, `search(array $embedding, int $limit)`,
`health()`. Shipped `Plugin/VectorStore/LocalVectorStore` (id `local`) stores rows in
`ai_knowledge_connector_vectors`, and `search()` loads **all** rows and ranks them by
`cosineSimilarity()` in PHP (fine for dev/small data; O(n) per query). `delete()` uses a
parameterized `LIKE 'prefix%'` so deleting a document removes all its chunks. To use Qdrant/etc.,
implement a new `@VectorStore` plugin and select it in settings.

## Retrieval (public API)

- Service **`ai_knowledge_connector.retrieval_manager`** (`Service/RetrievalManager`) is the entry
  point for RAG consumers:
  - `search(string $query, ?int $limit): array` — instantiates the configured RetrievalStrategy
    and returns `[{document, score}, …]`.
  - `buildContext(string $query, ?int $limit): string` — formats the top results into a
    `"[title | score]\n content"` block joined by `---`, ready to inject into a prompt.
- `Plugin/RetrievalStrategy/SemanticRetrievalStrategy` (id `semantic`) embeds the query via
  `EmbeddingManager::embedText()` and calls the vector store's `search()` with `top_k`.
- Retrieval is a service-only API: this module exposes **no route** that returns document content
  to a browser. Any access filtering for a RAG endpoint is the responsibility of the consuming
  module that calls `RetrievalManager` and renders the results.

## Extending

Add plugins by dropping an annotated class under `src/Plugin/<Type>/` implementing the matching
`Contract/*Interface`: `EntityExtractorInterface` (`supports`/`extract`), `ChunkStrategyInterface`
(`chunk`), `RetrievalStrategyInterface` (`retrieve`), `VectorStoreInterface`. Annotation classes
live in `src/Annotation/`; managers in `src/PluginManager/`. Value objects
(`KnowledgeDocument`, `Chunk`, `Embedding`) are immutable with `with*()` copies.
