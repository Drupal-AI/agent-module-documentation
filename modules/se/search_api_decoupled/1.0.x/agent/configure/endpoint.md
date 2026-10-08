# Configure — the `search_api_endpoint` config entity

## Admin UI
Under `/admin/config/search/search-api/endpoints` (all require `administer search_api_endpoint`):
- collection (list), `add`, `{endpoint}/edit`, `{endpoint}/delete`.
- Filters per endpoint: `{endpoint}/filters` (library/list), `filters/add/{filter}`,
  `filters/{filter}` (edit), `filters/{filter}/delete`.

## Config entity `search_api_endpoint` (schema `search_api_decoupled.search_api_endpoint.*`)
| Field | Type | Default | Meaning |
|---|---|---|---|
| `id`, `label`, `description` | string/label/text | — | Endpoint identity. `id` is used in the URL and permission name. |
| `index` | string | — | Search API index id this endpoint queries. Config dependency. |
| `limit` | int | `10` | Default results per page. |
| `items_per_page_options` | int[] | — | Allowed client `limit` values (a client `?limit=` is honored only if in this list). |
| `searched_fields` | string[] | — | Index fields used as full-text fields for `q`. |
| `excluded_fields` | string[] | — | Index fields removed from each result item's output. |
| `parse_mode` | string | `direct` | Search API parse mode plugin id (e.g. `direct`, `terms`, `phrase`). |
| `default_sort` | string | — | Sort field applied when no sort resolved. |
| `default_sort_order` | string | — | `asc`/`desc` for the default sort. |
| `expose_sort` | bool | `TRUE` | Allow the client to override sorting via `?sort`/`?order`. |
| `skip_field_extraction` | bool | `FALSE` | If TRUE, do not load the source object for field extraction (faster; returns only indexed values). |
| `ensure_result_item_url` | bool | `TRUE` | Build a canonical `url` for entity results when the item has none. |
| `filters` | sequence | `[]` | Filter plugin instances (see plugins/filter.md); each typed `search_api_decoupled.filter.[plugin_id]`. |
| `sortrules` | sequence | `[]` | Preset sort rules: `{ sortfield, sortorder }` applied when sorting is not exposed/requested. |

## Key entity methods
`getIndex()`, `getLimit()`, `getItemsPerPage()`/`isAllowedItemsPerPage()`, `getSearchedFields()`,
`getExcludedFields()`, `getFulltextFields()`/`getIndexedFields()`/`getIndexFieldsDefinitions()`,
`getParseMode()`, `getFilters()` (a `SearchFiltersPluginCollection`), `getSortRules()`,
`getBaseUrl()` (the `/api/search/{id}` URL), `getFacets()` (dispatches the facets-alter event),
`getAutocomplete()` (loads a matching `search_api_autocomplete_search` when that submodule is on).
Operators: `SearchApiEndpoint::getOperators()` (equal/between/gt/gte/lt/lte/not_equal/not_in/in) →
`getConditionOperator()` maps to Search API condition operators (`=`, `BETWEEN`, `>`, …).

## Setup steps
1. Build and enable a Search API index (server + index) with the fields you want to search/return.
2. Add an endpoint, choose the index, set `searched_fields`, `limit`, sorting, and any filters.
3. Grant the endpoint permission (see permissions doc) to the roles that may query it.
4. Query `/api/search/{id}` (see api/endpoint.md).

## Hardening note (not a module vuln — operator responsibility)
The endpoint returns indexed field values directly and does **not** apply per-entity view access to
results (especially with `skip_field_extraction`). To avoid exposing unpublished/restricted content
on a public endpoint, configure the **Search API index** with the appropriate processors (e.g.
"Content access", and only index published content) before granting the endpoint permission to
anonymous. Use `excluded_fields` to keep internal fields out of the JSON.
