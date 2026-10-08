Printable PDF is a submodule of Printable that adds the `pdf` output format, turning any printable content entity into a downloadable/inline PDF via the `pdf_api` module and a chosen PDF toolkit.

---

The submodule contributes a single `PrintableFormat` plugin, `pdf` (`PdfFormat`), plus PDF-specific header/footer theme hooks. It depends on the parent `printable` module and on `pdf_api`, and it reads its behavior entirely from the parent's `printable.settings` config — it has no config object or settings form of its own (PDF options are edited on the parent's `/admin/config/user-interface/printable/pdf` and `/links/pdf` forms). Once enabled, every printable entity gains a `/{entity}/printable/pdf` URL (route `printable.show_format.{type}` with format `pdf`) and, where configured, a PDF link. At render time `PdfFormat` instantiates the toolkit named in `printable.settings.pdf_tool` (a `pdf_api` generator: `wkhtmltopdf`, `tcpdf`, `mpdf`, or `dompdf`), builds the printable HTML (rewriting asset URLs through the parent's `printable://` stream wrapper and stripping image tokens), applies the paper size/orientation, and returns a `BinaryFileResponse` — as an attachment when `save_pdf` is TRUE, inline otherwise. If no `pdf_tool` is selected it shows an error and 404s. For `wkhtmltopdf` it also honors the Xvfb-run options from `printable.settings`.

---

- Offer a "Download PDF" version of any node at `/node/{nid}/printable/pdf`.
- Generate PDFs of comments or user profiles once those entity types are printable.
- Choose the PDF engine (wkhtmltopdf, TCPDF, mPDF, dompdf) through the pdf_api integration.
- Serve the PDF as a download (attachment) or inline in the browser via the `save_pdf` setting.
- Set PDF paper size and orientation for all generated documents.
- Show PDF links only on selected entity types via `printable_pdf_link_locations`.
- Produce print-ready PDF handouts or documentation pages from site content.
- Add a PDF-specific header and footer using the `printable_pdf_header`/`printable_pdf_footer` theme hooks.
- Embed local images correctly in PDFs thanks to the `printable://` stream wrapper and token stripping.
- Generate a PDF of an article for archiving or email distribution.
- Provide downloadable PDF invoices/receipts from content entities (with a suitable toolkit).
- Point the module at a specific `wkhtmltopdf` binary path for controlled rendering.
- Run wkhtmltopdf under Xvfb on a headless server via the Xvfb-run options.
- Save generated PDFs to a configured location/filename pattern (with tokens).
- Give editors a one-click PDF export without a separate reporting tool.
- Add a new PDF variant by configuring a different pdf_api generator.
- Combine with a custom `printable` CSS include to brand the PDF output.
- Let anonymous users download PDFs when granted `view printer friendly versions`.
- Convert long-form content into a paginated, printable PDF document.
- Produce PDFs for any content entity type the parent module is configured to treat as printable.
