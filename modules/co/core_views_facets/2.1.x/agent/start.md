<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Core Views Facets — agent index

A Facets add-on: makes a plain **Views page** display (with exposed/contextual filters) usable
as a Facets *facet source*, so you get facets without Search API. Requires `facets` + `views`.
No settings form, permission, or Drush; state lives in `facets_facet` / `facets_facet_source`
config + the View.

- **Set up a working facet from a view** (prerequisites, the two derived facet sources, the
  mandatory `core_views_url_processor`, adding the facet) →
  [configure/setup-facet.md](configure/setup-facet.md)
- **The filter-type plugin types & how to add support for a custom Views filter/argument** →
  [plugins/filter-types.md](plugins/filter-types.md)

Key facts:
- A view page display with an **exposed** filter → facet source id
  `core_views_exposed_filter:<view>__<display>`; with a **contextual** filter →
  `core_views_contextual_filter:<view>__<display>`. The `facets_facet_source` config entity id
  replaces `:` with `__` (e.g. `core_views_exposed_filter__myview__page_1`).
- **Mandatory step:** edit the facet source and set its URL processor to
  `core_views_url_processor` ("Core views url processor"), else facet links won't work.
- A facet's `field_identifier` = the exposed filter's id (exposed) / contextual argument id.
- Plugin types: `core_views_facets_exposed_filter_types`, `core_views_facets_contextual_filter_types`.
