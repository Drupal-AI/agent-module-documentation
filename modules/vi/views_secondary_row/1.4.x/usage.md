<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Secondary Row adds a Views table format ("Table with fields in secondary row") that lets you push selected fields off the main row onto a second, full-width row beneath it — so a table with too many columns stays readable instead of scrolling sideways.

---

Core Views' Table style puts every field in its own column, and a listing with a dozen fields produces a table wider than any screen. This module ships a style plugin (`views_secondary_row_table`) that subclasses core's `Table` style and adds four per-field settings in the Views UI **Format → Table with fields in secondary row → Settings** grid: **Secondary row** (the target column a field should drop into on the second row), **2nd row Separator**, **2nd row Colspan**, and **1st row Rowspan**. When a field's "Secondary row" is set to another column, that field is rendered in an extra row below the primary one (keyed to the chosen column) and its header label is omitted, so the header only shows the primary-row columns. Internally the preprocess doubles the row list — primary rows at even indexes, secondary rows at odd indexes — then re-sorts and drops any secondary row with no content (adding `views-secondary-row--no-content hidden`). Everything else (sorting, alignment, sticky header, responsive priority classes, caption, empty text) is inherited from core's table style. It ships two Twig templates and a `theme.inc` preprocess, both close copies of core's Views table code; there are no routes, permissions, config entities or config schema. Field output is produced by Views' normal field render pipeline, so the same escaping rules as core's table apply. Note that changing table semantics affects accessibility — verify header/`colspan` associations read correctly with a screen reader.

---

- Keep a wide Views table readable without horizontal scrolling.
- Move less-important fields onto a full-width second row.
- Show a node's description/excerpt beneath its title row.
- Put "Edit"/"Delete" operation links on a secondary row under the item.
- Show metadata (author, date, tags) below the main row.
- Build an admin content listing with many fields that still fits on screen.
- Group several columns into one wrapped secondary row via `colspan`.
- Keep the important fields on the primary row and hide their header labels for secondary fields.
- Make a primary-row cell span both rows with the "1st row Rowspan" option.
- Add a separator string before a field placed in the secondary row.
- Improve a report or data table on tablet and mobile widths.
- Build a search-results table with a snippet under each title.
- Lay out a product-comparison table more compactly.
- Convert an existing Table display to two-row layout without recreating fields.
- Preserve click-sort, alignment and responsive classes from core's table style.
- Theme the two-row output by overriding `views-secondary-row-view-table.html.twig`.
- Style the secondary row separately with the `views-secondary-row--no-content` / row classes.
- Show tags or a taxonomy list beneath a content row.
- Avoid writing a bespoke per-view Twig template just to wrap columns.
- Keep all fields visible instead of dropping columns to save width.
- Support a legacy site still on Drupal 8/9 (core requirement `^8 || ^9 || ^10 || ^11`).
- Revert to a plain table by switching the display Format back to "Table".
