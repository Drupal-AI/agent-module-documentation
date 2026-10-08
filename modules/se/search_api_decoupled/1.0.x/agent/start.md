# Search API Decoupled — agent index

Exposes a Search API index as a JSON HTTP search endpoint (`/api/search/{endpoint}`) for headless
front-ends — no View, optionally no entity loading. Requires `search_api ^1.28`. Admin UI at
`/admin/config/search/search-api/endpoints` (config entity `search_api_endpoint`; `configure` in
info.yml is null). Provides its own permissions, a config schema, a filter plugin type, and events.

- **The `search_api_endpoint` config entity: every field, admin UI, creating endpoints & filters** →
  [configure/endpoint.md](configure/endpoint.md)
- **The HTTP API: `/api/search/{endpoint}`, all query params, JSON response shape, events** →
  [api/endpoint.md](api/endpoint.md)
- **Permissions: `administer search_api_endpoint` + per-endpoint `use search with <id> endpoint`** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `search_api_decoupled_filter` plugin type (annotation, manager, base, `standard` fallback)** →
  [plugins/filter.md](plugins/filter.md)

Submodules (ship in-tree, not enabled by default — own docs not written this pass):
- `search_api_decoupled_ui` — front-end search UI builder (element plugins, layouts, templates).
- `search_api_decoupled_facets` — Facets module integration (event subscriber).
- `search_api_decoupled_autocomplete` — Search API Autocomplete integration.
- `search_api_decoupled_demo` — demo/install fixtures.

Key facts:
- Route `search_api_decoupled.search_results` → `/api/search/{search_api_endpoint}`, access check
  `_search_api_endpoint` (`SearchApiEndpointAccessCheck`): index must be enabled AND account holds
  `use search with <id> endpoint` OR `administer search_api_endpoint`.
- Controller `SearchApiEndpointController::searchResults()` → `CacheableJsonResponse`.
- Filter plugin manager service `plugin.manager.search_api_decoupled.filter`; alter hook
  `hook_search_api_decoupled_filter_info_alter`.
- Events: `search_api_decoupled.search_results_alter` (`SearchApiEndpointResultsAlter`),
  `search_api_decoupled.search_endpoint_facets_alter` (`SearchApiEndpointFacets`).
- **Install caveat:** the project requires `wikimedia/composer-merge-plugin` to merge
  `composer.libraries.json` (front-end libs) — already installed here.
