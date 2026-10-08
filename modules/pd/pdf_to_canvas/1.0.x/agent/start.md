<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF To Canvas Formatter — agent index

File-field formatter that renders a `.pdf` into an HTML `<canvas>` client-side via pdf.js.
Core-only, no permissions, no settings.

Quick facts:
- Formatter: `PdfToCanvasFieldFormatter` (`@FieldFormatter` id `pdf_to_canvas_field_formatter`, field type `file`).
- Mechanism: reads the file's `createFileUrl()`, passes it as `drupalSettings.pdf_to_canvas.file_url`; JS (attached via `hook_page_attachments()`) paints it with pdf.js into the `pdf_to_canvas` theme element.
- Not an SSRF surface: source is the field's own managed file URL, rendered client-side; nothing request-supplied is fetched server-side.
