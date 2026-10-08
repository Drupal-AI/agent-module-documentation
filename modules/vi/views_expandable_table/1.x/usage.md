<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Expandable Table adds a Views table style plugin whose last column is hidden by default and expands into a full-width detail row when the row (or a toggle element) is clicked.

---

The module provides one Views style plugin, "Expandable Table" (id `views_view_expandabletable`), extending core's Table style. It behaves like the standard Views table for all but the last configured column: that final column is pulled out of the row and rendered as a second `<td colspan>` row that JavaScript hides until the row is triggered. You choose whether the entire row is the trigger (default) or a small toggle element is appended to the first/last visible column, and whether that element sits before or after the cell content. It attaches a small jQuery/`core/once` behavior plus CSS with up/down arrow icons; the expandable content is ordinary Views field output, so field access and rendering are handled by Views exactly as in the normal table style. There is no admin settings page, no permissions, and no config schema of its own — all options live in the view's display configuration.

---

- Show a compact table where each row expands to reveal extra fields on click.
- Present dense entity listings with only key columns visible initially.
- Put a long description, body, or teaser into an expandable detail row.
- Build a FAQ-style list of rows that open to show an answer field.
- Display product rows that expand to show specs, images, or long text.
- Keep a wide report readable by hiding secondary columns until needed.
- Reveal on-demand detail without a modal, second view, or AJAX round-trip.
- Use the whole row as the click target (default `triggerable_row`).
- Instead append a dedicated toggle icon to the last visible column of each row.
- Move that toggle icon to the first visible column when the layout calls for it.
- Position the toggle element before or after the cell's existing content.
- Coexist with Views Bulk Operations: the toggle auto-shifts off the bulk-form column.
- Let editors click links, buttons, or inputs inside a trigger row without toggling it.
- Target `tr[data-views-expandable-table-trigger]` / `tr[data-views-expandable-table-target]` in theme CSS.
- Style the open state via the `expanded` class added to both trigger and target rows.
- Style hover via the `views-expandable-table-hover` class added to both rows.
- Adjust zebra-striping CSS to account for the extra detail row in the markup.
- Provide an accordion-like data grid using standard Views without custom code.
- Reuse all standard Views table features (sorting, sticky header, grouping) on the visible columns.
- Render the detail row with the same field access as any other Views output.
- Apply to any Views display type ("normal") on Drupal 9.2, 10, or 11.
- Swap an existing table display to the expandable style with no data changes.
- Ship a self-contained expand/collapse UX (jQuery + `core/once`) with no external libraries.
