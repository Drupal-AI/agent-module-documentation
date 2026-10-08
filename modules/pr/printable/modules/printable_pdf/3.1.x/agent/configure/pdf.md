# PDF generation (printable_pdf)

`printable_pdf` provides one `PrintableFormat` plugin — id **`pdf`**, class
`Drupal\printable_pdf\Plugin\PrintableFormat\PdfFormat`. It has **no config of its own**; all
options live in the parent module's **`printable.settings`** object.

## The pdf route

Enabling the submodule makes the `pdf` format valid, so every printable entity gets:

```
/{entity_type}/{entity}/printable/pdf     e.g. /node/12/printable/pdf
```

(route `printable.show_format.{type}` with `printable_format = pdf`, gated by
`view printer friendly versions` + `entity.view`).

## `printable.settings` keys that drive PDF output

| Key | Default | Effect |
|---|---|---|
| `pdf_tool` | `''` | The `pdf_api` generator id: `wkhtmltopdf`, `tcpdf`, `mpdf`, `dompdf`. **Empty → error + 404** |
| `printable_pdf_link_locations` | `['']` | Entity types on which the **PDF** link is shown |
| `save_pdf` | `false` | `true` = download as attachment; `false` = inline in browser |
| `paper_size` | `A4` | PDF paper size |
| `page_orientation` | `Portrait` | PDF orientation |
| `path_to_binary` | `''` | Path to the toolkit binary (e.g. wkhtmltopdf) |
| `pdf_location` | `''` | Optional output filename/path (supports tokens) |
| `print_pdf_use_xvfb_run`, `path_to_xvfb_run`, `ignore_warnings` | `false`/`''`/`false` | wkhtmltopdf-under-Xvfb options |

Edited on the parent forms: PDF toolkit/options at `/admin/config/user-interface/printable/pdf`
(route `printable.format_configure_pdf`); where PDF links appear at
`/admin/config/user-interface/printable/links/pdf` (route `printable.pdf_ui`).

```bash
drush cget printable.settings pdf_tool
drush cset printable.settings pdf_tool dompdf -y
drush cset printable.settings save_pdf 1 -y
```

## How PdfFormat renders

1. Reads `pdf_tool`; if empty, adds an error and throws `NotFoundHttpException`.
2. Instantiates the toolkit via `plugin.manager.pdf_generator` (pdf_api).
3. Builds the printable HTML (`buildPdfContent()`), rewriting asset URLs through the parent's
   `printable://` stream wrapper and calling `removeImageTokens()` so images resolve to local
   paths.
4. Applies `paper_size` / `page_orientation`, renders `printable_pdf_header` /
   `printable_pdf_footer`, and generates the file.
5. Returns a `BinaryFileResponse` (attachment if `save_pdf`, else inline), deleting the temp
   file after send.

For `wkhtmltopdf` it additionally sets `enable-local-file-access` and, if
`print_pdf_use_xvfb_run` is set, the Xvfb command options.

## Theme hooks

`printable_pdf_theme()` registers `printable_pdf_header` and `printable_pdf_footer`
(templates in `printable_pdf/templates/`) for PDF-specific header/footer content.

## Note

You still need the actual toolkit installed on the server (a PHP library like TCPDF/dompdf or
the `wkhtmltopdf` binary) for `pdf_api` to generate output; selecting `pdf_tool` only chooses
which generator the module asks pdf_api for.
