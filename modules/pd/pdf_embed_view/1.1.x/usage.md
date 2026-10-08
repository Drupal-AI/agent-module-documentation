<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Embed and display PDF files inline, in a modal dialog, or in a new tab.

---

PDF Embed View renders PDF files directly on the page instead of as a bare download link. It ships three display plugins that all share one theme hook and one `display_mode` setting (`inline` / `modal` / `new_tab`): a **file** field formatter ("PDF Embed Viewer", `field_types = file`), an **entity_reference** field formatter for Media ("PDF Embed Viewer (Media)", only offered on media-target reference fields), and a **Views** field plugin (`pdf_embed_view_field`). Inline mode embeds the PDF in a lazy-loaded `<iframe>`; modal mode renders a "View PDF" link that opens the iframe in a `core/drupal.dialog` jQuery UI modal; new-tab mode renders a plain `target="_blank"` link. The file URL is produced server-side by `file_url_generator` from the file's URI (absolute string). The media formatter additionally enforces `application/pdf` MIME type and `access('view')` on the underlying file; the file formatter checks `access('view')` only. No external PHP or JS libraries are required (no pdf.js) — it relies on the browser's native PDF viewer. Depends on core `field` and `media`; supports Drupal 9.3, 10, and 11.

---

- Embed a node's PDF file field inline on the page.
- Show a "View PDF" link that pops the PDF in a modal dialog.
- Link a PDF to open in a new browser tab.
- Display PDFs referenced through Media (Document) entities.
- Add a PDF viewer column/field to a View.
- Replace plain file download links with an in-page reader.
- Preview uploaded contracts, invoices, or reports inline.
- Let editors choose inline vs modal vs new-tab per display mode.
- Present datasheets or manuals on product pages.
- Render brochures in a lightbox-style modal.
- Show course/lesson PDF handouts inline.
- Surface policy or legal documents on a page.
- Build a media library listing with inline PDF previews via Views.
- Respect core file/media access when showing PDFs.
- Restrict media-formatter output to genuine `application/pdf` files.
- Keep PDF loading cheap with `loading="lazy"` iframes.
- Offer a full-screen (90% viewport) modal reader.
- Give each embed a unique modal DOM id for multiple PDFs per page.
- Theme the embed markup by overriding `pdf-embed-view.html.twig`.
- Support Drupal 9.3, 10, and 11 sites.
