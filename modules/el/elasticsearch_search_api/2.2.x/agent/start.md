<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Elasticsearch - Search API (elasticsearch_search_api) — agent index

A **framework** (not a turnkey backend) for building custom Elasticsearch-backed search pages on top of
Search API. It supplies PHP services, an extendable `SearchController`, a `SearchForm`, faceted-search
plumbing, index "sync strategies" (n-gram, autosuggest, did-you-mean, synonyms, custom_all) and themeable
templates. You wire it together in your own module. Version **2.2.1**, core `^10.2 || ^11`.

Depends on `search_api` and `elasticsearch_connector` (the latter owns the actual ES connection/cluster
config and client). Submodules: `elasticsearch_search_api_example`, `esa_pager`.

IMPORTANT — this module ships its `routing.yml`, `services.yml`, `permissions.yml`, `links.menu.yml` and
`drush.services.yml` as **`.example` files** (see `*.yml.example` in the module root). Drupal does NOT load
them. Out of the box the parent registers **no routes, no services, no permissions, no drush commands and no
config schema** — only theme hooks, JS/CSS libraries, and three hooks (`hook_cron`, `hook_theme`,
`hook_node_type_insert`). You copy the example files into your own module (or the example submodule) and
define which services/routes to use. `configure` is null (no settings page).

- **Framework services + the extendable SearchController/SearchForm pattern (build a search page)** →
  [api/framework.md](api/framework.md)
- **Faceted search: facet controls, facet-value objects, aggregations, active-filters** →
  [api/facets.md](api/facets.md)
- **Index sync strategies (n-gram/autosuggest/did-you-mean/synonyms/custom_all), SyncService, cron, the
  drush command, synonym & keymatch config** → [api/strategies.md](api/strategies.md)
- **Index-preparation events (elasticsearch_connector PREPARE_INDEX / PREPARE_INDEX_MAPPING)** →
  [events/index.md](events/index.md)
- **The search-form block** → [blocks/search-form.md](blocks/search-form.md)
- **The `strip_tags_trimmed` field formatter** → [fields/strip-tags-trimmed.md](fields/strip-tags-trimmed.md)
- **Theme hooks, JS/CSS libraries, the `search_index` view mode install behavior** →
  [theme/templates.md](theme/templates.md)

Key facts (machine names taken from source):
- Submodules: `elasticsearch_search_api_example` (reference implementation, live `/example/search`),
  `esa_pager` (custom Views/AJAX pager, theme `esa_pager`).
- Example service ids (in `services.yml.example`): `elasticsearch_search_api.elasticsearch_params_builder`,
  `.search_action_factory`, `.elasticsearch_result_parser`, `.search_repository`,
  `.suggest.title_suggester`, `.term_facet_storage`, `.term_tree_storage`, `.sync`,
  `.sync_strategy.{synonym,autosuggest,did_you_mean,custom_all}`, `.factory.index`,
  `.event_subscriber.initialize_index`, `.keymatch_service`, `.factory.keymatch_entry`.
- Example parameters: `elasticsearch_search_api.search_page_size` (default `10`),
  `elasticsearch_search_api.index` (default `general` — the Search API index machine name).
- Core services: `SearchController` (`::search`, `::filter`, `::handleAutocomplete`), `SearchForm`,
  `ElasticSearchParamsBuilder`, `SearchActionFactory`, `ElasticSearchResultParser`, `SearchRepository`,
  `SyncService`, `KeymatchService`.
- Facet service naming convention (tag-by-id): `elasticsearch_search_api.facet_control.<facet>`.
- Config objects the shipped forms read/write: `elasticsearch_search_api.synonym_settings` (key `synonyms`),
  `elasticsearch_search_api.keymatch` (key `keymatches`). No schema ships for them.
- Provides: block plugin `elasticsearch_search_api`, field formatter `strip_tags_trimmed`,
  event subscriber, drush command `reset-search-index-with-ngram-analyzer` (only when wired).
- Enabling the module (and `hook_node_type_insert`) adds a `search_index` view mode to every node type.
- Reads ES credentials/host/TLS from the `elasticsearch_connector` cluster entity; this module never opens
  the connection itself (uses `@elasticsearch_connector.client_manager`).
