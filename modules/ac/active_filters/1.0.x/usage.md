Active Filters adds a Views **area** handler that renders the currently-selected exposed filter values as a list of "active filter" chips, which visitors can clear individually or all at once (via JavaScript that unsets the matching exposed-filter input and resubmits the form).

---

Enable the module and add **Active Filters** to a view's Header or Footer area (`views.area.active_filters`). The area reads the view's exposed input plus default exposed values, matches each against the display's exposed filter handlers, and builds a value object per active value. Per-area options control the heading text (and whether it is visually hidden), whether filters are **grouped** by their exposed filter, and the "clear all" button text. Per-exposed-filter options let you enable/disable active-filter generation, make values removable, and **rewrite** displayed values with a `Current|Replacement` line list (an empty replacement suppresses that value). Output is fully themeable via four theme hooks (`active_filters`, `active_filters_grouped`, `active_filter`, `active_filter_group`) with granular theme suggestions per view/display/filter/value, and each chip carries `data-active-filter-*` attributes the shipped JS uses to remove it. Values are emitted through Twig autoescaping and `Attribute` objects (no raw markup). A `hook_active_filters_alter()` lets code rewrite or replace filter objects before rendering. Removal supports checkboxes, radios, single/multiple selects, and text inputs, plus a custom `activeFilterRemove` hook on any input element for JS-driven widgets.

---

- Show visitors which exposed filters are currently applied to a view.
- Let users remove a single applied filter by clicking its chip (auto-resubmits the view).
- Add a "Clear all filters" button that resets every removable active filter at once.
- Group active filters under their exposed-filter label (e.g. "Category: News, Events").
- Provide a search/listing page with faceted-style filter chips without a facets module.
- Rewrite raw filter values for display (e.g. `1|Yes`, `0|No`) without changing the exposed form.
- Hide specific values from the active-filter list by leaving the rewrite replacement blank.
- Collapse a boolean exposed filter to a single meaningful chip (e.g. show only "On").
- Give the active-filters block an accessible, visually-hidden heading.
- Prevent a required exposed filter from being removable when it is the only value.
- Theme active-filter chips per view or per display using the generated theme suggestions.
- Theme a specific filter's or value's chip (e.g. style a "sale" value differently).
- Keep filter chips working with JS-enhanced widgets by implementing `activeFilterRemove`.
- Alter or relabel active filters programmatically with `hook_active_filters_alter()`.
- Add contextual "you searched for…" summaries above a listing.
- Reuse the same active-filters styling across many views via the minimal shipped CSS.
- Disable active-filter generation for a noisy exposed filter while keeping others.
- Support single and multi-value exposed selects, checkboxes, radios, and text fields.
- Improve UX on mobile listing pages with tap-to-remove filter chips.
