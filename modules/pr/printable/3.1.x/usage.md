Printable generates printer-friendly (and, via its `printable_pdf` submodule, PDF) versions of Drupal content entities, exposing a stripped-down "Printable" render and per-entity Print/PDF links.

---

Printable adds a dynamic route `/{entity_type}/{entity}/printable/{format}` for every content entity type you enable (nodes, comments and users by default), rendering the entity through a `PrintableFormat` plugin. The shipped `print` format (in this module) outputs a clean, themeable HTML page using the `printable`, `printable_header` and `printable_footer` theme hooks and a dedicated `printable` view mode; the `pdf` format (in the `printable_pdf` submodule) streams a PDF via the `pdf_api` module and a chosen toolkit (wkhtmltopdf, TCPDF, mPDF or dompdf). All behavior is driven by the `printable.settings` config object, edited under *Configuration → User interface → Printable* (`/admin/config/user-interface/printable`, route `printable.configure`), with sub-forms for the Print and PDF format options and for where Print/PDF links appear. Print/PDF links are injected into entity output by `hook_entity_view()` and can also be placed with the "Printable Links Block". Two permissions gate it: `administer printable` and `view printer friendly versions`. The module defines two plugin types — `PrintableFormat` (output formats) and `PrintableLinkExtractor` (how in-content links are rewritten in print output: `none`, `remove`, `extract`, `subscript`) — plus a `printable://` stream wrapper used when building PDFs. Link handling, canonical-URL injection, "send to printer" JS, target-blank behavior and paper size/orientation are all configurable.

---

- Give visitors a clean, printer-friendly version of any node at `/node/{nid}/printable/print`.
- Offer a downloadable PDF of a node at `/node/{nid}/printable/pdf` (with the `printable_pdf` submodule).
- Add Print and/or PDF links automatically to node, comment or user pages.
- Place a "Printable Links Block" in a region to show Print/PDF links for the current entity.
- Choose which entity types get printable versions (nodes, comments, users, or custom entities).
- Restrict which bundles of an entity type are printable.
- Configure where Print links appear vs where PDF links appear, independently.
- Select the PDF toolkit (wkhtmltopdf, TCPDF, mPDF, dompdf) through the pdf_api integration.
- Set the PDF paper size (e.g. A4, Letter) and orientation (Portrait/Landscape).
- Decide whether the PDF is downloaded (attachment) or shown inline in the browser.
- Strip or rewrite in-content hyperlinks in print output using a link extractor (`remove`, `extract`, `subscript`, or leave them `none`).
- Include a canonical URL link in the printable page for SEO/reference.
- Auto-open the browser print dialog on the printable page ("send to printer"), optionally closing the window after.
- Add a custom CSS file to style the printable/PDF output.
- Theme the printable page via the `printable`, `printable_header`, and `printable_footer` templates.
- Use `*__printable` theme suggestions to give fields/entities a print-specific template.
- Open Print/PDF links in a new tab (target `_blank`) via a setting.
- Provide a printer-friendly view of user profiles for print-based directories.
- Generate PDF invoices/receipts pages from content entities (with a suitable toolkit configured).
- Build a "print this article" feature without writing a custom controller.
- Implement a new output format by adding a `PrintableFormat` plugin.
- Implement custom link-rewriting behavior by adding a `PrintableLinkExtractor` plugin.
- Serve absolute-URL, tokenless image paths in PDFs via the `printable://` stream wrapper.
- Gate access to printable pages with the `view printer friendly versions` permission.
- Let only privileged users change print/PDF settings via `administer printable`.
- Produce a distraction-free reading version of long-form content for printing.
