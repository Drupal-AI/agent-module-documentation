Facets Pretty Paths replaces the query-string URLs that the Facets module generates (`?f[0]=brand:drupal&f[1]=color:blue`) with clean, slash-separated "pretty" paths (`/brand/drupal/color/blue`). It plugs into Facets as an alternative URL processor.

---

The module ships a single Facets **URL processor** plugin (`facets_pretty_paths`) that a facet source is switched to instead of the default `query_string` processor. Once a facet source uses it, every facet on that source reads and writes its active filters as extra path segments appended to the source's own path, in the form `/{facet-url-alias}/{encoded-value}` per active value, ordered by facet weight then name. A `RouteSubscriber` registers a catch-all route so the trailing `facets_query` segments resolve back to the search page, and a breadcrumb builder produces breadcrumbs from the active pretty-path filters. How each raw facet value is turned into a URL segment (and back) is delegated to a pluggable **coder** plugin type (`@FacetsPrettyPathsCoder`, namespace `Plugin/facets_pretty_paths/coder`): the module bundles `default_coder`, `url_encoded_coder`, `taxonomy_term_coder`, `taxonomy_term_name_coder`, `node_title_coder` and `list_item_coder`, and the chosen coder is stored per facet as a third-party setting (`facets_pretty_paths.coder`). It also integrates with the Facets exposed-filters submodule so views-based facets can opt into a coder via the exposed-filter config form. The module depends on `facets` and `pathauto` (the latter supplies the alias-cleaner used by several coders). It has no admin settings page of its own — configuration happens on the Facets facet-source and facet edit forms.

---

- Turn ugly `?f[0]=...` facet query strings into readable `/brand/drupal/color/blue` URLs.
- Improve SEO by giving each faceted filter combination a clean, crawlable, canonical-looking path.
- Make faceted search URLs human-readable and shareable (users can guess and edit segments).
- Switch a Search API facet source from the default query-string processor to pretty paths.
- Produce breadcrumbs that reflect the currently active facet filters.
- Encode taxonomy-term facets as `term-name-ID` slugs (`/color/blue-2`) for readable term URLs.
- Encode taxonomy-term facets as bare `term-name` slugs (`/color/blue`) when IDs aren't wanted.
- Encode node-reference facets as `node-title-ID` slugs (`/author/jane-doe-7`).
- Encode list_string / list_integer facets as `label-value` slugs (`/size/large-3`).
- Safely encode raw values that contain reserved/special characters with the URL-encoded coder.
- Keep default (raw id) encoding where the facet value is already a clean slug.
- Add a custom coder plugin to control how a bespoke facet's values map to URL segments.
- Give faceted category/brand/color storefront filters marketing-friendly URLs.
- Provide stable, bookmarkable landing pages for common facet combinations.
- Preserve non-facet query parameters (e.g. keyword search, sort) alongside pretty-path facets.
- Reset an invalid `page` parameter automatically when adding/removing a filter changes result counts.
- Let facets rendered as Views exposed filters opt into a pretty-paths coder per filter.
- Support hierarchical (parent/child) taxonomy facets in the pretty-path URL.
- Emit `rel="nofollow"` on generated facet links to steer crawler budget.
- Allow other modules to alter each generated facet URL via the Facets `UrlCreated` event.
- Localise term-based segments using the current-context translation of the term name.
- Give multi-facet drill-down interfaces tidy nested paths instead of long query strings.
- Migrate an existing query-string facet setup to pretty paths without rebuilding the search.
- Combine several active facets into a single ordered, deterministic path (sorted by weight/name).
