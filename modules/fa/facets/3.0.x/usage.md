Facets adds faceted search interfaces (filter blocks for categories, price ranges, dates, tags, etc.) on top of Search API search pages and views, letting visitors drill down and refine results without writing queries.

---

Facets works with a Search API index and turns any indexed field into an interactive filter, called a facet. Each facet is a config entity that points at a facet source (a Search API view or display), a field, a widget (checkboxes, links, dropdown, or a custom one), and a chain of processors that shape its behaviour. Processors run at different stages — before the query, after the query, and while building the render array — to do things like hide facets with only one result, limit the number of shown items, sort results by count or display value, exclude specific values, or add "soft limit" show-more toggles. Facets render as blocks you place in any region, or (via the submodules) as Views exposed filters or REST output. A URL processor keeps the active filters in the query string so selections are bookmarkable and shareable, and results carry the right cache contexts. Hierarchy plugins support nested taxonomy facets, and query-type plugins map Search API data types (string, date, numeric range, granular) to the correct backend query. Site builders configure everything at Admin → Configuration → Search → Facets; developers extend it with widget, processor, query-type, URL-processor, facet-source, and hierarchy plugins plus an alter hook for query-type mapping.

---

- Add a category/taxonomy sidebar filter to a Search API results page.
- Let visitors refine an e-commerce catalog by brand, color, and size.
- Provide a price-range slider on product search (with Facets Range Widget).
- Filter a job board by location, contract type, and department.
- Show a "content type" facet to narrow a global site search.
- Display active-tag facets on a blog or news archive.
- Render facets as checkboxes, links, or a dropdown per facet.
- Show result counts next to each facet value (e.g. "News (42)").
- Hide facets that have no results or only a single value.
- Limit a long facet list with a "Show more / Show less" soft limit.
- Sort facet items by count, by display value, or by active state.
- Exclude specific values from a facet (e.g. drop an "undefined" bucket).
- Build dependent facets that only appear once a parent facet is chosen.
- Create nested taxonomy facets that expand into child terms.
- Combine several facets into a single combined facet.
- Bucket dates into year/month granularity facets.
- Keep selected filters in a bookmarkable, shareable URL.
- Expose facets as Views exposed filters with AJAX (Facets Exposed Filters).
- Return facet data alongside a REST view for a decoupled front end (Rest Facets).
- Add a search-as-you-type box to filter long facet lists (Searchbox Widget).
- Show a summary of the currently applied filters with one-click reset (Facets Summary).
- Provide OR/AND filtering semantics per facet.
- Theme individual facet items with per-widget template suggestions.
- Add a custom widget plugin for a bespoke facet UI.
- Add a processor to transform or reorder facet results programmatically.
- Map a custom Search API data type to a query type via an alter hook.
- Spin up a ready-made demo of faceted search (Facets Demo).
- Let editors build faceted listings without writing any query code.
