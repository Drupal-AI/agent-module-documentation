<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Data Export phpspreadsheet adds an "Xlsx export" Views style plus an `xls`/`xlsx`/`ods` serialization encoder (backed by PhpSpreadsheet) to the Views Data Export module, so a Data Export view can produce real Excel/OpenDocument spreadsheets with headers, footers, per-column colours, metadata and embedded images.

---

The module registers an encoder service (`XlsEncoder`, format `xls`, also handling `xlsx`/`ods`/`gnumeric`) and a request subscriber (`XlsSubscriber`) that maps the spreadsheet MIME types onto request formats. Its `xls_data_export` Views style extends Views Data Export's `DataExport`, adding the `xls`/`xlsx`/`ods` formats and an **xlsx Settings** options group: a print **header** and **footer** (each a `text_format` supporting Views/Token replacement and `;`-separated multi-column values, footers may include page numbers or spreadsheet formulas like `=sum(D:D)`), a per-field **Color column** picker, a **Row Color** list (colour only specific row numbers), and document **metadata** (creator, title, subject, etc.). At encode time `XlsEncoder::encode` builds a `Spreadsheet`: it collects the view's non-excluded fields as the header row, applies column background colours and auto-size, merges/bolds the print header, writes each data row (stripping tags and decoding entities via `formatValue`), converts `<a href>`/URL cell values into real hyperlinks, and — for fields whose config type is `image` — extracts the `<img src>`, validates the extension against an allow-list (`png/jpg/jpge/bmp/gif`), resolves it to a path under the app root and embeds the picture with `getImgSrc`/PhpSpreadsheet `Drawing`. In a Views live preview it falls back to CSV. Two invoke-all hooks (`xls_encoder_header_alignment`, `xls_encoder_data`) let other modules mutate the worksheet. There is no configuration page or permission of its own; it inherits Views Data Export's export/download route and access. Requires the `phpoffice/phpspreadsheet` library via Composer.

---

- Export a View as a downloadable `.xlsx` Excel file.
- Export a View as OpenDocument (`.ods`) or legacy `.xls`.
- Add a bold, merged print header row above the data.
- Add a footer line, optionally with "Page X of Y" pagination.
- Insert a spreadsheet formula (e.g. `=sum(D:D)`) into the footer.
- Colour individual columns by picking a colour per field.
- Colour only specific row numbers rather than whole columns.
- Set document metadata (creator, title, subject, keywords, company) on the file.
- Auto-size columns to fit their content.
- Turn linked field values into clickable hyperlinks in the spreadsheet.
- Embed an image field's picture directly into a cell (one image per field).
- Name the worksheet from the View's title.
- Provide multi-column headers/footers using `;`-separated values.
- Use Token/Views replacement in header and footer text.
- Offer editors a spreadsheet export alongside CSV on the same Data Export display.
- Support batched/paged exports of large result sets.
- Fall back to CSV output in the Views preview for quick checks.
- Let other modules adjust worksheet styling via `xls_encoder_header_alignment` / `xls_encoder_data`.
- Deliver reports to non-technical stakeholders in native Excel format.
- Export product, order or membership lists for offline analysis.
- Produce branded, colour-coded spreadsheets matching a client's palette.
- Read/import supported spreadsheet formats through the encoder's decode path.
