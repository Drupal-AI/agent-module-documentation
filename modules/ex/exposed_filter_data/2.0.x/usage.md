<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a block that prints the current View's exposed-filter values (taken from the URL query string) as a themed "Filtered by:" summary.

---

Exposed Filter Data is a lightweight display helper for Views. It ships one block plugin, "Exposed Filters Data"
(`exposed_filters_data_block`), whose `build()` reads all query-string parameters of the current request
(`request_stack` → `query->all()`) and passes them to the `exposed_filter_data_block` theme hook. The bundled
template (`templates/block--exposed_filter_data.html.twig`) renders each parameter as a `name: value` row under a
"Filtered by:" heading and adds a "Clear Filters" button, styled by the module's small CSS library. The block only
outputs when there are query parameters, and its cache max-age is 0 so it always matches the current URL. Because it
reads raw query keys/values, it is normally placed inside the View whose exposed filters it should describe — most
easily in the View header via the Views Block Area module. Raw machine parameter names and values can be rewritten or
relabelled (e.g. mapping `status=1` to `Status: Published`) by implementing `hook_exposed_filter_data_params_alter()`
(see `exposed_filter_data.api.php`). The module has no settings form, routes, permissions, services or config.

---

- Show site visitors which exposed-filter values produced the current Views result set.
- Place a "Filtered by:" summary in a View's header when its exposed filters are in a separate block.
- Reflect the current search/filter query string back to users as human-readable text.
- Pair with the Views Block Area module to drop the block into a View header instead of a page region.
- Display active category, status, or date filters above a listing of results.
- Give users context on a filtered listing page reached via a bookmarked or shared URL.
- Confirm to users that a filter was applied (and with what value) after they submit an exposed filter form.
- Add a one-click "Clear Filters" control alongside the filter summary.
- Relabel raw filter machine names to friendly labels via `hook_exposed_filter_data_params_alter()`.
- Map coded filter values (e.g. `status=1`/`2`) to readable words (Published / Not Published) before display.
- Hide internal or pager query parameters from the summary by unsetting them in the alter hook.
- Combine several query parameters into a single readable phrase for display.
- Provide filter context for search-results or faceted-listing pages built on Views.
- Style the "Filtered by:" output with the module's CSS or override it in your theme.
- Override the summary markup entirely by supplying a `block--exposed_filter_data.html.twig` template in your theme.
- Ensure the summary always matches the current URL (block is uncacheable, max-age 0).
- Support both Drupal 10 and Drupal 11 sites that need an exposed-filter readout block.
- Improve accessibility/clarity of filtered pages by naming the active filters in the content area.
- Let editors add the summary to a View without writing custom code (only the block placement is required).
- Display filter context on catalog, directory, event, or listing pages driven by Views exposed filters.
