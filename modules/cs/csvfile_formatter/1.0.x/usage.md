<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CSV File Formatter adds a **"CSV file as table"** display format to core **file fields**: when an entity is viewed, it reads the uploaded CSV with PHP's `fgetcsv` and renders the parsed rows as an HTML table (Drupal's `#theme => 'table'`) on the page, instead of only offering a download link.

---

The module is a single field formatter (`CSVFileFormatter`, plugin id `csvfile_formatter`) attached to core's **file** field type. On display it takes each referenced file, resolves its real path from the managed-file URI, opens it with `fopen`, and walks it line by line with `fgetcsv($handle, 0, $separator, $enclosure, $escape)` — so parsing is standard PHP CSV parsing, configured per view-display. The separator, enclosure and escape characters are formatter settings (defaults `,` `"` `\`; the literal string `\t` in the separator field is translated to a real tab so tab-separated files work). If **"CSV file has header row"** is on, the first row is read into `#header` as `<th>` cells and the rest become `#rows`; otherwise every line is a data row. Optional per-table, per-header and per-row **CSS classes** are attached, headers can be made **sticky** (`#sticky`), and each table is given an `id` of `{field}-{n}-csvfiletable`. **"Process files as UTF-8 content"** runs each cell through `mb_convert_encoding(..., 'UTF-8', mb_list_encodings())`. **"Smart URL handling"** post-processes each cell: values that pass `FILTER_VALIDATE_URL` or `FILTER_VALIDATE_EMAIL`, or that match a simple `[text](url)` Markdown pattern, are turned into Drupal links (`Link::fromTextAndUrl`), including in-page `#anchor` fragments. Cell values are placed into the table render array's `data` keys and are therefore **escaped by the table theme** — raw HTML such as `<script>` in a cell is shown as literal text, not executed. A **download link** to the original file (`#theme => 'file_link'`) can be shown before or after the table, or suppressed. Finally, **"Use DataTables"** tags the table with `add-externaljs-csvfiletable` and attaches the module's behavior plus the DataTables 2.2.2 library (from `cdn.datatables.net` or from locally installed `/libraries` files), driven by site-wide options — paging, searching, ordering, `pageLength`, `scrollX`/`scrollY`, etc. — set at **Configuration → Media → DataTables settings** (`/admin/config/csvfile_formatter/data-tables-settings`, permission `administer site configuration`, stored in `csvfile_formatter.settings`). The formatter has no field type, no widget and no permissions of its own; it only changes how an existing file field is *displayed*.

---

- Render an uploaded CSV file as an HTML table on a node instead of a download link.
- Publish a results / price / rates table that an editor maintains as a spreadsheet.
- Show a timetable, rota or schedule kept in a CSV file.
- Publish a monthly statistics or open-data release inline.
- Display a directory, register or fixtures list from a spreadsheet export.
- Avoid a migration for tabular data that changes often — the editor just re-uploads the file.
- Parse a semicolon-separated (European locale) export by setting the separator to `;`.
- Render a tab-separated file by entering `\t` as the separator.
- Treat the first CSV row as a header of `<th>` cells.
- Add Bootstrap / theme CSS classes to the generated table, its header and its rows.
- Make column headers sticky on long tables.
- Show the original CSV download link before or after the rendered table.
- Fix mojibake from mixed-encoding exports with the UTF-8 processing option.
- Turn URL and email cells into clickable links (smart URL handling).
- Turn `[label](https://…)` Markdown cells into links, including in-page `#anchor` links.
- Add client-side sorting, searching and pagination to a large table via DataTables.
- Enable horizontal / vertical scrolling on wide or tall tables through DataTables settings.
- Serve DataTables from a CDN with no local install, or from locally bundled library files for an offline / locked-down site.
- Give each rendered table a stable `id` for CSS or JS targeting.
- Provide the same tabular view across many nodes without hand-building tables in a WYSIWYG.
- Let non-technical publishers update tabular content by editing a spreadsheet and re-uploading.
