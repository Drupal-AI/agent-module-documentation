<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Search API — agent index

Exposes every **enabled** Search API index as a JSON:API resource at
`/%jsonapi%/index/{index_id}` (default `/jsonapi/index/<id>`). No config, no settings page,
no permissions, no Drush. Requires `jsonapi`, `jsonapi_resources`, `search_api`. Submodule:
`jsonapi_search_api_facets` (facets in the response `meta`).

- **The endpoint: routes per index, query params (filter/sort/page/fulltext), response shape,
  supported operators** → [api/endpoint.md](api/endpoint.md)
- **Exposing an index (enable it) and the `AddSearchMetaEvent` extension point** →
  [configure/expose-index.md](configure/expose-index.md)

Key facts:
- One route per enabled index: `jsonapi_search_api.index_<id>` → `/%jsonapi%/index/<id>`,
  built by `Routing\Routes::routes()` (route callback), served by `Resource\IndexResource`.
- Only **enabled** indexes get a route (an index must have a server and be enabled).
- Query maps to Search API: `filter[fulltext]=` → keywords; `filter[...]` → conditions;
  `sort` → sorts; `page[offset]`/`page[limit]` → range. Search id `jsonapi_search_api:<id>`.
- Extend the response `meta` via the event `jsonapi_search_api.add_search_meta`.
