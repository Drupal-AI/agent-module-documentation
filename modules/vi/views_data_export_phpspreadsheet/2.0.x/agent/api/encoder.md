<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XlsEncoder internals & alter hooks

Sources: `src/Encoder/XlsEncoder.php`, `src/EventSubscriber/XlsSubscriber.php`,
`src/Hook/ViewsDataExportPhpspreadsheet.php`, `views_data_export_phpspreadsheet.services.yml`.

## Services

- `xls_serialization.encoder.xls` — `XlsEncoder` (args: app root, `token`, `config.factory`,
  `module_handler`), tagged `encoder` for format `xls`. `supportsEncoding/Decoding` also accept
  `xlsx`, `ods`, `gnumeric`.
- `xls_serialization.xlssubscriber` — `XlsSubscriber` registers request formats for `ods`, `xls`,
  `xlsx`, `xml`, `slk`, `gnumeric` on kernel request so the download responds with the right MIME type.

## `encode($data, $format, $context)`

Runs only when a `views_style_plugin` is in `$context`:
- In a Views **preview** (`$view->preview`) → returns CSV via `csv_serialization`'s `CsvEncoder`.
- Chooses the concrete format from the style's selected `formats` (last one).
- Collects non-excluded view fields as the header row; reads each field's config `type` (to detect
  `image` fields) from its cache tags.
- Applies per-column colours (`xls_settings.color`, skipping black) and auto-size; prepends the header
  row; builds the print header (merged/bold), footer (with page numbers), and document metadata.
- Writes each row via `formatValue()` (`Html::decodeEntities` + `strip_tags` + trim). Cell values
  matching an `<a href>` or a bare `http(s)://` URL become real **hyperlinks**.
- **Image fields**: `getImgSrc()` extracts the `<img src>`, strips the site base URL, `parse_url`s the
  path, validates the extension against an allow-list (`png/jpg/jpge/bmp/gif`), and resolves it to
  `<app-root>/<path>` to embed via a PhpSpreadsheet `Drawing` (one image per field). Non-images fall
  back to the text value.
- Fills column/row colours, applies the bottom footer style, then writes with `IOFactory::createWriter`
  to `php://output` and returns the buffered bytes. On error throws `InvalidDataTypeException`.

`decode($data, $format, $context)` reads a spreadsheet string via `IOFactory::createReader` and returns
the active sheet as an array (used for the "reader" support the README mentions).

## Alter hooks (`invokeAll`, worksheet by reference)

- `hook_xls_encoder_header_alignment(\PhpOffice\PhpSpreadsheet\Worksheet\Worksheet &$worksheet, array $options)`
  — invoked after the print header is written; adjust header alignment/styling.
- `hook_xls_encoder_data(\PhpOffice\PhpSpreadsheet\Worksheet\Worksheet &$worksheet, array $options)`
  — invoked after all data rows are written; post-process the sheet.

## Notes for agents

- The style/encoder inherit Views Data Export's export **route and access** — there is no extra
  permission or endpoint in this module.
- Image embedding reads a local file resolved under the Drupal app root; the `src` comes from the
  rendered image field markup and is constrained to the extension allow-list.
