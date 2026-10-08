<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Accessibility improvements for the Views Filters Summary remove links: it rewrites each remove-`X` link with screen-reader-friendly markup and adds an accessibility stylesheet.

---

This submodule implements `hook_views_filters_summary_item_alter()` to replace each summary item's remove-link title with three spans: an `aria-hidden` label (the value), a `visually-hidden` aria label ("Clear <value>"), and an `aria-hidden` "X" remove button. It also overrides the `views_filters_summary_item` and `views_filters_summary_items` templates and, via `hook_library_info_alter()`, appends its `views-filters-summary-a11y.css` stylesheet to the parent `views_filters_summary/views_filters_summary` library. It needs only the parent module (no third-party filter module).

---

- Make the summary's remove-filter links understandable to screen-reader users.
- Expose a hidden "Clear <value>" aria-label on each remove link.
- Hide the decorative "X" from assistive technology with aria-hidden.
- Add accessibility CSS to the Views Filters Summary output automatically.
- Improve WCAG compliance of a faceted-results summary bar.
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
