<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Typesense (search_api_typesense) — agent index

Search API backend for the [Typesense](https://typesense.org) search server. Registers a
`search_api_typesense` backend plugin plus Typesense-specific Search API data types, and adds
admin tabs on every Search API server/index for managing the Typesense collection: schema,
synonyms, curations, stopwords, API keys, conversation models, metrics, import/export, and an
InstantSearch-powered front-end search block. Supports vector embeddings + semantic/conversational
("Converse") search.

- **Version:** 1.1.2 · **Core:** `>10.3 || ^11` · **PHP:** `>=8.1` · **License:** GPL-2.0-or-later
- **Depends on:** `search_api` (module) and Composer libs `typesense/typesense-php:v5.1`,
  `drupal/search_api`. Optional runtime integration with `ai` + an AI provider (`ai_provider_openai`)
  and `key` for embedding/converse features.
- **No submodules. No Drush commands.**

## What it provides

- **Backend plugin** `search_api_typesense` —
  `src/Plugin/search_api/backend/SearchApiTypesenseBackend.php` (indexing, delete, schema sync,
  server config form). See [plugins/backend.md](plugins/backend.md).
- **Data type plugins** `typesense_string|int32|int64|float|bool|geopoint` and `[]` multi variants —
  `src/Plugin/search_api/data_type/*`. `supportsDataType()` accepts any `typesense_*` type.
- **Config entity** `typesense_schema` (`src/Entity/TypesenseSchema.php`) — the per-index Typesense
  collection schema; `admin_permission = administer search_api`. Form: `src/Form/SchemaForm.php`.
- **Config entity** `document_splitter` — fixed-length chunker for embeddings
  (`src/DocumentSplitter/FixedLengthDocumentSplitter.php`, service
  `search_api_typesense.document_splitter`), managed at `/admin/structure/document-splitter`.
- **Block** `search_api_typesense_search_block` (`src/Plugin/Block/TypesenseSearchBlock.php`) —
  InstantSearch UI over one or more collections. See [blocks/search-block.md](blocks/search-block.md).
- **API client** `TypesenseClient` / `Config` (`src/Api/*`) wrapping `typesense/typesense-php`. See
  [api/client.md](api/client.md).
- **Services:** `logger.channel.search_api_typesense`, `search_api_typesense.ai_models`,
  `search_api_typesense.document_splitter`, `search_api_typesense.render_service`,
  two access-check services, and `Hook\SearchApiTypesenseHooks` (help/theme/form_alter).
- **Routes / tabs / permissions:** server + index management routes and the three custom
  permissions. See [config/management-routes.md](config/management-routes.md).
- **Server backend configuration** (nodes, API key, nearest node, public endpoint, timeout):
  [config/backend-server.md](config/backend-server.md).
- **Config objects:** `search_api_typesense.settings` (built-in `ts_embedding_models`),
  `search_api_typesense.search_keys` (per-server search-only keys), plus schema in
  `config/schema/search_api_typesense.schema.yml`.

## Getting started (order matters)

1. Run a Typesense server; enable this module (`ddev drush en search_api_typesense -y`).
2. Create a Search API **server** using the "Search API Typesense" backend; set the admin API key,
   node host/port/protocol, timeout ([config/backend-server.md](config/backend-server.md)).
3. Create a Search API **index** on that server; add fields (include at least one numeric sort field).
4. Configure the collection **Schema** tab (`.../index/{id}/schema`) — indexing fails until done.
5. Index content; optionally place the search block and manage synonyms/curations/stopwords/keys.
