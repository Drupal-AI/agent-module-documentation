<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Teaches Views Filters Summary how to render the Address module's administrative-area (state/province) exposed filter.

---

This submodule implements `hook_views_filters_summary_plugin_alias()` to alias the Address module's `administrative_area` filter plugin to the built-in `list_field` handling, so its selected values are resolved to readable labels in the summary. It also implements `hook_views_filters_summary_valid_index()` to accept the string array indices that administrative-area filters use (e.g. `['AL' => 'AL']`). Requires the Address module.

---

- Show selected states/provinces in a filters summary for an Address-based view.
- Resolve administrative_area filter values to readable labels.
- Accept string-keyed option arrays from the Address administrative-area filter.
- Build a location-faceted results summary using Address exposed filters.
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
