<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Meilisearch (search_api_meilisearch) — agent index

**Meilisearch backend for Search API.** Registers a `search_api_meilisearch` Search API
backend plugin that talks to a Meilisearch server over its HTTP API via the official
`meilisearch/meilisearch-php` SDK. Version **2.1.0**, core `^9.3 || ^10 || ^11`,
depends on `search_api` (`^1.29`). Package: Search. License GPL-2.0-or-later.
Maintained by AGILEDROP.

## What it provides
- **Backend plugin** `search_api_meilisearch` (`src/Plugin/search_api/backend/SearchApiMeilisearchBackend.php`)
  — implements `AutocompleteBackendInterface`, `PluginFormInterface`, `SpecialFieldsInterface`.
- **Processors**: `search_api_meilisearch_synonyms` (Synonyms) and
  `search_api_meilisearch_language_filter` (Language filter).
- **Config schema only** — no permissions, no routes, no Drush commands, no config *entities*
  of its own. Connection config lives on the Search API `search_api_server` entity.
- **Submodules**: `search_api_meilisearch_autocomplete` (needs `search_api_autocomplete`),
  `search_api_meilisearch_facets` (needs `facets`).

## Key mechanism (verified from source)
- Backend constructor sets the client URL from `meilisearch_host_address . ':' . meilisearch_host_port`
  and the key from `meilisearch_master_key` (backend config, stored on the server entity).
- `MeilisearchClientFactory::getInstance($url, $key)` builds a `Meilisearch\Client` using a custom
  Guzzle adapter (`src/Client/Client.php`) — **default TLS verification (Guzzle default), only
  `http_errors => FALSE` is set**; no `verify => false` anywhere.
- `MeilisearchApiService` (shared: FALSE) wraps all index/document/settings/keys/search calls;
  the master key is passed to the SDK as the API key (Authorization header) — never emitted to
  the page, drupalSettings, or JS.
- Query translation: `StringExpressionFilterParser` + tagged condition parsers build Meilisearch
  filter strings; `MeilisearchUtils::formatConditionValue()` escapes `\` and `"` and quotes
  non-numeric values. `ItemConverter` + field converters map Search API items to documents.
- Reserved field name: Search API field machine name `id` is forbidden (reserved for the
  Meilisearch document primary key) — enforced in `search_api_meilisearch.module` and on document build.

## Where to look
- `backend/index.md` — the backend plugin: config form, lifecycle, indexing, query/sort/filter mapping.
- `config/index.md` — how host/port/master key are stored and defaults.
- `api/index.md` — `MeilisearchApiService` methods and the client factory / Guzzle adapter.
- `submodules/index.md` — autocomplete and facets submodules.

## Operational notes
- Meilisearch must not be internet-reachable; Drupal should hold a scoped search key where the
  deployment allows (the config field is labelled "Master Key" but accepts any Meilisearch key).
- Meilisearch holds its index in memory — large corpora become an infrastructure question.
