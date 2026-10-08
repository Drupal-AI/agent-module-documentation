# Query rewriting & URL parameters

The core mechanism: search terms travel in the URL, are parsed into value objects, and rewrite the
**Solr (Solarium) query** directly — not the Search API query — because Search API turns conditions
into separate filter queries that cannot express `OR` and do not affect scoring.

## URL query parameters

Terms live under the configurable query key (default `a`, `SEARCH_QUERY_PARAMETER`), one indexed
group per term:

| Param | Constant (`AdvancedSearchQueryTerm`) | Meaning |
|---|---|---|
| `a[N][f]` | `FIELD_QUERY_PARAMETER` | Search field identifier, or the literal `all` for all-fields. Required. |
| `a[N][v]` | `VALUE_QUERY_PARAMETER` | Search value. Required, non-empty. |
| `a[N][i]` | `INCLUDE_QUERY_PARAMETER` | Include/exclude: `IS`/`NOT` (or a boolean); default include. |
| `a[N][c]` | `CONJUNCTION_QUERY_PARAMETER` | `AND` / `OR` joining this term to the previous; default `AND`. `OR` + exclude is rejected. |
| `r` | (`SEARCH_RECURSIVE_PARAMETER`, default) | Truthy → recurse into sub-collections. |

Example: `?a[0][f]=all&a[0][i]=IS&a[0][v]=river&a[1][c]=AND&a[1][f]=field_year&a[1][v]=1900`.

## Classes

- `Drupal\advanced_search\AdvancedSearchQuery` — `getTerms(Request)` builds
  `AdvancedSearchQueryTerm[]`; `shouldRecurse(Request)`; `alterQuery(...)` rewrites the Solarium
  query; `alterView(...)` handles recursive views; `toUrl(...)` serializes terms back into a URL.
  Static `getQueryParameter()` / `getRecurseParameter()` read the configurable keys.
- `Drupal\advanced_search\AdvancedSearchQueryTerm` — one term. `fromQueryParams()` (URL) and
  `fromUserInput()` (form) constructors; `toSolrQuery($field_mapping)` produces the Solr fragment;
  `toSolrFields($field_mapping)` the field list. Values are escaped through the
  `solarium.query_helper` service (`escapePhrase`). Supports phrases, `AND`/`OR`/`NOT`, and negation
  (`-`/`!`).

## How the Solr query is altered

`Drupal\advanced_search\EventSubscriber\PostConvertedQueryEventSubscriber` (registered in
`advanced_search.services.yml` as an `event_subscriber`) listens on
`SearchApiSolrEvents::POST_CONVERT_QUERY` and calls `AdvancedSearchQuery::alterQuery($request,
$solarium_query, $search_api_query)`. When any `a[...]` term is present it:

1. Builds the Solr field map from the Search API Solr backend
   (`getSolrFieldNamesKeyedByLanguage`).
2. If `lucene_on_off` (eDisMax) is on: enables the `edismax` parser
   (`$solarium_query->getEDisMax()->setQueryParser('edismax')`) and sets the query fields — from
   `query_fields` config when searching `all` (skipping `bs_` boolean fields), otherwise from the
   term's own fields.
3. If eDisMax is off: prepends `*:*` for all-negative queries so exclusions work.
4. Assembles the query string from each term's `toSolrQuery()` joined by its conjunction and calls
   `$solarium_query->setQuery($q)`.
5. If the backend has `highlight_data`, configures Solr highlighting
   (`[HIGHLIGHT]`…`[/HIGHLIGHT]`) on the string/text query fields (`setHighlighting()`), reading the
   highlighter settings via `search_api_solr` `Utility::getIndexSolrSettings()`.

## Recursive (sub-collection) search — `alterView()`

Called from `hook_views_pre_view` (and from the pager block's `build()`). For a view/display that a
placed Advanced Search block was derived from (looked up via `Utilities::getAdvancedSearchViewDisplays()`),
it reads the block's `context_filter` setting and, when `r` is truthy, replaces that contextual
filter's argument with the display's argument *exception value* so the "immediate children only"
filter is ignored and the whole collection subtree is searched. On AJAX requests it restores the
display's default argument from the referrer (working around core issue 3173778).
