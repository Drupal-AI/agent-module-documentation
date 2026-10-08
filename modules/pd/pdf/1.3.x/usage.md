<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDF renders uploaded PDF files inline with Mozilla's pdf.js instead of forcing a download or relying on a browser plugin, by adding three field formatters for core `file` fields.

---

The module ships no field type and no field widget — it only adds three **field formatters** for core's `file` field type: `pdf_default` ("PDF: Default viewer of PDF.js") embeds the pdf.js `viewer.html` in an `<iframe>`, `pdf_thumbnail` ("PDF: Display the first page") renders page 1 into a `<canvas>`, and `pdf_pages` ("PDF: Continuous scroll (experimental)") renders every page into stacked canvases. Every formatter checks `$item->entity->getMimeType() === 'application/pdf'` per item and silently falls back to core's `file_link` theme for anything that is not a PDF, so a mixed file field degrades gracefully. The pdf.js library is **not** bundled: the module expects it unpacked at the docroot path `/libraries/pdf.js/` (`build/pdf.js`, `build/pdf.worker.js`, `web/viewer.html`), declared in `pdf.libraries.yml`. A single settings form at `/admin/config/media/pdfjs` (route `pdf.config_form`, permission `administer pdfjs`, menu link under *Configuration → Media*) stores one key, `custom_viewer`, in the `pdf.settings` config object, letting you point the iframe at a themed copy of `viewer.html`. The `pdf_default` formatter builds the iframe `src` as `<viewer>?file=<urlencoded absolute file url>` and, when "Always use pdf.js" is on, appends pdf.js viewer hash options (`page`, `zoom`, `pagemode`) so you can deep-link to a page or force a zoom level. When "Always use pdf.js" is off it attaches the `pdf/default` library, whose `acrobat_detection.js` hands the file to a native Acrobat/WebKit plugin when one is present and warns when the browser cannot render PDFs at all. Rendering goes through the module's own `file_pdf` theme hook (`templates/file-pdf.html.twig`, a single `<iframe {{ attributes }}>`), so themes can override the markup. The module declares no config schema, no services, no plugin types, no Drush commands, and no `configure` key in its `.info.yml`.

---

- Show a product datasheet PDF inline on the node page instead of a download link.
- Embed a board-meeting minutes PDF in an iframe viewer with page navigation and search.
- Render only the first page of a report as a canvas thumbnail in a teaser view mode.
- Build a document library listing where each row shows a PDF cover-page preview.
- Give a "Continuous scroll" reading experience for short PDFs without leaving the site.
- Deep-link a manual so it always opens on page 12 (`page` setting on `pdf_default`).
- Force "Fit Page" or "Full Width" zoom for a scanned document that renders badly at default zoom.
- Open a long PDF with the thumbnails sidebar already expanded (`pagemode: thumbs`).
- Open a structured report with the bookmarks/outline sidebar expanded (`pagemode: bookmarks`).
- Set a custom scale percentage for a PDF whose native page size is unusually large or small.
- Constrain the viewer to a fixed pixel height so it fits a sidebar block.
- Make the viewer 100% wide and responsive inside a Layout Builder section.
- Let users with Adobe Reader keep their native plugin by turning "Always use pdf.js" off.
- Point the viewer at a re-skinned `viewer.html` in your theme via the `custom_viewer` setting.
- Serve a locale-customised pdf.js viewer per environment by overriding `pdf.settings`.
- Use a different formatter per view mode: thumbnail in teasers, full viewer on the full page.
- Preview PDFs attached to a Media entity's source file field in the media library detail view.
- Show course handouts inline in an LMS-style content type so students never download them.
- Display legal terms/policy PDFs on the page so a visitor can read without a PDF reader installed.
- Present a gallery of scanned archive documents as first-page canvases linking to full records.
- Restrict who can change the viewer path by granting only trusted roles `administer pdfjs`.
- Override `file-pdf.html.twig` in a theme to add a wrapper, download button, or caption.
- Keep a mixed "attachments" file field working: PDFs get a viewer, other files get a normal link.
- Scale the thumbnail canvas (`scale`) up for a high-DPI cover image in a card component.
- Avoid a server-side PDF-to-image pipeline (ImageMagick/Ghostscript) by rendering client-side.
