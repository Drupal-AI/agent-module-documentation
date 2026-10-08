<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FPDI Print turns a Drupal View into a downloadable PDF, optionally stamping the view's field data onto an existing PDF template with the FPDI/TCPDF libraries.

---

FPDI Print (package "Views") adds a Views area handler that renders a "Download PDF" link in a view's header, footer or empty region. Following the link hits the `pdf/view/{view_name}/{display_id}/{option_id}` route, which re-executes the view and builds a PDF through the `fpdi_print.print_builder` service. Two modes exist: with a YAML "position configuration" you place text, HTML, images and merged PDF pages at explicit x/y millimetre coordinates over an imported PDF 1.4 template (letters, certificates, pre-printed forms); with the position box left empty it simply renders the view's HTML output into a fresh PDF, optionally adding the site logo/slogan header and view header/footer text. Tokens (`[site:name]`) and Twig (`{{ field_name }}`) are resolved against the first view row. AcroForm templates can be filled by field name via the bundled FPDM library. Global settings (page format from TCPDF's page list, orientation, a print-CSS file path, footer height) live at `/admin/config/content/fpdi-print`, and a helper at `/fpdi-print/validate` previews a template plus its YAML positions. Developers can call the print-builder service directly or alter positions via `hook_fpdi_print_views_alter()`.

---

- Add a "Download PDF" button to any View's header or footer.
- Print a node View (with a nid contextual filter) as a single-record PDF.
- Stamp view field values onto a pre-printed PDF letterhead template.
- Generate certificates from a designed PDF background plus dynamic name/date text.
- Fill an AcroForm PDF's named fields (address, name, phone) via FPDM — no coordinates needed.
- Place text at exact x/y millimetre positions on a template page.
- Overlay images (PNG/JPG/SVG/EPS/AI, a file entity id, a path, a base64 data URI, or an `<img>` tag) onto a PDF.
- Render arbitrary HTML blocks with TCPDF `writeHTML`/`MultiCell` at chosen coordinates.
- Merge additional whole PDF files into the output via a `pdf:` position entry.
- Print the full rendered view HTML when no position YAML is supplied.
- Add the site logo, name and slogan as a page header (the "Use logo, slogan" checkbox).
- Carry view header/footer "Global text" areas into the PDF header and footer.
- Auto-add "Page n/N" numbering on multi-page output.
- Choose paper size from TCPDF's full page-format list and portrait/landscape orientation.
- Apply a site-wide print stylesheet (CSS file path) to HTML content in the PDF.
- Set the footer height for content that wraps to many lines.
- Name the download file from a token (e.g. the node title) or force a server-side save path.
- View the PDF inline in the browser or force a download by setting a file name.
- Pass view contextual arguments through the print link via the `view_args` query parameter.
- Set PDF metadata (title, subject, keywords, author) from the view title, description and tag.
- Drive PDF generation from custom code with `\Drupal::service('fpdi_print.print_builder')->getPdf($positions, $template)`.
- Alter computed positions before rendering with `hook_fpdi_print_views_alter()`.
- Preview a template and validate position YAML at `/fpdi-print/validate` before configuring a view.
- Auto-rotate JPEG images by EXIF orientation when stamping photos.
- Rotate/style a stamped element by adding TCPDF setter keys (e.g. `Rotation`) as extra position entries.
