<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders selected option labels in the summary for Views Selective Filters' Selective filter.

---

This submodule implements `hook_views_filters_summary_info_alter()`. For a Views Selective Filters `Selective` filter it maps each selected value to its option label (from the filter's value options) and sets the summary values accordingly, so the summary shows readable labels for selective filters. Requires the Views Selective Filters module.

---

- Show selected option labels in the summary for a Views Selective Filters filter.
- Resolve Selective filter values to their option labels.
- Build a readable summary for a selective (dynamically-limited) exposed filter.
- Display active selective-filter choices on a filtered view.
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
