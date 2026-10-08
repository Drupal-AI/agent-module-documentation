<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form, config, and infrastructure setup

## Install & enable

```bash
composer require drupal/drupal_rag
drush en drupal_rag -y
```

Composer pulls `prinsfrank/pdfparser:^2.8` (PDF extraction). Drupal deps: `system`, `node`, `media`.

**External infrastructure (required, not Drupal modules):**

1. **PostgreSQL + pgvector.** A dedicated connection named `pgvector` must exist in
   `settings.php` — `VectorStorage::__construct()` calls
   `Database::getConnection('default', 'pgvector')`. Point it at a PostgreSQL DB with the pgvector
   extension installed. Credentials live in `settings.php` `$databases['pgvector']['default']`; the
   module holds no DB credentials of its own.
   ```php
   $databases['pgvector']['default'] = [
     'driver' => 'pgsql', 'host' => '...', 'database' => '...',
     'username' => '...', 'password' => '...', 'prefix' => '',
   ];
   ```
2. **Ollama** reachable from the web container, with an embedding model pulled (e.g.
   `nomic-embed-text`, `all-minilm`). No API key. For a Docker host, set the base URL to something
   like `http://172.17.0.1:11434` and run `OLLAMA_HOST=0.0.0.0 ollama serve`.

`hook_install()` (`drupal_rag.install`) seeds `enabled_entity_types = ['node']` and the default
`prompt_template` (from `AugmentService::defaultTemplate()`) if they are empty. The
`drupal_rag_embeddings` table is created lazily on first write by `VectorStorage::ensureTable()`
(raw `CREATE TABLE … embedding vector(768)` + `CREATE INDEX … USING hnsw (embedding
vector_cosine_ops)`), not by a schema hook.

## Settings form

`Form\RagSettingsForm` (`ConfigFormBase`, form id `drupal_rag_settings`) at
**`/admin/config/search/drupal-rag`** (route `drupal_rag.settings`, `_permission: 'administer site
configuration'`; menu link under *Configuration → Search and metadata*). Edits config object
**`drupal_rag.settings`**.

| Field | Config key | Default | Notes |
|---|---|---|---|
| Enabled Entity Types | `enabled_entity_types` | `['node']` | Checkboxes of every entity type definition; only ticked types are indexed. |
| Chunk size | `chunk_size` | `1000` | number, required, min 100 max 10000. |
| Chunk overlap | `chunk_overlap` | `200` | number, required, min 0 max 5000. |
| Ollama base URL | `ollama_base_url` | `http://172.17.0.1:11434` | textfield, required. Admin-only value. |
| Embedding model | `ollama_model` | `nomic-embed-text` | select; options fetched live via `OllamaClient::getOllamaModels()` (`GET /api/tags`), split into "Embedding models" (name contains `embed`) vs "Chat models". |
| Chat model | `ollama_chat_model` | `''` | select; empty = reuse embedding model for `/api/rag/augment`. |
| View mode | `view_mode` | `full` | select: Full / Teaser / RSS. Used when rendering non-file entities for extraction. |
| Prompt template | `prompt_template` | see below | textarea (in a collapsed "RAG prompt template" details); placeholders `{{context}}`, `{{query}}`. |

Schema: `config/schema/drupal_rag.schema.yml` (`drupal_rag.settings` config_object;
`enabled_entity_types` sequence of strings, the rest integer/string/text).

**"Test connection" button** (`testOllamaConnection` AJAX callback): issues
`GET {base_url}/api/ps` with the core `http_client` and renders success/error markup (error text is
`Html::escape()`d). `#limit_validation_errors => []` so it works before saving.

### Default prompt template

```text
<system>
You are a helpful assistant. Answer the user's question based ONLY on the
context provided below. If the context does not contain enough information
to answer, say "I don't have enough information." Cite the source
(entity_type:entity_id) for each claim.
</system>

<context>
{{context}}
</context>

<question>
{{query}}
</question>

<answer>
```

`AugmentService::buildPrompt()` fills `{{context}}` (assembled chunk blocks) and `{{query}}` via
`strtr()`; if the stored template is empty it falls back to `AugmentService::defaultTemplate()`.

## Permissions

`drupal_rag.permissions.yml` defines `access rag query` (gates the three `/api/rag/*` endpoints) and
`administer drupal rag` (`restrict access: true`). NOTE: the settings and status routes are gated by
core `administer site configuration`, so `administer drupal rag` is declared but not referenced by
any route in this release.
