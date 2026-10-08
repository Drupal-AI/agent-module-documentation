<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Search API Facets adds Facets support to the JSON:API Search API index endpoint, returning facet data inside the search response's `meta.facets` and reading facet selections from JSON:API `filter[...]` query parameters.

---

This submodule of `jsonapi_search_api` wires the Facets module into the JSON:API search resource. It provides a **facet source** plugin `jsonapi_search_api_facets` (derived per facets-capable index by `JsonApiFacetsDeriver`, so `jsonapi_search_api_facets:<index_id>`), a **widget** `jsonapi_search_api` (`JsonApiResponseWidget`) that renders facet results as JSON data, and a **URL processor** `json_api` (`JsonApiQueryString`) that reads/writes facet state through the JSON:API `filter` parameter. Two event subscribers do the work: `SearchApiQueryPreExecute` (on Search API's `QUERY_PRE_EXECUTE`) calls the facet manager to add facet aggregations to the query for `jsonapi_search_api:<index>` searches and handles OR-facet tagging/aliases; `AddSearchMetaEventSubscriber` (on `jsonapi_search_api.add_search_meta`) builds the configured facets and injects them into the response `meta.facets`. Form alters lock a JSON:API facet source's URL processor to `json_api` and hide incompatible options, and `hook_ENTITY_TYPE_presave()` implementations force a `jsonapi_search_api_facets:*` facet source to use filter key `filter` + URL processor `json_api`, and default any facet on such a source to the `jsonapi_search_api` widget. It only acts when the index's server supports the `search_api_facets` feature. Hierarchical facets, minimum counts and hard limits are not yet supported (a Facets-module limitation). No config or settings of its own; requires `jsonapi_search_api` and `facets`.

---

- Return category/tag facet counts in a decoupled search response's `meta.facets`.
- Let a JavaScript front-end drive faceted search over a Search API index via JSON:API.
- Read facet selections from `filter[...]` query params instead of pretty facet URLs.
- Add a content-type facet to a `/jsonapi/index/<id>` search endpoint.
- Build an OR-style multi-select facet (e.g. multiple tags) for a headless UI.
- Expose author/status/date facets for a decoupled search results page.
- Render facets as JSON (not HTML) using the `jsonapi_search_api` widget.
- Keep facet state in the JSON:API `filter` parameter for shareable search URLs.
- Provide facet counts so the client can show "(12)" next to each option.
- Configure a facet source per index with the `json_api` URL processor automatically.
- Power sidebar filters in a Next.js/React search page from Drupal facets.
- Combine fulltext search with facets in a single JSON:API request.
- Add faceted navigation to a mobile app backed by Search API.
- Let editors define facets in the Facets UI and have them appear in the JSON:API meta.
- Reuse existing Search API index fields as facets for a decoupled site.
- Return multiple facets (type, tags, date) in one search response's meta.
- Support aliased facet fields via the URL processor's alias handling.
- Migrate an on-site faceted search to a headless one without redefining facets.
- Ensure facets only activate on indexes whose server supports the facets feature.
- Give a decoupled catalog/search page structured filter data from Drupal.
- Default new facets on a JSON:API source to the correct widget without manual selection.
