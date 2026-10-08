<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blizz Table Field adds a "table" field type edited in a spreadsheet-like Handsontable grid, storing the rows/columns as JSON or CSV and rendering them as an HTML table.

---

Blizz Table Field provides a single Drupal field type (`table`) whose value is a serialized grid of
cells, stored either as a JSON array-of-arrays or as CSV text (chosen per field in the field storage
settings). Editors fill the grid in a spreadsheet-like Handsontable widget (`table_widget`) — inserting
rows/columns, setting read-only rows/columns, and pasting data — and the module serializes the grid into
the field's single `value` text column. On display, the `table_formatter` renders the stored data as a
core `#type => 'table'` render element: the first row is optionally used as the header, and each cell is
run through the module's Markdown pipeline (League CommonMark, with raw HTML stripped) so authors write
Markdown — not HTML — for emphasis, links, lists, alignment (`^c`/`^r`/`^l`), and references to Media
entities for images/file links. A "skip rendering markdown" option outputs the raw cell text instead.
The formatter also targets JSON fields from the contrib JSON Field module. A single admin settings form
(`/admin/config/content/blizz_table_field/settings`) configures the Handsontable license key, the paths
to the Handsontable/PapaParse library files, and the help text shown under the widget's "Formatting
options". The module depends on core Field, File, Filter and Image, and requires the Handsontable and
PapaParse JavaScript libraries plus `league/commonmark` (installed via Composer / asset-packagist).

---

- Store an editable data table on any fieldable entity (node, term, media, block, paragraph).
- Give editors a familiar spreadsheet grid instead of hand-written HTML markup.
- Build product specification or comparison tables that non-technical editors maintain.
- Present schedules, timetables, price lists, or opening-hours tables.
- Author cell content in Markdown (bold, emphasis, lists, links) rather than raw HTML.
- Insert and remove rows and columns interactively while editing.
- Lock a number of leading rows and/or columns as read-only headers.
- Restrict which grid operations editors may use (insert/remove row/column, undo/redo, cut/copy).
- Store table data as JSON (default) or as CSV text, chosen per field.
- Reuse the formatter on native JSON fields provided by the JSON Field contrib module.
- Show or hide the table header row on display via the formatter.
- Add custom CSS classes to the rendered table for theming.
- Center-, left-, or right-align individual cells with `^c`/`^r`/`^l` prefixes.
- Reference a Media entity by ID inside a cell to render an image at a chosen image style.
- Reference a Media entity by ID inside a cell to render a download link to its file.
- Automatically linkify bare URLs in cell text and open links in a new tab.
- Paste tabular data from Excel/Sheets straight into the grid.
- Provide a placeholder hint and configurable minimum rows/columns per widget.
- Turn off Markdown rendering to output cell text verbatim when needed.
- Configure the Handsontable commercial license key site-wide for non-evaluation use.
- Point the module at custom Handsontable/PapaParse library file paths.
- Provide contextual "Formatting options" help under the editing grid.
