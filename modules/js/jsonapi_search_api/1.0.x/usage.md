<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Search API exposes each enabled Search API index as a JSON:API resource at `/%jsonapi%/index/{index_id}`, so decoupled clients can run Search API queries (fulltext, filter, sort, pagination) and get JSON:API documents back.

---

The module has no configuration UI or config of its own; it works entirely off your existing Search API indexes. A dynamic route provider (`Routing\Routes::routes()`) walks every **enabled** index and registers one route `jsonapi_search_api.index_<id>` at path `/%jsonapi%/index/<id>` (default `/jsonapi/index/<id>`), backed by the `jsonapi_resources` `IndexResource`. Each request runs a Search API query against that index (search id `jsonapi_search_api:<index>`) and returns the result entities as a JSON:API collection document with `meta.count` and pager links. It maps JSON:API query parameters onto Search API: `page[offset]` / `page[limit]` for pagination, `sort` for sorting, and `filter[...]` for conditions using JSON:API's filter grammar (its `Query\Filter`/`EntityCondition` port supports `=,<>,>,>=,<,<=,IN,NOT IN,BETWEEN,NOT BETWEEN,IS NULL,IS NOT NULL` — but not `STARTS_WITH`/`CONTAINS`/`ENDS_WITH`, which Search API can't express). A special `filter[fulltext]=...` sets the query keywords (terms parse mode). An event, `jsonapi_search_api.add_search_meta` (`Event\AddSearchMetaEvent`), lets other modules add to the response `meta` — this is how the `jsonapi_search_api_facets` submodule injects facet data. Requires `jsonapi`, `jsonapi_resources` and `search_api`; routes only appear for indexes that are enabled (an index must have a server and be enabled to be exposed).

---

- Power a decoupled/React/Next.js front-end search from a Drupal Search API index over JSON:API.
- Expose a site-wide content index at `/jsonapi/index/<id>` for a headless client.
- Run a fulltext search from JavaScript using `filter[fulltext]=climate`.
- Paginate search results with `page[offset]` and `page[limit]` JSON:API params.
- Sort search results via the JSON:API `sort` parameter mapped onto Search API sorts.
- Filter results with JSON:API filter syntax (`filter[status][value]=1`) translated to index conditions.
- Combine grouped AND/OR filter conditions using JSON:API filter groups.
- Return facet data in the response `meta` by adding the facets submodule.
- Build an autocomplete endpoint over an existing Search API index without custom controllers.
- Serve search to a mobile app using the same index that powers the site's on-site search.
- Get `meta.count` totals and first/prev/next/last pager links for infinite scroll.
- Query only enabled indexes automatically — new enabled indexes get a route with no extra code.
- Use range filters (`BETWEEN`, `>=`, `<=`) on numeric/date index fields from the client.
- Filter by `IN`/`NOT IN` lists for multi-value facets or category filters.
- Use `IS NULL` / `IS NOT NULL` to find items missing or having an indexed field.
- Add custom response metadata by subscribing to the `AddSearchMetaEvent`.
- Keep search server-side (relevance, access) while exposing only results as JSON:API resources.
- Reuse JSON:API's caching/query-arg cache contexts (`filter`, `sort`, `page`) for search responses.
- Provide a stable JSON:API contract for search independent of the underlying Search API backend.
- Integrate Search API results into an existing JSON:API-consuming design system.
- Support multiple indexes (e.g. content vs. users) each at its own `/jsonapi/index/<id>` route.
- Migrate a legacy custom search endpoint to a standards-based JSON:API search resource.
