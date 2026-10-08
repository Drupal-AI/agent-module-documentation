<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & setup

## No module settings object; config lives on the Search API server
There is **no** `search_api_meilisearch.settings` config in normal operation (older versions had
one; update hooks 9001/9002 migrated synonyms to the processor and removed it). Connection settings
are the backend plugin configuration on the `search_api_server` config entity.

Schema (`config/schema/search_api_meilisearch.backend.schema.yml`),
`plugin.plugin_configuration.search_api_backend.search_api_meilisearch`:
- `meilisearch_host_address` (text) — default `http://127.0.0.1`
- `meilisearch_host_port` (text) — default `7700`
- `meilisearch_master_key` (text) — default empty

The effective server URL is `host_address:port`. The master key is stored in the server config
entity like any other Search API backend secret (plaintext in config, admin-gated behind Search
API's own permissions; exported with config like every other backend credential).

Processor schema (`config/schema/search_api_meilisearch.processor.schema.yml`),
`plugin.plugin_configuration.search_api_processor.search_api_meilisearch_synonyms`: a `synonyms`
sequence (phrase → list of synonyms), stored in the index config.

## Setup steps (from README)
1. `/admin/config/search/search-api` → add a server, backend **Meilisearch**.
2. Enter host address and port.
3. Enter the master key if the Meilisearch server has one; leave empty if not.
4. Create an index, choose the Meilisearch server, add fields, save.

## Processors provided by the main module
- **Synonyms** (`search_api_meilisearch_synonyms`,
  `src/Plugin/search_api/processor/Synonyms.php`) — associates phrases with synonyms; pushed to
  Meilisearch on index update; reset when disabled.
- **Language filter** (`search_api_meilisearch_language_filter`,
  `src/Plugin/search_api/processor/MeilisearchLanguageFilter.php`).

## Install / update hooks (`search_api_meilisearch.install`)
- `_9001` — migrates legacy `meilisearch_synonyms` config into the Synonyms processor's per-index
  settings.
- `_9002` — removes legacy `meilisearch_id_mappings`, deletes the old settings object, and schedules
  affected indexes for reindex.

## Reserved field name
A Search API field with machine name `id` collides with the Meilisearch document primary key and is
blocked by `search_api_meilisearch_search_api_index_presave()` and form validators in
`search_api_meilisearch.module`.
