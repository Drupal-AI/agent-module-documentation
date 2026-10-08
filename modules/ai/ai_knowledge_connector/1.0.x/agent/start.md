<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Knowledge Connector (ai_knowledge_connector) — agent index

A self-contained RAG indexing + retrieval pipeline. It extracts Drupal content entities into
knowledge documents, chunks them, embeds each chunk, and upserts vectors into a pluggable vector
store; other modules call its retrieval service for semantic context. Package **AI**. Version
**1.0.0-alpha2** (version dir `1.0.x`). Core `^11`. License GPL-2.0-or-later. Depends **only on
core `system`**; `ai.provider_manager` is an optional soft dependency (`@?`) used only when a
non-`local` embedding provider is configured.

- **Install, config object + schema, routes, permissions, admin UI, operating it** →
  [config/settings.md](config/settings.md)
- **The indexing/retrieval pipeline, services, plugin types, queue, hooks, DB tables** →
  [api/pipeline.md](api/pipeline.md)

## What it actually is (from source)

- **Four plugin types** (annotation-based managers, all `parent: default_plugin_manager`):
  - `VectorStore` — ships `LocalVectorStore` (id `local`, `ai_knowledge_connector_vectors` table,
    brute-force cosine similarity in PHP). No remote store plugin ships.
  - `EntityExtractor` — ships `ContentEntityExtractor` (id `content_entity`).
  - `ChunkStrategy` — ships `FixedSizeChunkStrategy` (id `fixed_size`).
  - `RetrievalStrategy` — ships `SemanticRetrievalStrategy` (id `semantic`).
- **Services** (`*.services.yml`): `embedding_manager`, `chunk_manager`, `metadata_manager`,
  `index_manager`, `retrieval_manager`, `reindex_scheduler`, plus the four plugin managers.
  `ai_knowledge_connector.retrieval_manager` is the public API for RAG consumers.
- **Hooks** (`.module`): `hook_entity_insert/update` queue the entity; `hook_entity_delete`
  removes its vectors. Only content entity types listed in `enabled_entity_types` are queued.
- **Queue workers**: `ai_knowledge_connector.entity_embedding_queue` (does the work) and
  `ai_knowledge_connector.reindex_queue` (a subclass alias). Both `cron = {"time" = 30}`.
- **Config**: one config object `ai_knowledge_connector.settings` (schema + install defaults
  present). No config entities, no content entities, no Drush commands.
- **DB tables** (`.install`): `ai_knowledge_connector_index` (entity→hash tracking) and
  `ai_knowledge_connector_vectors` (local vector payloads).

## Routes & permissions (`*.routing.yml` / `*.permissions.yml`)

- `/admin/config/ai/knowledge` → `SettingsForm` — perm `administer ai knowledge connector`.
- `/admin/config/ai/reindex` → `ManualReindexForm` — perm `reindex ai knowledge`.
- `/admin/reports/ai-index` → `IndexStatusController::status` — perm `view ai indexing status`.
- `/admin/reports/vector-store` → `VectorStoreHealthController::health` — perm
  `view ai indexing status`.
- Permissions also declared but not yet route-bound: `manage vector stores`, `manage ai providers`.
- Every route is permission-gated; both forms are standard Drupal FAPI POST forms (CSRF-protected).
  No routes for anonymous/low-priv access, no request-supplied URL fetched server-side.
