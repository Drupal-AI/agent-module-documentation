<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Makes the summary's remove/reset links target the correct DOM form when a view's exposed filters are embedded inside an Entity Browser.

---

This submodule implements `hook_views_filters_summary_exposed_form_id_alter()`. In an Entity Browser display the view's exposed filters live inside the browser's own `<form id="entity-browser-...">` rather than a standalone `views-exposed-form-...`, so it rewrites the exposed form id prefix to `entity-browser-` so the summary's client-side remove/reset links find the form. Requires the Entity Browser module.

---

- Use a filters summary inside an Entity Browser view display.
- Point remove/reset links at the Entity Browser form instead of a standalone exposed form.
- Support entity-selection browsers that embed a view's exposed filters.
- Fix summary links that would otherwise miss the Entity Browser form id.
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
