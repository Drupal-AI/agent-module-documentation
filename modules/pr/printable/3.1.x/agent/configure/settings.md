# Configuring Printable

All state is in the **`printable.settings`** config object. Admin UI: *Configuration → User
interface → Printable* (route `printable.configure`, `/admin/config/user-interface/printable`),
gated by `administer printable`.

## Config forms (all under `/admin/config/user-interface/printable`)

| Route | Path | Form |
|---|---|---|
| `printable.configure` | `/printable` | `PrintableConfigurationForm` (entities, links, general) |
| `printable.format_configure_print` | `/printable/print` | Print format options |
| `printable.format_configure_pdf` | `/printable/pdf` | PDF toolkit + options |
| `printable.ui` | `/printable/links` | Where **Print** links appear |
| `printable.pdf_ui` | `/printable/links/pdf` | Where **PDF** links appear |

## `printable.settings` keys (with shipped defaults)

| Key | Default | Meaning |
|---|---|---|
| `printable_entities` | `[node, comment, user]` | Entity types that get a printable version + route |
| `printable_entities_bundles` | all bundles enabled | Per-entity-type bundle enablement (`{type: {_all: true}}` or per-bundle) |
| `printable_print_link_locations` | `[node]` | Entity types on which the **Print** link is shown |
| `printable_pdf_link_locations` | `['']` | Entity types on which the **PDF** link is shown |
| `pdf_tool` | `''` | PDF toolkit id from pdf_api (e.g. `wkhtmltopdf`, `tcpdf`, `mpdf`, `dompdf`); empty = no PDF |
| `paper_size` | `A4` | PDF paper size |
| `page_orientation` | `Portrait` | PDF orientation (`Portrait` / `Landscape`) |
| `save_pdf` | `false` | `true` = download as attachment, `false` = inline in browser |
| `open_target_blank` | `true` | Open Print/PDF links in a new tab |
| `link_canonical` | `true` | Include a canonical `<link>` in the printable page |
| `extract_links` | `none` | Link-extractor id applied to in-content links (`none`/`remove`/`extract`/`subscript`) |
| `css_include` | `''` | Extra CSS file to include in printable/PDF output |
| `send_to_printer` | `false` | Auto-open the browser print dialog on the printable page |
| `close_window` | `false` | Close the window after printing (needs `send_to_printer`) |
| `exclude_printable_links` | `true` | Omit the Print/PDF links from the printable output itself |
| `path_to_binary` | `''` | Path to the PDF binary (e.g. wkhtmltopdf) |
| `print_pdf_use_xvfb_run` / `path_to_xvfb_run` / `ignore_warnings` | `false`/`''`/`false` | wkhtmltopdf-under-Xvfb options |

## Read / write with drush

```bash
drush cget printable.settings                       # dump all settings
drush cget printable.settings pdf_tool
drush cset printable.settings paper_size Letter -y
```

Programmatically:

```php
\Drupal::configFactory()->getEditable('printable.settings')
  ->set('page_orientation', 'Landscape')
  ->set('printable_print_link_locations', ['node', 'comment'])
  ->save();
```

## Notes

- Enabling PDF output means enabling the **`printable_pdf`** submodule (which pulls in
  `pdf_api`) and setting `pdf_tool` to a toolkit id; without a `pdf_tool` the PDF link is
  suppressed and the pdf format throws a NotFound.
- The printable route only exists for entity types listed in `printable_entities` (rebuilt by
  `RouteSubscriber` on cache rebuild), and a `printable` view mode is added for each.
- `printable_print_link_locations` / `printable_pdf_link_locations` control *where the links
  render*; an entity type can be printable (have the route) without showing a link.
