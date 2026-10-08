<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF Reader adds a "PDF Reader" field formatter that renders File, plain-text (string), or URI fields containing a PDF as an inline document viewer, using Google Docs Viewer, pdf.js, a direct embed, the Microsoft Office viewer, or a Colorbox lightbox.

---

The module ships a single field formatter plugin, `FieldPdfReaderFields` (label "PDF
Reader"), applicable to field types `string`, `file`, and `uri`. You select it on an
entity's *Manage display* for a field holding a PDF (an uploaded file, or a text/URI field
with a PDF URL). The formatter resolves each item to an absolute file URL (loading the File
entity for `file` fields, or validating the URL for string/uri values) and renders it via
the chosen renderer: `google` (Google Docs Viewer), `ms` (Microsoft Office Web viewer),
`embed` (direct `<embed>` with Adobe open-parameters `view`/`toolbar`), `pdf-js` (the
bundled pdf.js viewer), and — only when both Colorbox and Libraries modules are enabled —
`colorbox` (lightbox). Output is themed through the module's templates (`pdf_reader`,
`pdf_reader_embed`, `pdf_reader_js`, `pdf_reader_colorbox`) and its JS/CSS libraries. The
formatter's settings (stored as ordinary formatter settings on the display component) are:
`pdf_width` (600), `pdf_height` (780), `renderer` (`google`), `embed_view_fit`
(`Fit`/`FitH`/`FitV`, direct-embed only), `embed_hide_toolbar` (bool, direct-embed only),
`download` (show a download link), and `link_placement` (`top`/`bottom`). It defines the
permission "administer pdf reader" but has no admin settings page, config route, entity, or
Drush command — configuration is entirely per-field on the display.

---

- Embed an uploaded PDF (file field) inline on a node using the Google Docs Viewer.
- Render a PDF with the bundled pdf.js viewer so it works without external services.
- Directly `<embed>` a PDF in the browser's native viewer at a fixed width/height.
- Show a PDF via the Microsoft Office Web viewer.
- Open a PDF in a Colorbox lightbox (with Colorbox + Libraries modules).
- Display a PDF referenced by URL from a plain-text or URI field.
- Add a "Download" link above or below the embedded PDF viewer.
- Set the viewer width and height (e.g. 600×780) per field display.
- Fit the direct-embed viewer horizontally or vertically (`FitH`/`FitV`).
- Hide the PDF toolbar in the direct-embed renderer for a cleaner look.
- Provide a document library where each PDF file field renders as an inline reader.
- Show product datasheets (PDF) embedded on product pages.
- Present policy/terms PDFs inline instead of forcing a download.
- Render brochures uploaded as file fields in a media-rich layout.
- Configure different renderers per view mode (teaser vs full) for the same PDF field.
- Display externally hosted PDFs by storing their URL in a URI field.
- Standardise PDF display across content types via exported display config.
- Gate PDF-reader maintenance behind the "administer pdf reader" permission.
- Combine an embedded viewer with a download link for accessibility.
- Swap renderers (Google ↔ pdf.js ↔ embed) without changing the stored file.
