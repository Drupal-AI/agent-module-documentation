<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Document Preview renders office and PDF files inline in the browser through the Google Docs viewer, via a file-field formatter with inline (Simplebox) and modal display styles.

---

Document Preview lets a site show the contents of an uploaded document (pdf, doc, docx, xls, xlsx, ppt, pptx, txt) directly on the page instead of forcing a download. It adds a single core-file-field formatter, "Document Preview Formatter" (`document_preview_formatter`, extending `FileFormatterBase`), which you select on a file field's Manage display. The formatter offers two view types: "Simplebox" embeds the document inline in an `<iframe>` pointing at the Google Docs viewer, while "Modal window" renders the filename as an AJAX link that opens the document in a jQuery UI dialog (served by the `document_preview.modal` route). Rendering is delegated to Google's hosted viewer (`docs.google.com/viewer` and `docs.google.com/gview`), so the module only previews files on the public:// stream — files Google can actually download — and non-public files produce an error message instead of a preview. It depends only on core's Field and File modules, ships no settings form, and provides a `document_preview_field` theme hook (with template `document-preview-field.html.twig` and entity/bundle/field-based theme suggestions) for overriding the markup.

---

- Preview an uploaded PDF inline on a node page without making visitors download it first.
- Show Word documents (.doc, .docx) rendered in the browser on a content type's display.
- Display Excel spreadsheets (.xls, .xlsx) inline for quick review.
- Preview PowerPoint decks (.ppt, .pptx) directly in the page.
- Render plain-text (.txt) files inline.
- Add a "Document Preview Formatter" to any core file field on Manage display.
- Choose between an inline "Simplebox" iframe preview and a click-to-open "Modal window" preview per display.
- Build a document library page where each file opens in a modal dialog on click.
- Provide a "Download" link alongside each inline or modal preview so users can still grab the original file.
- Place document previews inside custom blocks and position them with Layout Builder.
- Attach a file field to a custom block type and format it as a document preview for reusable placement.
- Present product spec sheets or datasheets inline on commerce or catalog pages.
- Show contracts, policies, or terms documents inline on a legal/compliance page.
- Let editors preview course handouts or lesson materials inline in an LMS-style site.
- Preview report or whitepaper PDFs inline in a resources section.
- Display multiple documents in one field, each with its own inline preview or modal link (per-delta rendering).
- Override preview markup per entity type, bundle, field, or delta using the module's theme suggestions.
- Customize the modal dialog appearance with the module's CSS (`css/document_preview.css`) and dialog options.
- Offer an inline preview of publicly hosted meeting minutes or agendas.
- Show scanned forms or brochures (as PDFs) inline for visitors.
- Give site builders a no-code way to add in-browser document viewing using only core Field/File plus this module.
