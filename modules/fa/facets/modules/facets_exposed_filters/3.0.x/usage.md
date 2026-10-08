Facets Exposed Filters renders facets as native Views exposed filters, so a Search API view can offer faceted refinement inline in its exposed-filter form instead of (or alongside) separate facet blocks.

---

This facets submodule adds a Views filter plugin (`FacetsFilter`) and Search API display plugins (`ViewsDefault`, `ViewsAttachment`) that let you attach configured facets to a view as exposed filters. Editors pick which facets to expose right in the view's filter configuration, and the facets appear in the exposed form with their chosen widgets. It integrates with Better Exposed Filters (a required dependency) so the exposed facets can be rendered as checkboxes, links, or other BEF element types, and it supports AJAX views so refining does not reload the whole page. Because the facets live in the exposed form, they share the view's AJAX, pager, and sort behaviour. Configuration schema is added for the views integration. It depends on Search API, Facets, Views, and Better Exposed Filters.

---

- Expose category facets directly in a Search API view's exposed filter form.
- Combine facets with normal exposed filters and sorts in one form.
- Render exposed facets as checkboxes or links via Better Exposed Filters.
- Refine a faceted view over AJAX without a full page reload.
- Keep facets, pager, and sort in sync inside a single view.
- Build a search results page without placing separate facet blocks.
- Add brand/color/size exposed facets to a product listing view.
- Let editors choose which facets appear as exposed filters per view.
- Provide a compact filter bar above a results grid.
- Attach facets to a view's attachment display for a sidebar layout.
- Offer collapsible exposed facet groups on mobile.
- Reuse existing facet configuration (widgets, processors) inside a view.
- Add faceted filtering to an embedded view block.
- Support multi-value OR filtering through exposed facet widgets.
- Keep active filters reflected in the view's exposed form state.
- Migrate a block-based facet layout into an exposed-filter layout.
- Give a decoupled-friendly exposed form for a Search API view.
- Filter a document/library listing with inline exposed facets.
- Present a job-search form with location and type as exposed facets.
- Standardise faceting UX with the rest of the site's exposed forms.
