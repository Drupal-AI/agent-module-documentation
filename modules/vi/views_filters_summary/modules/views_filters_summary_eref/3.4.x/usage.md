<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Renders node titles in the summary for the Entity Reference Exposed Filters (EREF) node-titles filter.

---

This submodule implements `hook_views_filters_summary_info_alter()`. For the EREF `eref_node_titles` filter it loads each referenced node by id and sets the summary value to the node's title (label), so the summary shows readable node titles instead of node ids. Requires the Entity Reference Exposed Filters module.

---

- Show referenced node titles in a filters summary for an EREF filter.
- Resolve eref_node_titles filter node ids to node labels.
- Build a readable summary of an entity-reference-by-title exposed filter.
- Display selected referenced content on a filtered listing view.
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
