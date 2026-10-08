# API — the HTTP search endpoint & events

## Route
`search_api_decoupled.search_results` → **`GET /api/search/{search_api_endpoint}`**
(controller `SearchApiEndpointController::searchResults`). Returns a `CacheableJsonResponse`
(cache contexts `url`; cache tags `search_api_list:<index>` + the endpoint). Access: see
permissions doc (`_search_api_endpoint`).

## Query parameters
| Param | Meaning |
|---|---|
| `q` | Full-text keywords (applied to `searched_fields`). |
| `page` | 0-based page (offset = `page * limit`). |
| `offset` | Explicit result offset; **takes precedence over `page`**. Clamped to ≥ 0. |
| `limit` | Page size; honored only if it is in the endpoint's `items_per_page_options`, else the endpoint `limit`. |
| `sort`, `order` | Sort field(s) and `asc`/`desc`; applied only when `expose_sort` is true. Both accept arrays (`sort[]=`). A `sort` value may embed order as `field,asc`. Only indexed fields (+ `search_api_relevance/datasource/language/id`) are allowed. |
| `<field>=value` | Any indexed field (or an exposed filter identifier) becomes a query condition. |
| `operator[<field>]=` | Operator for that field: `equal`,`not_equal`,`gt`,`gte`,`lt`,`lte`,`in`,`not_in`,`between`. |

Value handling: a comma-separated value → `in`; an array list → `in`; a 2-element assoc array →
`between`. Reserved keys skipped as filters: `page`, `sort`, `order`, `q`, `f`, `operator`, `offset`.
Only fields in the index (or exposed-filter identifiers) are accepted — arbitrary properties are
ignored. Exposed filters additionally validate/transform input (`validateUserInput`,
`transformUserInput`) and can restrict allowed operators. Queries are constrained to the current
content language (+ LANGCODE_NOT_SPECIFIED).

## Response JSON
```json
{
  "search_results": [
    { "<field>": "value|[values]", "id": "...", "score": 1.0, "excerpt": "…", "url": "…" }
  ],
  "search_results_per_page": 10,
  "search_results_count": 42,
  "search_results_page": 0,
  "search_results_pages": 5,
  "max_score": 1.0,
  "took": 12.3,
  "facets": []
}
```
Each result item is the item's extracted index field values (minus `excluded_fields`), plus `id`,
`score`, and `excerpt`; `url` is added for `entity:*` items when `ensure_result_item_url` is on.
On a query exception the controller logs it and returns the empty-shell response (200 with zeroed
counts). `facets` is populated by the facets submodule/event.

## Events (`SearchApiEndpointEvents`)
- **`search_api_decoupled.search_results_alter`** — `SearchApiEndpointResultsAlter` — subscribe to
  read/modify the response array (`getResponse()/setResponse?`), the raw `ResultSet`, cacheable
  metadata, and the request before JSON is returned. Use this to reshape output, add computed
  fields, or inject data.
- **`search_api_decoupled.search_endpoint_facets_alter`** — `SearchApiEndpointFacets` — populate the
  `facets` array (used by `search_api_decoupled_facets`).

## Notes
- No Drush commands. No `hook`-style `*.api.php` beyond the plugin alter hook
  (`hook_search_api_decoupled_filter_info_alter`, documented in the UI submodule's `*.api.php`).
- The endpoint is read-only (GET); it never mutates state.
