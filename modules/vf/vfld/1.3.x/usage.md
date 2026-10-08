<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Filter Last Delta (vfld) adds a Views filter that restricts a view to rows holding the last delta (the last-entered value) of a multi-value field.

---

Multi-value fields store an ordered list, and often only the last entry matters — the latest status, the most recent note. Views can show all values on one row or one value per row, but it cannot easily keep just the last one. vfld solves this by registering a filter in a **Last Delta** category for every multi-value field Views exposes a delta on. To use it: add the multi-value field to your view, untick **"Display all values in the same row"** in that field's settings (so each delta becomes its own row), then add a filter, pick the `… (last)` entry under **Last Delta**, and set it to **Yes**. Under the hood the filter adds a `WHERE delta IN (SELECT MAX(delta) …) OR delta IS NULL` condition keyed on the base entity id, so each entity keeps only its last-delta row. It is a pure query convenience with no settings page, no permissions, and no security surface — it only narrows what the view already exposes. Note that "last delta" means the highest delta (append order), so confirm that matches "most recent" for your data.

---

- Show only the last value of a multi-value field in a view.
- Filter a view to the last delta of a field.
- Keep just the most recent entry per entity.
- Display the latest status from a multi-value status field.
- Reduce a multi-row multi-value listing to one row.
- Add a "Last Delta" filter to an entity view.
- Untick "Display all values in the same row" then filter last delta.
- Expose a Yes/No last-delta filter to site visitors.
- Set the filter value to Yes to activate last-delta filtering.
- Build a "latest note per node" listing.
- Show the last delta of a paragraphs/field collection reference.
- Filter revisions or field-data tables by max delta.
- Keep last-delta filtering off by leaving the filter at No.
- Combine last-delta with other Views filters and sorts.
- Use the filter in a grouped filter set.
- Confirm delta ordering matches chronological order.
- Preserve rows with no delta (NULL) alongside last-delta rows.
- Document which field the filter targets in the view.
- Test the view output before deploying to production.
- Verify Views is enabled as the only dependency.
- Restrict who can administer views that use the filter.
- Match the filter to your specific reporting use case.
