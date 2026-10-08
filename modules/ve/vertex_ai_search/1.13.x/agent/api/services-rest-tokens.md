<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Vertex AI Search — services, alter hooks, tokens, REST

## Search manager service
`vertex_ai_search.search_manager` = `Service\VertexSearchManager` (interface
`VertexSearchManagerInterface`). Constructor args (services.yml): search page repository, the 5 plugin
managers, `token`, `flood`, `request_stack`, `pager.manager`, logger channel
`logger.channel.vertex_ai_search`, `module_handler`.

Entry point `executeSearch(array $config, array $params)`:
- `Xss::filter()` on `$params['keys']` before use.
- Flood gate via `flood.isAllowed('vertex_ai_search.flood_level', threshold, window)` when
  `flood_enable`; returns the `flood_message` on trip. Registered with `flood.register` after a query.
- `disable_google_api_queries` → `retrieveSampleResult()` (canned example result, no API call) for
  offline theming/dev.
- `prepareSearchRequest()` builds `SearchRequest`: serving config name, query (after exclusion-list
  stripping), page size, safe search, spell-correction spec, offset, filter/order plugin expressions,
  snippet spec for advanced indexing. Fires alter hook (below).
- `performVertexSearch()` creates `ServiceAccountCredentials` from the JSON key file and a
  `SearchServiceClient` (with optional `transport_method`), runs `search()`, reads total size / next
  page token / corrected query, JSON-decodes each result, optionally strips the domain from result
  links (`removeDomain` → `stripDomainFromResult()`), fires the results alter hook. Google
  `ApiException` / `\Exception` are caught and logged critical (no fatal to the user).

## Alter hooks (module_handler->alter)
- `hook_vertex_ai_search_search_request_alter(SearchRequest &$request, array $search_page_config)` —
  modify the outgoing request before it is sent.
- `hook_vertex_ai_search_search_results_alter(array &$results, array $search_page_config, $responseObject)`
  — post-process parsed results (e.g. parse raw facets).

## Pager decorator
`vertex_ai_search.pager_manager.decorator` = `Service\Decorator\VertexPagerManager` decorates
`pager.manager` (priority 5), adding `createVertexPager()` used when `pagerType === 'VERTEX'` — an
incremental "next"-driven pager (`VertexPager`) for the estimate-based Vertex total count. Otherwise a
standard core pager is created.

## Tokens
Token type `vertex_ai_search` (`Hook\VertexAiSearchTokensHooks`, OOP `#[Hook]`; legacy shims in
`vertex_ai_search.tokens.inc`). Tokens: `vertex_ai_search_keywords`, `vertex_ai_search_result_start`,
`vertex_ai_search_result_end`, `vertex_ai_search_page`, `vertex_ai_search_total_result_count`,
`vertex_ai_search_estimated_result_count`, `vertex_ai_search_original_keyword`(`_url`),
`vertex_ai_search_corrected_keyword`(`_url`). Keyword/URL replacements are `Xss::filter()`ed. These
drive the configurable result/correction/no-result messages.

## Other hooks
`Hook\VertexAiSearchHooks` (autowired service, `#[Hook]` + `#[LegacyHook]` shims in `.module`):
`help`, `form_search_block_form_alter` (adds autocomplete to the core search block when
`autocomplete_enable_block`), `theme` (registers the `vertex_ai_search_*` templates), `entity_insert`
(cache clear on new page), `preprocess_pager`. `.module` also implements
`hook_preprocess_item_list__search_results` for empty/no-keyword messages. Themes live in
`vertex_ai_search.theme.inc` + `templates/`; result title/snippet are rendered as filtered `#markup`.

## REST resource
`@RestResource id="vertex_ai_search_results"` (`Plugin/rest/resource/VertexAISearchResource`,
provider `restui`) → `GET /search/vertex/v1/{search_page}` where `{search_page}` is an
`entity:search_page`. Reads query params `page`, `keys`, `correction`, and `search-path` (falling back
to the page's `default_client_search_path`), calls `searchManager->executeSearch()` and returns a
`ResourceResponse(['response' => $resource])` with `url.query_args` cache context. Access follows the
core REST layer — enable the resource and grant the REST permission (e.g. via RESTUI). Note: standard
core-Search access (the per-page `use <id> custom search page` permission and `AccessibleInterface`
check) applies to the HTML results page, not to this REST route, which is governed by REST resource
permissions.
