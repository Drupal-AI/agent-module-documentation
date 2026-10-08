# Framework services + building a search page

The module is a framework. To get a working search page you create your own (sub)module that:
1. copies `services.yml.example` → your `services.yml` (renaming the parameters/index),
2. copies `routing.yml.example` → your `routing.yml` (three routes: search, filter, autocomplete),
3. extends `SearchController` for anything non-default.

The `elasticsearch_search_api_example` submodule is a complete, working copy of this pattern; read
[../../modules/elasticsearch_search_api_example/2.2.x/agent/api/example.md] alongside this.

## The example services (services.yml.example)

| Service id | Class | Purpose |
|---|---|---|
| `…elasticsearch_params_builder` | `Search\ElasticSearchParamsBuilder` | Builds the ES query body (`from`/`size`/`bool.must` filters, keyword `function_score`/`match custom_all`, aggregations, `post_filter`) from a search action. |
| `…search_action_factory` | `Search\SearchActionFactory` | Turns the HTTP query bag into a `FacetedKeywordSearchAction` (reads `keyword`, `page`, `from`, and each facet param). Arg: `%…search_page_size%`. |
| `…elasticsearch_result_parser` | `Search\ElasticSearchResultParser` | Parses the raw ES response into a `Search\SearchResult` (total, hit `_id`s, facet counts). |
| `…search_repository` | `Search\SearchRepository` | Sends params to the ES client and loads hit entities. Resolves the Search API server → `elasticsearch_connector` backend → `elasticsearch_cluster` entity → client via `@elasticsearch_connector.client_manager`. |
| `…suggest.title_suggester` | `Search\Suggest\TitleSuggester` | ES phrase-suggester on the `title` field (`did you mean`). Implements `Suggest\SuggesterInterface::suggest($text)`. |
| `…search_query_builder` | `Search\SearchQueryBuilder` | Builds a URL query array (`keyword` + facet values) for building links. |
| `…factory.index` | `search_api\Entity\Index::load` (factory) | Loads the Search API `Index` named by `%…index%`. Injected into most services. |
| `…elasticsearch_indexfactory_adapter` | `Search\IndexFactoryAdapter` | Thin adapter over `elasticsearch_connector`'s `IndexFactory::getIndexName()` (the real ES index name = prefix + db + index machine name). |

Parameters (override per implementation): `elasticsearch_search_api.search_page_size` (default `10`),
`elasticsearch_search_api.index` (Search API index machine name, default `general`).

## SearchController (`src/Controller/SearchController.php`)

`ControllerBase` subclass meant to be **extended**. Constructor args (8): renderer, current_route_match,
`SearchActionFactory`, `ElasticSearchParamsBuilder`, `ElasticSearchResultParser`, `SuggesterInterface`,
`SearchRepository`, `EntityTypeManagerInterface`. Public callbacks:

- `search(Request)` — full page render (`#theme 'elasticsearch_search_api_search'`). On an XHR page request
  (not `ajax_form`) returns only the rendered hits container. Attaches libraries `ajaxify`,
  `loading-overlay`, `styles` and `drupalSettings.elasticsearch_search_api.ajaxify.{filter_url,facets}`.
- `filter(Request)` — AJAX callback returning an `AjaxResponse` of Remove/Append/Prepend/Replace commands
  that refresh hits, facets, result-count and did-you-mean. Reads from `$request->request` (POST).
- `handleAutocomplete(Request)` — reads `q`, runs an ES `completion` suggester on the `search_suggest`
  field, returns a rendered `#theme 'elasticsearch_search_api_autocomplete'` Response (JSON route).

Override these `protected` seams in your subclass (defaults return empty/NULL):
`getFacets()` (facet machine-name list), `getSearchUrl()`, `getFilterUrl()`, `getSearchHeader()`,
`getSuggestions()`, `renderPager()`, `shouldRetainFilter()`. The internal pipeline is
`parsedResult()` → `searchParamsBuilder->build()` → `searchRepository->query()` → `resultParser->parse()`.
ES errors are caught and rendered via `#theme 'elasticsearch_search_api_error'`.

Minimal subclass (from README): set `$this->facets` in the constructor, point `getSearchUrl()`/
`getFilterUrl()` at your routes, and re-declare `create()` to inject your renamed services.

## Query flow (what actually runs)

```
GET /your-search?keyword=foo&page=2&<facet>[]=<val>
  SearchActionFactory::searchActionFromQuery()  -> FacetedKeywordSearchAction
  ElasticSearchParamsBuilder::build()           -> ES params (from/size/bool/aggs/post_filter)
  SearchRepository::query($params)              -> $client->search()  (elasticsearch_connector client)
  ElasticSearchResultParser::parse()            -> SearchResult(total, hit-ids, facetCounts)
  SearchController renders hits via node view builder (view mode 'search_index')
```
The keyword is passed as an ES DSL value (`multi_match`/`match`), never string-concatenated into a query.
Standard filters always applied: `term langcode = current language`, `term status = 1` (published only).

## SearchForm (`src/Form/SearchForm.php`)

A `FormBase` search box (not tied to a route). `buildForm()` accepts extra args:
`$add_inline_autocomplete`, `$custom_keyword_id`, `$custom_form_id`, `$ajax_form`, `$redirect_url` (Url),
`$additional_query_params`. Submit redirects to `$redirect_url` (default route
`elasticsearch_search_api.search`) with `?keyword=…`. When inline autocomplete is on it attaches the
`inline-autocomplete` library and a `drupalSettings…autocomplete_endpoint`. Override `getAutocompleteUrl()`
to point at your autocomplete route.

## Example routes & permissions (routing.yml.example / permissions.yml.example)

Not loaded until you copy them. The example search/filter/autocomplete routes are gated
`_permission: 'access content'` (public search). The example admin/synonym/keymatch routes use
`manage elasticsearch search api settings`, `administer synonyms`, `administer keymatches`
(defined only in `permissions.yml.example`).
