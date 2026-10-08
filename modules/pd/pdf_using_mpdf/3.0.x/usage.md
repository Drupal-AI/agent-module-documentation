PDF using mPDF converts rendered HTML into a downloadable PDF via the bundled `mpdf/mpdf` library, and gives every node a "Generate PDF" tab plus a reusable conversion service for arbitrary HTML.

---

Enabling the module adds a `node/{node}/pdf` route that renders a node in a configurable view mode and streams it through mPDF as a PDF. Global defaults live in one config object (`pdf_using_mpdf.settings`) edited at `admin/config/user-interface/mpdf`: filename, output mode (open in browser / download dialog / save to a file scheme), page size/orientation/margins/DPI, document metadata, an HTML header and footer, a text or image watermark, a password (mPDF `SetProtection`), an optional PDF template overlay and CSS source (theme libraries or a Drupal-root-relative file). Access is per content type: a dynamic `generate <type> pdf` permission is checked by a custom access check for each node type. Programmatic callers use the `pdf_using_mpdf.conversion` service (`ConvertToPdfInterface::convert($html, $settings, $context)`) to convert any HTML, overriding settings per call and passing a token context. Two alter hooks — `hook_mpdf_html_alter()` and `hook_mpdf_settings_alter()` — let other modules rewrite the HTML or the mPDF settings per node before conversion. An optional "Render anonymous" toggle renders the node as the anonymous user before conversion. Tokens in settings strings are replaced via the Token service, and filenames are transliterated and sanitized.

---

- Add a "Generate PDF" download link/tab to nodes of a chosen content type.
- Let editors export an article to PDF in the site's full view mode.
- Convert arbitrary HTML to a PDF from custom code via the `pdf_using_mpdf.conversion` service.
- Save generated PDFs to a file scheme (public/private) folder instead of streaming them.
- Stream a PDF inline in the browser or force a download dialog.
- Brand every PDF with a custom HTML header and footer (logo, page numbers via `{PAGENO}`).
- Stamp a text watermark (e.g. "DRAFT" / "CONFIDENTIAL") across every page.
- Stamp an uploaded image watermark with adjustable opacity.
- Password-protect generated PDFs and restrict print/copy via mPDF protection.
- Set PDF document metadata (title, author, subject, creator).
- Control page size (A4, Letter, …), orientation, margins, font and DPI.
- Pull CSS from the active theme's libraries (or a specific Drupal-root-relative CSS file) so PDFs match the site.
- Overlay content on a fixed PDF template file (letterhead) per document.
- Insert dynamic values into filename/header/footer with tokens (e.g. `[node:title]`, `[site:name]`, `[date:custom:...]`).
- Render a node as the anonymous user for PDF output to strip personalized/admin markup.
- Alter the HTML sent to mPDF per node type with `hook_mpdf_html_alter()`.
- Swap in per-use-case mPDF settings with `hook_mpdf_settings_alter()` (e.g. page numbers only for articles).
- Generate invoices, certificates, or receipts from rendered entity content.
- Produce a printable data sheet from a node's full display.
- Batch-save PDFs to a private scheme for later retrieval.
- Localize the output filename via transliteration of the current content language.
- Grant PDF generation to specific roles per content type through generated permissions.
- Override the default font to one of mPDF's bundled Unicode fonts for non-Latin scripts.
- Reuse the same converter for non-node entities by rendering them to HTML first.
