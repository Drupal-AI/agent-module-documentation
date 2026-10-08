<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs table provides a field **formatter** and a field **widget** for Paragraphs reference fields that display and edit multi-value paragraphs as a spreadsheet-style table (one paragraph per row, sub-fields as columns) instead of stacked forms.

---

It targets `entity_reference_revisions` fields (i.e. Paragraphs reference fields). The **formatter** `paragraphs_table_formatter` renders referenced paragraphs as an HTML table — horizontal (row per paragraph) or `vertical`, with an optional table `mode` layering in the DataTables, Bootstrap Table, or Google Charts JS libraries, a caption, a numbering column, empty-column hiding, AJAX loading, and per-row operations (edit/duplicate/delete via `/paragraphs_item/*` routes). A second formatter `paragraphs_table_json_formatter` outputs the paragraphs as JSON (configurable `recursion_level`). The **widget** `paragraphs_table_widget` (extending the core Paragraphs widget) lets editors fill paragraphs in a compact table, optionally vertical, with paste-from-clipboard, "show all" rows, a reference-search helper, and feature toggles (e.g. duplicate). Settings for each plugin are stored on the entity view/form display (`field.formatter.settings.paragraphs_table_formatter`, `field.widget.settings.paragraphs_table_widget`, `field.formatter.settings.paragraphs_table_json_formatter`). It adds a permission `administer paragraphs_item fields`, ships routes and controllers for adding/editing/cloning/deleting individual paragraph items (including JSON/AJAX endpoints), and works well with Display Suite and Field Permissions. It requires the Paragraphs module and defines no plugin types of its own.

---

- Display a repeatable "team members" paragraph field as a table of name/role/photo columns.
- Let editors enter tabular data (e.g. price rows, specifications) in a spreadsheet-like grid.
- Show a vertical table when a paragraph has many fields better read top-to-bottom.
- Turn a paragraphs field into an interactive DataTable with sorting and search.
- Render paragraphs with Bootstrap Table styling for responsive, exportable tables.
- Visualize numeric paragraph data as a Google Chart (bar, pie, line, …).
- Paste rows straight from a spreadsheet into the paragraphs table widget (paste from clipboard).
- Add a numbered column to a displayed paragraphs table.
- Hide empty columns so sparse tabular data stays compact.
- Load a large paragraphs table via AJAX for better performance.
- Provide inline edit / duplicate / delete operations per paragraph row.
- Output a paragraphs field as JSON for a decoupled front end (json formatter).
- Replicate the old Field Collection Table editing/display experience with Paragraphs.
- Give content editors a compact grid instead of dozens of stacked paragraph forms.
- Add a caption to a paragraphs table for accessibility/context.
- Reference and search existing entities from within the table widget.
- Apply a custom CSS class to the rendered table for theming.
- Enable a "duplicate row" shortcut in the editing table via widget features.
- Show all rows at once in the widget rather than paginated add-more.
- Integrate tabular paragraphs into a Display Suite layout.
- Control column visibility/access with the Field Permissions module.
- Manage individual paragraph items through dedicated `/paragraphs_item/*` add/edit/clone/delete pages.
- Sum numeric columns / add footer text in the displayed table.
- Build comparison tables (e.g. plan features) from a paragraphs field.
