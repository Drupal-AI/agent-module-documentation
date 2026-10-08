<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Knowledge Connector — configuration, routes & permissions

## Install / enable

`drush en ai_knowledge_connector`. Only core `system` is required. `hook_schema()`
(`ai_knowledge_connector.install`) creates two tables on install:

- `ai_knowledge_connector_index` — one row per indexed entity/revision/langcode: `entity_type`,
  `entity_id`, `revision_id`, `langcode`, `document_id`, `content_hash` (sha256), `indexed_at`.
  Unique keys on `(entity_type, entity_id, revision_id, langcode)` and on `document_id`.
- `ai_knowledge_connector_vectors` — the `local` vector store payloads: `document_id` (PK),
  `embedding` (JSON), `content`, `metadata` (JSON), `updated_at`.

## Config object `ai_knowledge_connector.settings`

Install defaults (`config/install/ai_knowledge_connector.settings.yml`), schema in
`config/schema/ai_knowledge_connector.schema.yml` (`type: config_object`):

| Key | Default | Meaning |
|---|---|---|
| `vector_store` | `local` | VectorStore plugin id used for upsert/search/health. |
| `local.table` | `ai_knowledge_connector_vectors` | Table for the local store. |
| `qdrant.host` / `.port` / `.collection` | `localhost` / `6333` / `drupal` | Present in default config + schema, but **no Qdrant plugin ships** — inert until a `qdrant` VectorStore plugin is added. |
| `embedding_provider` | `local` | `local` = deterministic hash embedding; any other value = a Drupal AI provider plugin id resolved via `@?ai.provider_manager`. |
| `embedding_model` | `''` | Model passed to the AI provider (`local-hash-256` used for local). |
| `chunk_strategy` | `fixed_size` | ChunkStrategy plugin id. |
| `chunk_size` | `500` | Characters per chunk (min enforced 100). |
| `chunk_overlap` | `50` | Overlap chars (clamped to `size-1`). |
| `retrieval_strategy` | `semantic` | RetrievalStrategy plugin id. |
| `top_k` | `10` | Default result count for retrieval. |
| `index_published_only` | `true` | When true, unpublished entities are skipped (and their vectors deleted). |
| `enabled_entity_types` | `node`, `taxonomy_term`, `media` | Sequence of content entity type ids that are indexed. |

## Admin routes & permissions

Defined in `ai_knowledge_connector.routing.yml` / `.permissions.yml`; menu links in
`.links.menu.yml` place the config items under `ai.admin_config_infrastructure`.

- **`/admin/config/ai/knowledge`** → `Form\SettingsForm` (`ai_knowledge_connector.settings`).
  Permission **`administer ai knowledge connector`** (`restrict access: true`). Fields map 1:1 to
  the config keys above. `vector_store`, `chunk_strategy`, `retrieval_strategy` are selects built
  from the plugin managers' definitions; `enabled_entity_types` is a checkboxes list of all
  entity types implementing `ContentEntityInterface`. `embedding_provider`/`embedding_model` are
  free-text (you type a Drupal AI provider plugin id). Standard `ConfigFormBase` POST + CSRF.
- **`/admin/config/ai/reindex`** → `Form\ManualReindexForm`. Permission **`reindex ai knowledge`**
  (`restrict access: true`). Submit calls `ReindexScheduler::scheduleAll()` which loads every
  entity of each enabled type and queues it. Standard POST form (CSRF-protected).
- **`/admin/reports/ai-index`** → `Controller\IndexStatusController::status`. Permission
  **`view ai indexing status`**. Renders the 100 most recent index rows as a `#type => 'table'`
  (auto-escaped cells).
- **`/admin/reports/vector-store`** → `Controller\VectorStoreHealthController::health`. Permission
  **`view ai indexing status`**. Renders the active store's `health()` array as a table.
- Extra permissions **`manage vector stores`** and **`manage ai providers`** are declared
  (`restrict access: true`) but not attached to any route in this release.

## Operating it

1. On `/admin/config/ai/knowledge` pick the entity types to index and (optionally) a real AI
   provider id + model; otherwise leave `local` for offline deterministic embeddings.
2. New/updated content is queued automatically. Run cron (or `drush queue:run
   ai_knowledge_connector.entity_embedding_queue`) to process the queue.
3. Use `/admin/config/ai/reindex` to enqueue everything after a config change or first install.
4. Watch progress on `/admin/reports/ai-index`; confirm the store on `/admin/reports/vector-store`.
5. Consume results from another module via the `ai_knowledge_connector.retrieval_manager` service
   — see [../api/pipeline.md](../api/pipeline.md).
