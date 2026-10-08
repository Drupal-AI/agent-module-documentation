<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Table Filter relocates a Views table display's exposed filters into their corresponding table-header columns, giving an in-table filtering UI.

---

It works purely through form alters and preprocessing — no routes, permissions, services or config entities of its own. On the Views UI display edit form it adds, per exposed filter that maps to a table column (and only when the display uses the Better Exposed Filters exposed-form plugin and a table style), a "Move filter to the table column" select under that filter's BEF advanced settings. At render time (`hook_preprocess_views_view_table`) it reads those BEF advanced `table_filter` assignments, appends a placeholder `<div class="table-header-filter-...">` into the chosen header cell, and passes a filter→identifier map to `drupalSettings`. The bundled JS (`views_table_filter.core`) then clones each real exposed-filter widget into its header cell and syncs value/keyup changes back to the hidden original filter form.

Because it depends on and configures Better Exposed Filters, it requires both `views` and `better_exposed_filters`. It handles no user-supplied request data server-side (all logic is over view configuration set by site builders) and adds no anonymous or mutating endpoints; the column class is passed through `Html::cleanCssIdentifier()`. Typical setup: build a Views table display with exposed filters, enable Better Exposed Filters for the exposed form, then per filter choose the table column to move it into. No security findings.

---

- Show an exposed filter widget inside its matching table column header.
- Give a data table a spreadsheet-like in-header filtering UI.
- Assign each exposed filter to a specific table column.
- Leave a filter in the standard exposed form by choosing '_none'.
- Filter a text column by typing directly in its header.
- Filter a select/taxonomy column from a header dropdown.
- Filter a date column via a header date widget.
- Keep the original exposed form working (widgets are cloned and synced).
- Configure everything from the Views UI, no code.
- Combine with Better Exposed Filters advanced settings per filter.
- Apply to any Views table-style display with exposed filters.
- Sync header widget changes back to the real filter on change/keyup.
- Build compact admin listings where filters sit in the header row.
- Improve UX of large tabular reports.
- Reuse across multiple table displays in a view.
- Avoid a separate filter sidebar for tabular data.
