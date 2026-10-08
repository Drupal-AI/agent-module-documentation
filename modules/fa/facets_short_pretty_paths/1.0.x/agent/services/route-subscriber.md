<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `RouteSubscriber` — adding the `{facets_query}` path parameter

File: `src/RouteSubscriber.php`
Class: `Drupal\facets_short_pretty_paths\RouteSubscriber extends RouteSubscriberBase`
Service: `facets_short_pretty_paths.route_subscriber` (`facets_short_pretty_paths.services.yml`), tagged
`event_subscriber`, constructed with `@plugin.manager.facets.facet_source`.

## Purpose

For every facet-source route that is configured to use the short-pretty-paths URL processor, it rewrites the
route path so the shortened facet segment (`black.yellow.red`-style) can be captured as a single route
parameter. Without this, `/search/color/blue` would 404 because `/search` is a fixed route.

## `alterRoutes(RouteCollection $collection)`

1. Iterates all facet-source plugin definitions (`FacetSourcePluginManager::getDefinitions()`), instantiates
   each and reads its `getPath()`.
2. Loads the matching `facets_facet_source` config entity (source id `:` → `__`). **Skips** the source
   unless it exists and `getUrlProcessorName() == 'facets_short_pretty_paths'` — routes for sources not
   using this processor are left untouched.
3. Resolves the source path to its route via `Url::fromUri('internal:' . $path)->getRouteName()` and, only
   if the route's path does not already contain `/{facets_query}` (idempotency guard, per
   facets_pretty_paths issue 2984105):
   - appends `/{facets_query}` to the path, with default `''` and requirement `.*` (so the segment may hold
     slashes and be empty);
   - appends a series of filler optional parameters `/{f0}/{f1}/…` (each defaulting to `''`) until the path
     reaches ~250 chars. This works around a core routing bug (drupal.org issue 2741939) where a single
     slash-bearing parameter otherwise fails to match; `{facets_query}` still consumes the whole remainder,
     so the fillers never receive a value. The 255-char router-table path limit caps how many active filter
     pairs a given base path can express.
4. Wrapped in a `try/catch (\Exception)` that silently ignores routes that cannot be resolved.

## Security-relevant notes (feature description, not a gap)

The subscriber only **extends the path pattern** of routes already belonging to facet sources that opted
into this processor. It does not change any `_access`/`_permission`/`_role` requirement on those routes, and
it performs no redirect — the underlying route's access control is preserved. Rebuild routes (`drush cr`)
after switching a source's URL processor so this subscriber re-runs.
