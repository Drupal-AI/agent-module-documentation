<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders the referenced entity's label in the summary for a core entity_reference exposed filter.

---

This submodule implements `hook_views_filters_summary_filter_value_label_alter()`. For an `entity_reference` filter it loads the referenced entity (using the filter's target entity type) and replaces the value label with the entity's label, so the summary shows the referenced entity name instead of its id. Requires the Views Core Entity Reference module.

---

- Show a referenced entity's label in the summary for an entity_reference filter.
- Resolve core entity_reference filter ids to entity labels.
- Build a readable summary for a Views Core Entity Reference exposed filter.
- Display the selected referenced entity name on a filtered view.
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
