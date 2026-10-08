# Blocks (acquia_cms_search)

## `clear_facet_filters` block — `ClearFacetFilters`

`src/Plugin/Block/ClearFacetFilters.php`, `@Block(id = "clear_facet_filters")`, admin label
"Clear Facet Filters". Renders a single "Clear filter(s)" link back to the current route that drops
the active facet selection, and renders **nothing** when no facet is active.

- Handles both facet URL modes: `facets_pretty_paths` (facets in the `facets_query` route parameter —
  the link keeps only the current query string) and query-string facets (the `f` GET parameter — the
  link removes `f`).
- Injects `current_route_match` and `request_stack`. `getCacheMaxAge()` returns `0` (uncacheable) —
  the toggle and target URL change per page and per active facet.

## Shipped block placements (`config/optional/`)

All four are placed in the Cohesion / Site Studio `dx8_hidden` region of `cohesion_theme` (so a Site
Studio layout can drop them in), and depend on `cohesion`; the facet blocks also use `collapsiblock`
to collapse.

| Block config | Plugin | Renders |
|---|---|---|
| `clear_facet_filters` | `clear_facet_filters` | The clear-filters link above. |
| `exposed_form_search` | `views_exposed_filter_block:search-search` | The keyword search box (exposed filter of the `search` view). |
| `search_content_type` | `facet_block:search_content_type` | The "Content Type" facet (field `type`). |
| `search_category` | `facet_block:search_category` | The "Category" facet (field `field_categories`), created dynamically when an Acquia CMS content submodule installs. |

These block placements are Site-Studio-oriented; on a non-Cohesion theme you would place the same
plugins (`views_exposed_filter_block:search-search`, `facet_block:*`, `clear_facet_filters`) into your
own theme's regions instead.
