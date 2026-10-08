<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds JavaScript so the Views Filters Summary remove/reset links work when the exposed filters are rendered in a Configurable Views Filter Block.

---

This submodule implements `hook_library_info_alter()` to append its `views-filters-summary-cvfb.js` script to the parent `views_filters_summary/views_filters_summary` library, adapting the summary's client-side behaviour to the Configurable Views Filter Block module (where the exposed form is rendered in a separate block). Requires the Configurable Views Filter Block module.

---

- Make summary remove/reset links target an exposed form rendered in a separate block.
- Integrate Views Filters Summary with Configurable Views Filter Block.
- Add CVFB-specific JavaScript to the summary library automatically.
- Support a decoupled exposed-filters block alongside a results summary.
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
