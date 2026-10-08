<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF To Canvas Formatter renders an uploaded PDF directly in the page as an HTML `<canvas>` using the pdf.js library, instead of offering a download link or embedding an `<iframe>`. It is a field formatter for `file` fields, so any content type with a PDF file field can display the document inline.

---

The `PdfToCanvasFieldFormatter` (`@FieldFormatter` id `pdf_to_canvas_field_formatter`, for `file` field types) resolves the file on the current node, gets its file URL via `createFileUrl()`, and passes that URL to the client through `drupalSettings.pdf_to_canvas.file_url`; the module's JS (attached globally via `hook_page_attachments()`) then uses pdf.js to paint the PDF onto a canvas rendered by the `pdf_to_canvas` theme hook. All rendering happens client-side against the site's own file URL — the module does not fetch any request-supplied or remote URL server-side (no SSRF surface), and the file comes from the field's own value. It has no dependencies beyond core, no permissions, and no configuration form (the formatter has empty settings).

---

- Display an uploaded PDF inline as a canvas instead of a download link.
- Show product datasheets or brochures directly on the node page.
- Render PDFs without relying on the browser's native PDF plugin/iframe.
- Present documents consistently across browsers via pdf.js.
- Turn a plain file field into an inline document viewer with one formatter change.
- Show reports or manuals on a page without leaving the site.
- Avoid forcing users to download a PDF just to preview it.
- Keep PDF rendering client-side (no server-side conversion).
- Use the site's own managed file URL for the PDF source.
- Add a document preview to article or resource content types.
- Display certificates or forms inline for quick review.
- Provide a lightweight PDF preview without a third-party viewer service.
- Reuse an existing file field rather than adding a new field type.
- Render the first/relevant page of a PDF onto a canvas element.
- Integrate PDF preview into custom display modes.
- Keep the display self-contained (library attached automatically).
