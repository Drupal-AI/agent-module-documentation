<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search — plugin types

Five annotation-based plugin types, each with a manager service (`*.services.yml`, all
`parent: default_plugin_manager`). Managers scan `src/Plugin/<Type>/` and use the annotation +
interface + base class below. All receive the search page `configuration` array as plugin
`$configuration` when instantiated with `createInstance($id, $config)`.

## 1. Autocomplete — `vertex_autocomplete`
- Annotation `@VertexAutocompletePlugin` (`Annotation/VertexAutocompletePlugin`), manager
  `plugin.manager.vertex_autocomplete` (`VertexAutocompletePluginManager`), interface
  `VertexAutocompletePluginInterface`, base `VertexAutocompletePluginBase`.
- Contract: `getSuggestions($keys)` returns an array of suggestion strings; may implement
  `PluginFormInterface` for per-source config.
- Bundled:
  - `SimpleAutocomplete` (`vertex_autocomplete_simple`) — queries `node_field_data` (status = 1) by
    title, or title+body (`title_only` / `title_body` model), optional content-type filter, limited to
    `autocomplete_max_suggestions`. Parameterized `LIKE` conditions (no string concatenation).
  - `VertexAutocomplete` (`vertex_autocomplete_vertex`) — calls Google `CompletionServiceClient::completeQuery`
    against the configured data store (model `search_history`); needs traffic history to return results.
- Consumed by `AutocompleteController::handleAutocomplete` (route `vertex_ai_search.autocomplete`) and by
  the search form / core search block alter when `autocomplete_enable` is set.

## 2. Configurable JavaScript — `vertex_configurable_js`
- Annotation `@VertexConfigurableJavaScriptPlugin`, manager `plugin.manager.vertex_configurable_js`,
  interface `VertexConfigurableJavaScriptPluginInterface`, base `VertexConfigurableJavaScriptPluginBase`.
- Contract: `getJavaScriptLibrary()`, `getJavaScriptSettings()`, `alterSearchForm(&$form, $form_state)`,
  plus `buildConfigurationForm()`.
- Bundled `RegexValidator` (`vertex_regex_validator`) — collects `regex_patterns`
  (`pattern::message::severity` per line), attaches library `vertex_ai_search/exclude_regex` and pushes
  the patterns into `drupalSettings.vertex_ai_search.regex` for client-side input validation
  (`js/exclude_regex.js`). Selected via `js_enable` + `js_plugin[]`.

## 3. Search Filter — `vertex_search_filter`
- Annotation `@VertexSearchFilterPlugin`, manager `plugin.manager.vertex_search_filter`, interface
  `VertexSearchFilterPluginInterface`, base `VertexSearchFilterPluginBase`.
- Contract: `getSearchFilter()` returns a Vertex filter-expression string. Applied by
  `VertexSearchManager::retrievePluginFilter()` → `SearchRequest::setFilter()` when `filter_enable` +
  `filter_plugin` are set. Enables filter-only (no-keyword) searches when `filter_only_searches` is on.
- No filter plugin ships with the module (site-provided).

## 4. Search Order — `vertex_search_order`
- Annotation `@VertexSearchOrderPlugin`, manager `plugin.manager.vertex_search_order`, interface
  `VertexSearchOrderPluginInterface`, base `VertexSearchOrderPluginBase`.
- Contract: `getSearchOrder()` returns an `orderBy` expression. Applied by
  `VertexSearchManager::retrievePluginOrder()` → `SearchRequest::setOrderBy()` when `order_enable` +
  `order_plugin` are set. No order plugin ships with the module.

## 5. Search Results — `vertex_search_results`
- Annotation `@VertexSearchResultsPlugin`, manager `plugin.manager.vertex_search_results`, interface
  `VertexSearchResultsPluginInterface`, base `VertexSearchResultsPluginBase`.
- Contract: `retrieveCuratedResults($config, $params)` (curated/promoted results) and
  `manipulatePageResults($config, $params, $output, $curated)` (post-process the render array).
  ALL defined results plugins run — `VertexSearchManager::retrievePluginCuratedResults()` and
  `VertexAISearch::buildResults()` iterate every definition. No results plugin ships with the module
  (e.g. the separate Vertex AI Search Promoted Results project provides one).
