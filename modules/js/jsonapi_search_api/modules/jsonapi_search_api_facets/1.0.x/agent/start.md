<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Search API Facets — agent index

Adds Facets support to the `jsonapi_search_api` index endpoint: facet counts are returned in
the search response `meta.facets`, and facet selections are read from the JSON:API
`filter[...]` params. No settings page, no permissions, no Drush, no config of its own.
Requires `jsonapi_search_api` + `facets`.

- **The facet source / widget / URL-processor plugins, the event subscribers, and the
  presave rules that configure a JSON:API facet** →
  [configure/facets.md](configure/facets.md)

Key facts:
- Facet source: `jsonapi_search_api_facets:<index_id>` (derived per facets-capable index).
- Widget: `jsonapi_search_api` (renders facets as JSON); URL processor: `json_api`.
- Any facet on a `jsonapi_search_api_facets:*` source is forced (on presave) to the
  `jsonapi_search_api` widget; the source is forced to filter key `filter` + URL processor
  `json_api`.
- Facets are injected into `meta.facets` via the `jsonapi_search_api.add_search_meta` event;
  the query is augmented via Search API's `QUERY_PRE_EXECUTE` event.
- Only active when the index's server supports `search_api_facets`. No hierarchy / min-count
  / hard-limit support yet.
