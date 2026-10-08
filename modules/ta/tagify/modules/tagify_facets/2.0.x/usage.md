Tagify Facets is a submodule of Tagify that adds a Facets widget rendering each facet value as a Tagify-style tag chip.

---

The Facets module lets you build faceted search interfaces (checkboxes, links, dropdowns) on top of Search API. Tagify Facets contributes an extra widget, `tagify`, that you select on a facet's *Edit* page under the Widget setting. Instead of a vertical list of checkboxes or links, facet values render as compact, clickable tag chips using the same Tagify library and styling as the rest of the module. Active facet values appear as removable tags, giving search result filtering an app-like feel. It requires both the parent Tagify module and the Facets module. There is no separate configuration form — the widget is chosen and tuned entirely through the standard Facets widget UI. This is a presentation-layer enhancement: the facet source, query type, and processing are all still handled by Facets.

---

- Render Search API facet values as clickable tag chips.
- Give a faceted search sidebar a modern, compact look.
- Let users remove an active filter by clicking the "x" on a tag.
- Replace a long checkbox facet list with space-saving tags.
- Match facet styling to Tagify-based reference fields on the same site.
- Apply the Tagify widget to a taxonomy-based facet.
- Apply the Tagify widget to a content-type or status facet.
- Provide a touch-friendly facet UI on mobile.
- Keep facet interaction consistent with the site's tag inputs.
- Use it on any facet source supported by Facets.
- Swap widgets per facet without changing the query.
- Show selected filters prominently as highlighted tags.
- Reduce visual clutter on results pages with many facets.
- Combine with Better Exposed Filters Tagify widgets for a unified UI.
- Offer an alternative to the default links/checkboxes facet widgets.
