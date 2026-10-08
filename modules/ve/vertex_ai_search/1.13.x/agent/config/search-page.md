<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search — search page configuration

## Install / enable
- Requires the Google client library: `composer require google/cloud-discoveryengine` (^1.0.0). Also
  requires `drupal/token`; `drupal/restui` is a composer requirement (only the REST resource needs it).
  `vertex_ai_search_requirements()` (`.install`) fails install if
  `Google\Cloud\DiscoveryEngine\V1\Client\SearchServiceClient` is not autoloadable.
- Enable `vertex_ai_search` (pulls core `search`, `token`). No settings route — pages are created under
  **Configuration » Search and metadata » Search pages** by adding a page of type "Vertex AI Search".
- Update hook `vertex_ai_search_update_10001()` grants each existing Vertex page's permission to the
  anonymous and authenticated roles.

## Where config lives
No module-level config object. Each page is a core `search_page` config entity; its `configuration`
mapping is defined by schema `search.plugin.vertex_ai_search` (`config/schema/vertex_ai_search.schema.yml`).
Defaults come from `VertexAISearch::defaultConfiguration()`. The plugin form is built by
`VertexAISearch::buildConfigurationForm()` (grouped `details` sections) and saved by
`submitConfigurationForm()`.

## Authentication + serving config fields
- `service_account_credentials_file` (string, **required**) — path to a Google **service-account JSON**
  key file, read server-side with `file_get_contents()` and passed to `ServiceAccountCredentials` /
  the Discovery Engine clients. Keep the file outside the web root.
- `google_cloud_project_id`, `google_cloud_location` (default `global`), `vertex_ai_data_store_id`,
  `vertex_ai_serving_config` (default `default_search`) — combined via
  `SearchServiceClient::servingConfigName()` to target the Vertex app.
- `vertex_ai_advanced_indexing` (bool) — enables snippet spec / structured-data handling for advanced
  website indexing data stores.
- Form AJAX helpers: **Lookup Project** (`lookupProject()`) reads the cred file and shows its
  `project_id`; **Lookup Data Stores** (`lookupDatastores()`) calls `DataStoreServiceClient::listDataStores`
  to list data store IDs. Both are on the admin config form only.

## Display / behavior fields (selected)
- `resultsPerPage` (10–100), `totalResultsLimit` (default 100), `pagerType` (`STANDARD` or `VERTEX`).
- `result_parts` (`TITLE` | `SNIPPETS`), `safeSearch` (bool), `removeDomain` (bool → relative result links).
- `spelling_correction_mode` (`AUTO` | `SUGGESTION_ONLY` | `MODE_UNSPECIFIED`).
- `displaySearchForm` (bool; the SERP form is hidden by default), plus `classSearchKeys`,
  `searchInputAriaLabel`, `classSearchSubmit`, `searchSubmitAriaLabel`.
- Autocomplete: `autocomplete_enable`, `autocomplete_enable_block`, `autocomplete_trigger_length`
  (default 4), `autocomplete_max_suggestions` (default 10), `autocomplete_source`, `autocomplete_model`,
  `autocomplete_content_types[]`, `pluginElements[]`.
- Configurable JS: `js_enable`, `js_plugin[]`, `regex_patterns`.
- Exclusion list: `exclusion_list_enable`, `exclusion_list` (one word/phrase/regex per line; applied by
  `VertexSearchManager::applyExclusionList()` via `preg_replace`).
- Filter/order: `filter_enable`, `filter_plugin`, `filter_only_searches`,
  `results_message_filter_only_searches`, `order_enable`, `order_plugin`.
- Flood: `flood_enable`, `flood_threshold` (default 100), `flood_window` (default 3600), `flood_message`.
- Messages (token-aware): `results_message`, `results_message_singular`, `no_results_message`,
  `no_keywords_message`, `correction_made_message`, `correction_suggestion_message`.
- Advanced: `transport_method` (default `rest`, passed to the Google client), `disable_google_api_queries`
  (bool — dev mode, returns a canned sample result with no API call), `default_client_search_path`
  (used by the REST resource for building client URLs).

## Routes & permissions
- Results page: the core `search_page` path. Access is gated by the plugin's `access()`
  (`AccessibleInterface`), which checks the per-page permission `use <id> custom search page`
  (cache-per-permissions). Permissions are generated dynamically by
  `VertexAISearchAccessController::retrieveVertexPagePermissions()` (`vertex_ai_search.permissions.yml`
  `permission_callbacks`).
- `vertex_ai_search.autocomplete` — `/vertex_autocomplete/{search_page_id}`, JSON, controller
  `AutocompleteController::handleAutocomplete`.
- REST resource route `/search/vertex/v1/{search_page}` (see `agent/api/services-rest-tokens.md`).

## Runtime flow
`VertexAISearch::execute()` → `VertexSearchManager::executeSearch($config, $params)`:
Xss-filters `keys`, checks flood, honors `disable_google_api_queries` (sample result), builds a
`SearchRequest` (`prepareSearchRequest()`), sends it (`performVertexSearch()` using
`ServiceAccountCredentials` + `SearchServiceClient`), parses results, runs curated-results plugins,
replaces message tokens, sets display messages, registers flood, creates the pager. `buildResults()`
renders each result via the `vertex_ai_search_result` theme (title/snippet emitted as filtered
`#markup`).
