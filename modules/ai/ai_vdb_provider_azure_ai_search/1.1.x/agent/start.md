<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure AI Search VDB Provider (ai_vdb_provider_azure_ai_search) — agent index

Registers **Azure AI Search** as a vector-database (VDB) provider for the AI module's **AI Search**
submodule: store embeddings in, and run kNN/metadata queries against, an Azure AI Search index. Package
*AI Vector Database Providers (Experimental)*, `lifecycle: experimental`. Core `^10.2 || ^11`. License
GPL-2.0-or-later. Version 1.1.0-beta2 (version-dir `1.1.x`).

Dependencies (info.yml): `ai:ai`, `ai:ai_search (^1.1)`, `key:key`, `search_api:search_api`.
Composer `require`: `drupal/ai ^1.1`, `drupal/key ^1.18`.

- **Configuration, the settings form, config object/schema, routes & permission** →
  [config/settings.md](config/settings.md)
- **The VDB provider plugin + the Azure REST client (methods, query/filter mechanics)** →
  [plugins/vdb-provider.md](plugins/vdb-provider.md)

## What it actually is

- One VDB provider plugin: `AzureAiSearchProvider` (id **`azure_ai_search`**, label *"Azure AI Search DB"*),
  `src/Plugin/VdbProvider/AzureAiSearchProvider.php`, extending `Drupal\ai\Base\AiVdbProviderClientBase`
  and using the `#[AiVdbProvider]` attribute. It appears in the Search API AI-Search "Vector Database"
  selector.
- One REST client service **`azure_ai_search.api`** = `AzureAiSearch` (`src/AzureAiSearch.php`), constructed
  with `@cache.default`, `@messenger`, `@logger.factory`, `@config.factory`, `@entity_type.manager`,
  `@http_client` (Guzzle). Wraps the Azure AI Search Service REST API.
- One value object `ResponseData` (`src/ResponseData.php`) holding status code + decoded JSON body.
- One config settings form `AzureAiSearchConfigForm` at route
  **`ai_vdb_provider_azure_ai_search.settings_form`** → `/admin/config/ai/vdb_providers/azure_ai_search`,
  permission **`administer ai providers`**; menu link under `ai.admin_vdb_providers`.
- Config object **`ai_vdb_provider_azure_ai_search.settings`** (`api_key`, `url`, `api_version`), schema in
  `config/schema/`. **No permissions.yml, no Drush, no hooks, no submodules.**

## Mechanism (from source)

- Azure has no "collection" concept; `createCollection` / `dropCollection` / `getCollections` are no-ops and
  the collection form field is hidden. The **index name** (the form's `database_name`, must match an
  existing Azure index) plays the role of database.
- `getClient()` reads the configured Key name, resolves its value via `key.repository`, and hands it to
  `AzureAiSearch::getClient($key_value)`; the key is sent as the `api-key` **request header**
  (`AzureAiSearch::request()`), never in the URL.
- Writes go through `insert()` / `delete()` → `POST /indexes/{index}/docs/index` with a JSON `value` array
  (`@search.action` = `mergeOrUpload` / `delete`); the doc `id` is the Drupal long id with `:` and `/`
  replaced by `_`.
- Queries: `vectorSearch()` / `querySearch()` call `AzureAiSearch::query()` → `POST
  /indexes/{index}/docs/search` with a JSON body (`vectorQueries` for kNN, optional `filter`); results are
  normalized to `metadata + {distance: @search.score}`.
- `prepareFilters()` / `processConditionGroup()` translate a Search API `ConditionGroup` into a structured
  operator map (`$and`, `$eq`, `$ne`, `$in`, `$nin`, `$gt`…); field values are placed as array data.
- The HTTP client is Drupal's shared Guzzle service (`@http_client`) using default TLS settings; requests
  target the admin-configured HTTPS `url`.

## Notes

- Experimental / beta. The settings-form API-key field help text still references Pinecone (copy/paste
  leftover) — the key is the Azure `api-key`.
- The index must be created in the Azure portal first with the fields the Search API populates; the module
  does not create indexes.
