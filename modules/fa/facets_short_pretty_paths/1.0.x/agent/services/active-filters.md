<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ShortPrettyPathsActiveFilters` — decoding the shortened path

File: `src/ShortPrettyPathsActiveFilters.php`
Class: `Drupal\facets_short_pretty_paths\ShortPrettyPathsActiveFilters`
Service: `facets_short_pretty_paths.active_filters` (`facets_short_pretty_paths.services.yml`), constructed
with `@facets_pretty_paths.active_filters`, `@entity_type.manager`, `@plugin.manager.facets_pretty_paths.coder`.

## Purpose

The mirror of the URL processor's `buildUrls()`: it turns a request's shortened facet path back into the
map of active facet selections that Facets applies to the search query. The URL processor calls it from
`initializeActiveFilters()`. It overrides the behaviour of the base Facets Pretty Paths active-filters
service (which cannot parse the dot-joined short form).

## `getActiveFilters($facet_source_id)`

Returns `array<facet_id, string[] decoded values>` for one facet source. Steps:

1. Caches results per facet-source id in `drupal_static('facets_pretty_paths_init')` so parsing runs once
   per request.
2. Obtains the raw filter string from the route by invoking the base service's **protected**
   `getFiltersFromRoute()` via `\ReflectionMethod` (`setAccessible(TRUE)`). Returns early if empty.
3. `explode('/', $filters)`. If the number of parts is odd, `array_shift()` drops the first part (handles a
   route living under the same path as the facet source, e.g. `/search/overview`).
4. **Short-paths expansion**: walking parts as alias/value pairs, each value is split on
   `FacetsShortPrettyPathsUrlProcessor::FACET_ITEMS_DELIMITER` (`.`) and re-expanded into repeated
   `alias, item` pairs — so `color, black.yellow` becomes `color, black, color, yellow`.
5. For each expanded alias/value pair it resolves the facet id from the alias via the base service's
   protected `getFacetIdByUrlAlias()` (again through reflection), skipping unknown aliases. It loads the
   facet (once per id), instantiates its configured `facets_pretty_paths` coder, and calls
   `$coder->decode($value)`, appending the decoded value to `$mapping[$facet_source_id][$facet_id]`.

The decoded values (e.g. taxonomy term ids from `TaxonomyTermCoder::decode()`) become the active facet
selections; Facets/Search API applies them through its normal parameterized query building, and result
access continues to follow the underlying search index. See
[../plugins/taxonomy-coder.md](../plugins/taxonomy-coder.md) for how a single value is decoded.

## Note

The reliance on reflection to reach `getFiltersFromRoute()`/`getFacetIdByUrlAlias()` is a deliberate reuse
of the base module's logic (see README: overriding the active-filters service was the reason a contributed
module was preferred over a patch). It couples this class to those protected method names.
