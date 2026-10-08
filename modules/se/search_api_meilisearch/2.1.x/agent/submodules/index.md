<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

Both submodules ship at version 2.1.0, package Search, core `^9.3 || ^10 || ^11`, and depend on
`search_api_meilisearch`.

## search_api_meilisearch_autocomplete
Adds search-as-you-type. Extra dependency: `search_api_autocomplete`.
- `MeilisearchAutocompleteService` (`search_api_meilisearch_autocomplete.autocomplete`,
  args `@logger.channel.search_api_meilisearch`, `@search_api_meilisearch.api`) —
  `getSuggestions()` re-reads the backend's host/port/master key, runs a **server-side**
  Meilisearch search (default limit 10), loads the matched Search API items, and builds
  suggestions from each item's string via `SuggestionFactory`. Suggestions are computed on the
  server; the Meilisearch key is not sent to the browser.
- `DeterminingServerFeaturesSubscriber` — advertises the autocomplete feature to the backend.
- The backend's `getAutocompleteSuggestions()` delegates to this service (backend implements
  `AutocompleteBackendInterface`); the service is only wired into the backend when this submodule
  is enabled (`$container->has(...)` guard).

## search_api_meilisearch_facets
Adds Meilisearch faceted search. Extra dependency: `facets`.
- `DeterminingServerFeaturesSubscriber` — advertises facet support.
- `ProcessingResultsSubscriber` (args `@search_api_meilisearch.api`,
  `@search_api_meilisearch.filter_parser`) — runs facet searches against Meilisearch
  (`MeilisearchApiService::searchFacets()`) and populates facet result counts, reusing the same
  filter parser as the backend.

## Notes
- Neither submodule adds routes, permissions, or its own config schema.
- `meilisearch/meilisearch-php` and `drupal/facets` / `drupal/search_api_autocomplete` appear as
  `require-dev` in the module's composer.json; install the corresponding contrib modules to use the
  submodules.
