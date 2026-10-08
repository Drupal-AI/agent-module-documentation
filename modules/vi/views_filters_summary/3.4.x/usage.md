<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Exposed Filters Summary provides a Views area handler that prints a human-readable summary of the exposed filters a visitor has currently applied ("Displaying 12 results for Red, Large"), with optional per-filter remove links and a reset-all link.

---

The module registers a single Views **area handler** plugin, `views_filters_summary` (class `ViewsFiltersSummary`, extending core's `Result` area), exposed through `hook_views_data`. You add it to a view's **Header**, **Footer**, or **No results** area, and it renders a configurable `content` string with the tokens `@total`, `@result_label`, and `@exposed_filter_summary`. The summary lists each active exposed filter's value (resolving taxonomy terms, entity bundles, usernames, list options, boolean labels, and between/operator ranges to readable text), optionally with labels, grouped multi-value output, a small remove-`X` link per value, and a reset link — the latter two wired up by a JS/CSS library that manipulates the exposed form client-side (AJAX-aware). Many display aspects are adjustable per view: `filters` (which exposed filters to include), `show_labels`, `group_values`, `show_remove_link`, `show_reset_link`, `filters_reset_link_title`, `filters_summary_prefix`, `filters_summary_separator`, and singular/plural `filters_result_label`. It is highly extensible: a family of alter hooks (`hook_views_filters_summary_info_alter`, `_replacements_alter`, `_item_alter`, `_filter_value_alter`, `_filter_value_label_alter`, `_plugin_alias`, `_valid_index`, `_exposed_form_id_alter`) let other modules teach it about custom filter plugins — which is exactly what its eleven optional submodules do for Address, Better Exposed Filters, Commerce, Search API, Entity Browser, and more.

---

- Show "Displaying N results for <active filters>" in a view's header or footer.
- Give users a clear read-out of which exposed filters are currently applied.
- Add a one-click remove-`X` link next to each active filter value.
- Add a "Reset" link that clears all applied exposed filters at once.
- Summarize only selected filters (e.g. show Category and Price but not Sort).
- Display filter labels alongside values (e.g. "Color: Red").
- Group a multi-value filter's selections under a single label.
- Customize the separator between summary items (comma, slash, etc.).
- Add a prefix like "for " before the filter list.
- Set singular/plural result nouns ("1 product" / "12 products").
- Resolve taxonomy term IDs to translated term names in the summary.
- Resolve entity bundle machine names to bundle labels.
- Resolve user IDs to display names for a user_name filter.
- Show readable labels for list_field / options filters.
- Render operator-aware phrasing ("Greater than 100", "Not Red", "Contains foo").
- Show min–max range text for between/not-between numeric or date filters.
- Make the summary AJAX-aware so it updates with an AJAX-enabled view.
- Integrate the summary with Better Exposed Filters single-checkbox labels (bef submodule).
- Support Address module administrative-area filters (address submodule).
- Support Commerce entity-bundle filters (commerce submodule).
- Summarize Search API fulltext and term/options facets (search_api submodule).
- Work inside an Entity Browser embed by adjusting the exposed form ID (eb submodule).
- Add accessible remove-link markup for screen readers (a11y submodule).
- Teach the summary about custom filter plugins via `hook_views_filters_summary_plugin_alias`.
- Alter a specific filter's displayed value/label via the provided alter hooks.
- Add extra replacement tokens to the summary content via `_replacements_alter`.
- Provide a faceted-search-style "active filters" bar without a facets module.
