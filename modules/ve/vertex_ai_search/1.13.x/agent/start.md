<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search (vertex_ai_search) — agent index

Provides a **core Search page plugin** (`vertex_ai_search`) that runs queries against a **Google Vertex AI
Search / Discovery Engine** app via the `google/cloud-discoveryengine` PHP client. Version **1.13.x**.
Core `^10.1 || ^11 || ^12`. Depends on core `search`, `token` (info.yml); `drupal/restui` + the
Discovery Engine library are composer requirements. No submodules.

## What it provides
- **Search plugin** `Drupal\vertex_ai_search\Plugin\Search\VertexAISearch` (`@SearchPlugin id="vertex_ai_search"`),
  a `ConfigurableSearchPluginBase` with a large per-page config form (auth, serving config, autocomplete,
  display, JS, filter, order, exclusion, flood, messages, advanced). Implements `AccessibleInterface`.
- **Service** `vertex_ai_search.search_manager` (`Service\VertexSearchManager`) — builds/sends the
  `SearchRequest`, handles flood, exclusion, spell correction, pager, result parsing, alter hooks.
- **5 plugin types** (annotation + manager, all `parent: default_plugin_manager`):
  `vertex_autocomplete`, `vertex_configurable_js`, `vertex_search_filter`, `vertex_search_results`,
  `vertex_search_order`. Bundled plugins: `SimpleAutocomplete`, `VertexAutocomplete`, `RegexValidator`.
- **Pager decorator** `Service\Decorator\VertexPagerManager` (decorates `pager.manager`, adds
  `createVertexPager`) + `VertexPager`.
- **REST resource** `@RestResource id="vertex_ai_search_results"` at `/search/vertex/v1/{search_page}`
  (provider `restui`) returning results JSON.
- **Autocomplete route** `vertex_ai_search.autocomplete` → `/vertex_autocomplete/{search_page_id}`
  (`AutocompleteController::handleAutocomplete`, JSON).
- **Permissions**: dynamic, one per Vertex search page — `use <id> custom search page`
  (`Controller\VertexAISearchAccessController::retrieveVertexPagePermissions`).
- **Tokens**: `vertex_ai_search:*` (keywords, result start/end, page, corrected/original keyword + URL,
  total/estimated counts) — see `Hook\VertexAiSearchTokensHooks`.
- **Hooks** (OOP `Hook\VertexAiSearchHooks`): help, `form_search_block_form_alter`, theme,
  `entity_insert`, `preprocess_pager`; plus `hook_preprocess_item_list__search_results` in the .module.
  Alter hooks: `vertex_ai_search_search_request_alter`, `vertex_ai_search_search_results_alter`.
- **Config schema** `search.plugin.vertex_ai_search` (config/schema); no standalone settings route
  (configured through core Search Pages, `configure` = null).

## Configuration model
No global config object. Each search page is a core `search_page` config entity whose `configuration`
map is validated by `search.plugin.vertex_ai_search`. Key fields: `service_account_credentials_file`
(path to Google service-account JSON), `google_cloud_project_id`, `google_cloud_location`,
`vertex_ai_data_store_id`, `vertex_ai_serving_config`, `vertex_ai_advanced_indexing`, plus display,
autocomplete, filter/order, exclusion, flood, message, `transport_method`, `disable_google_api_queries`,
`default_client_search_path`. See `agent/config/search-page.md`.

## Solution docs
- `agent/config/search-page.md` — install, per-page config fields, schema, routes, permissions, dev mode.
- `agent/plugins/plugin-types.md` — the 5 plugin types, base classes/interfaces, bundled plugins.
- `agent/api/services-rest-tokens.md` — search manager service, alter hooks, tokens, pager decorator, REST resource.
