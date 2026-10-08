# Views (acquia_cms_search)

The module both **ships views** and **provides three Views plugins** that the search stack relies on.

## Shipped views

| View | Base table | Key display | Purpose |
|---|---|---|---|
| `search` | `search_api_index_content` | `page` at path **`search`**, exposed filter block on | The site search results page. Exposed `search_api_fulltext` keyword filter; row plugin `search_api` rendering nodes in the `teaser` view mode; cache plugin `search_api_tag`. |
| `search_fallback` | `node_field_data` | `search_fallback_block` | Plain node listing shown in place of results when the Search API server is unavailable. |
| `acquia_search` | `search_api_index_acquia_search_index` | disabled (`status: false`) | Solr results view used only after switching to Acquia Search. |

The `search` view's default display embeds a **`view_fallback` area handler** with
`view_to_insert: 'search_fallback:search_fallback_block'`, so the fallback view is inserted only when
the primary Search API server is down.

## Provided Views plugins

### `view_fallback` area handler — `FallbackView`
`src/Plugin/views/area/FallbackView.php`, `@ViewsArea("view_fallback")`, registered by
`hook_views_data`. Extends core's `View` area. On `render()` it calls `isServerAvailable()`: if the
view's query is a `SearchApiQuery` and its index's backend reports available, the area renders
**nothing**; if the server is down (or the query aborted, or `simulate_unavailable` is set), it renders
the embedded fallback view. For non-Search-API views it renders nothing.

### `search_api_query` override — `SearchApiQuery`
`src/Plugin/views/query/SearchApiQuery.php`. Extends search_api's query handler and adds the
`url.path` cache context via `getCacheContexts()`. It is swapped in for the stock `search_api_query`
class **only when `facets_pretty_paths` is enabled** (`hook_views_plugins_query_alter`), because pretty
paths encode facets in the URL path rather than the query string.

### `search_api_none_bc` cache plugin — `SearchApiNoneCacheBC`
`src/Plugin/views/cache/SearchApiNoneCacheBC.php`, `@ViewsCache(id = "search_api_none_bc")`. A
backward-compat shim extending core `None`; `hook_views_plugins_cache_alter` re-registers it under the
id `search_api_none` on search_api versions that lack that plugin (Drupal 9 support window). `@todo`
in source: remove once core 9 support is dropped.
