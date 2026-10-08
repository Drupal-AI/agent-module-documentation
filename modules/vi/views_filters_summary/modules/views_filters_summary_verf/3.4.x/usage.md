<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders referenced entity labels in the summary for the Views Entity Reference Filter (VERF) filter.

---

This submodule implements `hook_views_filters_summary_info_alter()`. For the `verf` filter it reads the filter's `verf_target_entity_type_id`, loads each selected referenced entity, and sets the summary values to their labels, so the summary shows readable entity names. Requires the Views Entity Reference Filter (verf) module.

---

- Show referenced entity labels in the summary for a VERF filter.
- Resolve verf filter values to their target-entity labels.
- Build a readable summary of a Views Entity Reference Filter exposed filter.
- Display selected referenced entities on a filtered listing.
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
