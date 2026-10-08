<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# elasticsearch_search_api_example — agent index

Submodule of **elasticsearch_search_api**. A **working reference implementation** of the framework: a live
`/example/search` faceted search page over an `elasticsearch_page` node type, wired with real
`services.yml` + `routing.yml`. Use it as a demo or as the scaffold when starting your own search module —
it is not meant to be a production feature on its own. Core `^10.2 || ^11`. Depends on `search_api` and
`elasticsearch_connector`.

- **The reference wiring: routes, services, the extended controller/params-builder/result-parser, the
  hierarchical `page_type` facet, and the installed Search API index/content type** →
  [api/example.md](api/example.md)

Setup (from the README): create an `elasticsearch-connector` cluster, add a Search API server named
`elastic`, enable this submodule, then visit `/example/search`. Create "Elasticsearch page" nodes (with
`page_type` taxonomy terms) to populate it.

Key facts:
- Routes: `elasticsearch_search_api_example.search` (`/example/search`),
  `.filter` (`/example/search/filter`), `.autocomplete` (`/example/search/autocomplete`) — all
  `_permission: 'access content'`.
- Controller `Controller\ExampleSearchController extends …\SearchController`; facet `page_type`.
- Services (real `services.yml`) prefixed `elasticsearch_search_api_example.*`; index parameter
  `elasticsearch_search_api_example.index = 'example_general'`.
- Installed config: node type `elasticsearch_page`, `page_type` vocabulary, `field_page_type`,
  Search API index `example_general` (server `elastic`).
- No permissions, drush, config schema, or plugin types of its own.
