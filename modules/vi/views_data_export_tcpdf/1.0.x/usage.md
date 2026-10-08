<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Views Data Export extends the Views Data Export module with a `pdf` output format rendered by the TCPDF library, so a Data Export display can produce a styled PDF table of the view results.

---

It registers a serializer encoder for the `pdf` format (`src/Encoder/Pdf.php`). The encoder builds an HTML table from the view rows — every header and cell value is passed through `strip_tags()` and `Html::escape()` — then feeds that markup to a `CustomPdf` (a TCPDF subclass) via `writeHTML()` and returns the document as a string. `pdf_settings` on the style plugin drive metadata (creator/title/subject/keywords), an optional header (title, subtitle, contact line, address, notes, and a logo taken from a Drupal file entity by fid), and a three-cell footer with page numbers. The logo is resolved to a local filesystem path from a managed file entity — no remote URL is fetched. The module also overrides the `data_export` display plugin, ships a `PdfExportForm` for optionally uploading/merging an existing PDF, an `ExportRedirectSubscriber`, and a JS auto-download helper. TCPDF must be installed in the site's `libraries/` directory.

Because export runs through a Views Data Export display, access is governed by that display's own access plugin (set it appropriately). Cell content is escaped and stripped before reaching TCPDF, and images come only from selected file entities, so there is no attacker-controlled HTML or remote-image path into TCPDF. Typical setup: install TCPDF, add a Data Export display, select PDF, configure fields, header/footer/metadata, and test the export URL.

---

- Export a view's results as a downloadable PDF
- Add a PDF format to an existing Data Export display
- Produce a styled, zebra-striped tabular report
- Set PDF metadata (title, author/creator, subject, keywords)
- Add a report header with title and subtitle
- Add a header contact line (phone, email, website)
- Add header address and notes text
- Place a logo image (from a file entity) in the PDF header
- Add a three-column footer (left/center/right)
- Show automatic "Page X of Y" numbering in the footer
- Auto-trigger the PDF download via the bundled JS
- Merge/append output onto an uploaded existing PDF
- Generate landscape-oriented data tables
- Export UTF-8 content to PDF
- Label columns from the view field labels
- Provide a printable version of a report view
- Escape/strip cell HTML so exports render as plain values
- Schedule/administer PDF exports behind the view's access control
- Build an invoice- or listing-style PDF from view data
