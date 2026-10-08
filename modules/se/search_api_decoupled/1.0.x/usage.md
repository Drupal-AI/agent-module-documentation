Search API Decoupled exposes a Search API index as a JSON HTTP search endpoint (`/api/search/{endpoint}`), letting a headless/JavaScript front-end query search results directly without building a Drupal View or loading Drupal entities.

---

The module defines a `search_api_endpoint` config entity: each endpoint picks a Search API index and configures result limit, allowed items-per-page options, which index fields are full-text searched, which fields to exclude from output, parse mode, default/exposed sorting, whether to skip field extraction (avoid loading source objects) and whether to build result URLs. A single route `search_api_decoupled.search_results` (`/api/search/{endpoint}`) runs the query in `SearchApiEndpointController::searchResults()` and returns a `CacheableJsonResponse` with `search_results` (per-item extracted index field values + `id`, `score`, `excerpt`, optional `url`), pagination (`search_results_count/page/pages/per_page`), `max_score`, `took`, and `facets`. Query parameters drive the search: `q` (keys), `page`/`offset`, `limit`, `sort`+`order`, and any allowed index field as a filter (with `operator[field]=` and comma/`between` handling). Access is enforced by a custom `_search_api_endpoint` check requiring the index be enabled AND the account hold either `administer search_api_endpoint` or the per-endpoint `use search with <id> endpoint` permission (generated dynamically per endpoint). Reusable **filter** plugins (`search_api_decoupled_filter` plugin type: annotation + manager, base class, `standard` fallback) provide preset or exposed query conditions with validation/transformation (e.g. relative dates). Events allow altering results (`SearchApiEndpointResultsAlter`) and facets. Ships four submodules: `search_api_decoupled_ui` (a configurable front-end search UI builder), `search_api_decoupled_facets` (Facets integration), `search_api_decoupled_autocomplete` (Search API Autocomplete integration), and `search_api_decoupled_demo`. Requires `search_api ^1.28`; an admin list/add/edit UI lives under `/admin/config/search/search-api/endpoints`. Note: installation requires the `wikimedia/composer-merge-plugin` to merge `composer.libraries.json`.

---

- Serve search results as JSON to a React/Vue/Next.js front-end from a Drupal Search API index.
- Build a headless site search without creating a Search API View.
- Query a search index over HTTP with `?q=keywords` and get scored, paginated JSON results.
- Return only selected index field values per result and exclude sensitive/internal fields.
- Skip loading source Drupal entities for speed (`skip_field_extraction`) — return raw indexed data.
- Paginate results with `page` or `offset`, and cap page size via allowed items-per-page options.
- Let the client sort by any indexed field with `sort`/`order` when sorting is exposed.
- Define default sort field/order for an endpoint when the client does not request one.
- Filter results by any indexed field via query parameters, including `in`/`between`/comparison operators.
- Attach preset (non-exposed) filter conditions to an endpoint so every query is constrained.
- Expose configurable filters with input validation and transformation (e.g. `now`, `-1 day` dates).
- Gate an endpoint behind a per-endpoint permission (`use search with <id> endpoint`).
- Offer a public (anonymous) search endpoint by granting that permission to the anonymous role.
- Include ready-to-render result URLs for entity results (`ensure_result_item_url`).
- Return excerpts/highlighted snippets and relevance scores per result.
- Provide facets data alongside results via the Facets submodule.
- Add typeahead/autocomplete backed by Search API Autocomplete via the autocomplete submodule.
- Build a themeable decoupled search UI with the UI submodule's element plugins and layouts.
- Alter the JSON response server-side through the `SearchApiEndpointResultsAlter` event.
- Support multilingual search (queries are constrained to the current content language).
- Add custom filter behavior by writing a `search_api_decoupled_filter` plugin.
- Expose multiple endpoints over the same index with different field/sort/filter configurations.
- Cache endpoint responses with index and endpoint cache tags for invalidation on content changes.
