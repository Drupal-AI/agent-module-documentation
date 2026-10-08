<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fixes the summary label for boolean filters that Better Exposed Filters renders as a single checkbox.

---

This submodule implements `hook_views_filters_summary_filter_value_label_alter()`. When a boolean filter is exposed via Better Exposed Filters as a single checkbox (`bef_single`), it replaces the raw value with the filter's exposed label when checked (and suppresses it when unchecked), so the summary reads the human label instead of `1`/`0`. Requires the Better Exposed Filters module.

---

- Show a BEF single-checkbox boolean filter's label in the summary instead of 1/0.
- Hide an unchecked BEF single-checkbox filter from the summary.
- Improve readability of boolean facets rendered by Better Exposed Filters.
- Combine BEF widgets with a readable active-filters summary.
- Enhance the Views Exposed Filters Summary area so it displays this module's filter type correctly.
- Enable it alongside the parent views_filters_summary area on a header/footer of a view.
- Keep the active-filters summary readable when using this companion module.
- Add per-value remove links to the summary for the supported filter type.
- Combine with the summary's reset-all link for a full faceted-results bar.
- Show a 'Displaying N results for ...' line that understands this filter type.
- Group multi-value selections of the supported filter under one label.
- Avoid writing your own alter-hook glue to support this filter in the summary.
- Turn raw filter ids/values into human-readable labels in the summary.
- Drop it in as an optional submodule only when you use the companion module.
- Enhance the Views Exposed Filters Summary area so it displays this module's filter type correctly.
- Enable it alongside the parent views_filters_summary area on a header/footer of a view.
