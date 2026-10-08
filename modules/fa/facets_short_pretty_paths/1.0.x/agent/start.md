<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facets Short Pretty Paths (facets_short_pretty_paths) — agent index

Add-on for **Facets Pretty Paths** that shortens facet URLs: each facet's URL alias is written once and
its active values are joined with a dot (`/color/black.yellow.red` instead of
`/color/black-1/color/yellow-2/color/red-3`), and a taxonomy coder can emit a term's machine name in
place of its id. Package `Search`. License GPL-2.0-or-later. Version 1.0.0-alpha5 (pre-release; version
dir `1.0.x`). Core `^8 || ^9 || ^10 || ^11`.

## Dependencies

- `facets_pretty_paths:facets_pretty_paths` — provides the base URL processor
  (`FacetsPrettyPathsUrlProcessor`), the coder base class + coder plugin manager
  (`plugin.manager.facets_pretty_paths.coder`), and the `facets_pretty_paths.active_filters` service
  this module extends/overrides. It in turn requires **Facets** (`facets`).
- Optional (runtime, not declared): **Taxonomy Machine Name** (`taxonomy_machine_name`) — supplies the
  `machine_name` base field the taxonomy coder reads by default. `hook_requirements()` errors at install
  if no field named by `facets_short_pretty_paths_field_name` exists on `taxonomy_term`.

## What it provides (from source)

- **One Facets URL processor plugin**: `Drupal\facets_short_pretty_paths\Plugin\facets\url_processor\FacetsShortPrettyPathsUrlProcessor`
  (id `facets_short_pretty_paths`), extending Facets Pretty Paths' processor. Its `buildUrls()` aggregates
  a facet's active values under a single alias joined by the `.` delimiter (`FACET_ITEMS_DELIMITER`), and
  `initializeActiveFilters()` delegates to this module's active-filters service.
  → [plugins/url-processor.md](plugins/url-processor.md)
- **One Facets Pretty Paths coder plugin**: `Drupal\facets_short_pretty_paths\Plugin\facets_pretty_paths\coder\TaxonomyTermCoder`
  (id `taxonomy_term_machine_name_coder`). `encode($id)`/`decode($alias)` map a term id ↔ its machine-name
  slug, with a term-name-plus-id fallback. → [plugins/taxonomy-coder.md](plugins/taxonomy-coder.md)
- **Route subscriber** `Drupal\facets_short_pretty_paths\RouteSubscriber` (service
  `facets_short_pretty_paths.route_subscriber`) — appends `/{facets_query}` (+ filler params) to
  facet-source routes whose URL processor is `facets_short_pretty_paths`.
  → [services/route-subscriber.md](services/route-subscriber.md)
- **Active-filters service** `Drupal\facets_short_pretty_paths\ShortPrettyPathsActiveFilters` (service
  `facets_short_pretty_paths.active_filters`) — decodes the shortened path back into active facet
  selections. → [services/active-filters.md](services/active-filters.md)
- **Form alter** in `.module`: `hook_form_facets_facet_edit_form_alter()` adds the "Pretty paths coder"
  radios (and a custom submit handler) to a facet's edit form when the source uses this processor.
- **Install hook**: `hook_requirements()` (`.install`) requires a taxonomy-term machine-name field.

## What it does NOT provide

No routes of its own, no controllers, no permissions, no config objects, **no config schema**, no
`config/install`, no entities, no Drush, no libraries, no new plugin types. `configure` is null — there is
no settings form; per-facet coder choice is stored as the `facets_pretty_paths` third-party setting on the
facet entity, and behaviour is tuned via `settings.php`. It changes URL form only, not access or results.

## Install / operate

1. `composer require drupal/facets_short_pretty_paths` (pulls `drupal/facets_pretty_paths`); optionally
   `drupal/taxonomy_machine_name` for term machine names.
2. `drush en facets_short_pretty_paths -y`.
3. On the **facet source**, set the URL processor to **Short pretty paths**.
4. On each taxonomy-term facet, choose the **Taxonomy term machine name** coder (or configure a field via
   `$settings['facets_short_pretty_paths_field_name']`).
5. Optional `settings.php`: `$settings['facets_short_pretty_paths_use_dashes'] = TRUE;` for dash slugs.
   Rebuild routes/caches (`drush cr`) after changing the processor so the route subscriber re-runs.
