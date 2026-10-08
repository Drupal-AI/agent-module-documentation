Facets Summary (experimental) adds a summary block that shows all currently applied facet filters in one place, with one-click removal of individual filters and a "reset all" link, plus an optional result count.

---

This facets submodule introduces a `facets_summary` config entity and its own summary manager and processor plugin type (`facets_summary_processor`, managed by `plugin.manager.facets_summary.processor`). A summary is bound to a facet source and aggregates the active values from every facet on that source into a single "current search" block. Built-in summary processors can show the total result count, display each active filter as a removable chip, and render a reset link. It also provides Views integration (a filter and an area plugin) so the summary can appear inside a view, and its own templates, routing, action/task/contextual links, and config schema. Developers can add new `facets_summary_processor` plugins to change what the summary shows. Use it to give users clear feedback about the filters they have applied and an easy way to clear them.

---

- Show a "current search" block listing all active facet filters.
- Let users remove a single applied filter with one click.
- Provide a "reset all filters" link above search results.
- Display the total result count for the current filter set.
- Render active filters as removable chips/tags.
- Give clear feedback about which facets are applied.
- Show the summary inside a Search API view via the area plugin.
- Add a filter summary to an e-commerce results page.
- Improve UX by surfacing hidden/scrolled-away active facets.
- Place the summary block in any region near results.
- Combine summary with facet blocks for full filter context.
- Provide breadcrumb-style filter context on search pages.
- Show count-only summaries (e.g. "42 results") without chips.
- Let editors configure which processors run on the summary.
- Add a custom summary processor to change the output.
- Reset filters while keeping the search keyword.
- Localize active-filter labels in the summary.
- Help users backtrack when they over-filter to zero results.
- Display applied ranges/dates in the summary.
- Reflect the current search state for shareable URLs.
