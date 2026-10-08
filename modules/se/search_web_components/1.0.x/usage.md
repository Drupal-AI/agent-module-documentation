<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search Web Components ships a set of Lit custom-element web components (search box, results, facets, sort, pager) that consume a search_api_decoupled JSON endpoint and render a client-side search UI on a standard Drupal page.

---

The components talk to a decoupled endpoint and update the DOM (instant results, facets, URL-synced state) while Drupal only serves the initial HTML that embeds them, avoiding a separate frontend build. The JS loads via a `components` library (`lit/search-web-components.min.js`, an ES module). The PHP side is configuration glue: `search_web_components.module` alters the `search_api_endpoint` edit form to add "Search Web Components" settings — sort options, page sizes, display modes, and result-to-element mappings (which component renders which result type) — stored as third-party settings on the endpoint config entity, and `hook_ENTITY_TYPE_presave` seeds/normalizes defaults. An `EndpointEventSubscriber` on search_api_decoupled's `SEARCH_RESULTS_ALTER` event injects those settings into every endpoint JSON response so the components self-configure.

Three submodules extend it: `search_web_components_block` exposes each component as a placeable Drupal block (search-box, results, facets, sort, pager, applied-facets, and more, in the "Search Components" category); `search_web_components_facets` adds a second subscriber that builds facets (running processors/hierarchy) into the response plus SWC facet widgets (`swc_dropdown`, `swc_dropdown_html`, `swc_button`, `swc_checkbox`) and a reorganized facet edit form; `search_web_components_layout` provides one- and two-column Layout Builder layouts pre-wired for search regions. All admin surfaces are gated by `administer search_api_endpoint`. Operationally an admin enables the module plus search_api_decoupled, creates a decoupled endpoint, configures sorts/page-sizes/displays/result mappings on the endpoint edit form, then places the component blocks (or uses a search layout).

---

- Add a decoupled, client-side search UI to a page with web components.
- Place a `swc_search_box` block for the search input.
- Place a `swc_search_results` block to render results.
- Configure result-to-element mappings on an endpoint.
- Add or delete a result mapping via the mapping forms.
- Render results as pretty-printed JSON (default element).
- Render results as HTML from a rendered field.
- Define sort options on the endpoint (`field|order|label`).
- Define page-size options for a results-per-page component.
- Define display modes for the results switcher (list/grid).
- Place sort, pager, and results-per-page blocks.
- Place a results switcher (grid/list toggle) block.
- Place facet blocks (button / checkbox / dropdown / dropdown-html).
- Show active filters via a `swc_search_applied_facets` block.
- Show a "no results" message component.
- Show a result summary/count component.
- Add a dialog toggle for mobile/off-canvas search.
- Point a block at a remote endpoint via manual entry.
- Override a facet's label per block placement.
- Configure facets with SWC widgets and hierarchy support.
- Use the reorganized facet edit form (interface/processing/advanced).
- Build a search page with the one- or two-column search layout.
- Serve facet data (counts, active values, children) in the endpoint JSON.
- Seed sensible endpoint defaults automatically on creation.
- Override result field/mappings per-block via block config JSON.
