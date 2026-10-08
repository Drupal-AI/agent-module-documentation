<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal RAG (drupal_rag) — agent index

Self-hosted **Retrieval-Augmented Generation** for Drupal 11: indexes selected content/media as
vector embeddings in **pgvector** via a local **Ollama** server, then serves retrieval, prompt, and
generated-answer HTTP endpoints. Package `Search`. License GPL-2.0-or-later.

> **Documented release is `1.0.0-alpha5` — a pre-release alpha, not covered by Drupal's security
> advisory policy.** APIs and schema may change; evaluate before production use.

- **Dependencies (Drupal):** `system`, `node`, `media` (info.yml). Composer requires
  `prinsfrank/pdfparser:^2.8` (PDF text extraction).
- **External infrastructure (NOT Drupal modules):** PostgreSQL with the **pgvector** extension
  (a database connection named `pgvector` must exist in `settings.php`) and a reachable **Ollama**
  server. Ollama needs no API key.

## Solution docs

- **Settings form, config object/schema, install, DB + infra setup** →
  [config/settings.md](config/settings.md)
- **HTTP endpoints (`RagQueryController`): query / prompt / augment / status** →
  [api/endpoints.md](api/endpoints.md)
- **Indexing + query pipeline services (hooks → queue → extract → chunk → embed → store → search)** →
  [services/pipeline.md](services/pipeline.md)
- **Drush command + queue backfill** → [drush/commands.md](drush/commands.md)

## What it provides (from source)

- **Routes** (`drupal_rag.routing.yml`): `drupal_rag.settings` (`/admin/config/search/drupal-rag`,
  form, `administer site configuration`); `drupal_rag.query|prompt|augment`
  (`POST /api/rag/query|prompt|augment`, `_permission: 'access rag query'`, `_format: json`);
  `drupal_rag.status` (`/admin/reports/drupal-rag`, `administer site configuration`).
- **Permissions** (`drupal_rag.permissions.yml`): `access rag query`; `administer drupal rag`
  (`restrict access: true`). NOTE the settings/status *routes* actually require the core
  `administer site configuration` permission, not `administer drupal rag`.
- **Config** (`drupal_rag.settings`): `enabled_entity_types` (default `[node]`), `chunk_size`
  (1000), `chunk_overlap` (200), `ollama_base_url` (`http://172.17.0.1:11434`), `ollama_model`
  (`nomic-embed-text`), `ollama_chat_model` (''), `view_mode` (`full`), `prompt_template`. Schema in
  `config/schema/drupal_rag.schema.yml`; install defaults in `config/install/`.
- **Plugin (instance):** `DrupalRagEntityProcessingWorker` — QueueWorker id
  `drupal_rag_entity_processing` (`cron: {time: 60}`).
- **Services** (`drupal_rag.services.yml`): `entity_hooks`, `ollama_client`, `file_text_extractor`,
  `entity_extractor`, `chunker`, `vector_storage`, `embedding_service`, `query_service`,
  `augment_service`.
- **Hooks** (`drupal_rag.module` → `Hooks\EntityHooks`): `entity_insert`, `entity_update`,
  `entity_delete` (queue on-save/delete; `entity_presave` is a disabled placeholder).
- **Drush:** `drupal-rag:queue-all` (alias `rag:qa`) — `Drush\Commands\DrupalRagQueueCommands`.
- **DB table:** `drupal_rag_embeddings` (native `vector(768)`, HNSW cosine index) on the `pgvector`
  connection; created lazily by `VectorStorage::ensureTable()` (no hook_schema/hook_install table).
