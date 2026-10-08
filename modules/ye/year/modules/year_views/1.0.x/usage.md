Year Views is a submodule of Year that adds a `year_field` Views filter plugin, turning an exposed year filter into a user-friendly dropdown of years generated from a configurable range instead of a free-text numeric input.

---

The submodule provides one Views filter handler, `year_field` (`YearField`, extending core's `ManyToOne`). Its exposed control is a select list whose options come from `range(year_from, year_to)`, where both bounds are configured in the filter's **extra options** form and may be a specific year or a PHP relative-time expression (`now`, `-20 years`, …) resolved with `strtotime()`/`date('Y')`. Defaults are `year_from = -30 years`, `year_to = +15 years`, `sort_order = asc`. A `sort_order` option (ascending/descending) controls the order of the years in the dropdown. Because it extends `ManyToOne`, it supports multi-select and the usual "is one of / is not one of" operators. To use it, the underlying `year` field must be exposed to Views and its filter handler set to `year_field` (typically done in the field's Views data). No permissions, no config UI, no services.

---

- Replace a free-text year filter on a View with a curated dropdown of valid years.
- Expose a "Year" facet-like dropdown on an archive or listing View.
- Bound the dropdown to the last 30 and next 15 years using the default relative range.
- Restrict the dropdown to a fixed span (e.g. `2000` to `2025`) with specific years.
- Use a relative `year_from`/`year_to` so the range rolls forward automatically each year.
- Present years newest-first by setting the sort order to descending.
- Allow visitors to select multiple years at once (ManyToOne multi-select).
- Offer "is one of" / "is not one of" operators on the year filter.
- Combine the exposed year dropdown with other exposed filters on the same View.
- Provide a friendlier year filter UX for editorial/archive browsing.
- Drive a yearly news or events archive page from the dropdown filter.
- Keep exposed-filter option lists short and valid instead of every possible integer.
- Filter a publications listing by publication year via the dropdown.
- Build a "browse by year" facet on a content archive View.
- Reuse the same filter across multiple Views that expose a year field.
- Constrain the dropdown to only years present in the content model.
- Avoid invalid free-text year input from site visitors.
- Pair the year dropdown with a taxonomy or type exposed filter.
