# Settings & per-engine config

Form `\Drupal\entity_print\Form\SettingsForm` at route `entity_print.settings`
(`/admin/config/content/entityprint`; permission `administer entity print`).

## Global config — `entity_print.settings`
| Key | Default | Meaning |
|---|---|---|
| `default_css` | `true` | Include the module's default stylesheet in output |
| `force_download` | `true` | Send `Content-Disposition: attachment` so the file downloads |
| `base_url` | `''` | Absolute base URL used to resolve relative asset paths |
| `print_engines.pdf_engine` | `dompdf` | Selected engine per export type (`pdf_engine`, `epub_engine`, …) |

## Per-engine config (config entities `entity_print.print_engine.*`)
Each engine stores its own settings under `settings:` (schema types
`entity_print_print_engine.<id>`). Common PDF base options (`entity_print_engine_pdf`):
`default_paper_size`, `default_paper_orientation`, `dpi`, HTTP auth `username`/`password`.

- **Dompdf** adds: `enable_html5_parser`, `enable_remote`, `font_subsetting`, `embedded_php`,
  `cafile`, `verify_peer`, `verify_peer_name`, `disable_log`.
- **Wkhtmltopdf** (`phpwkhtmltopdf`) adds: `binary_location`, `zoom`, table-of-contents flags
  (`toc_*`), `viewport_size`, `remove_pdf_margins`.
- **TCPDF** (`tcpdfv1`) adds: `default_paper_size`, `default_paper_orientation`.

Switch engines on the settings form (only engines whose PHP library dependency is installed
appear — see [../plugins/print-engine.md](../plugins/print-engine.md) `dependenciesAvailable()`).
Export types (pdf/epub/word_docx) come from `entity_print.entity_print_export_types.yml`.
