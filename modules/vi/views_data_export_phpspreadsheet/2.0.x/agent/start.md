<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Data Export phpspreadsheet — agent index

Extends Views Data Export with an "Xlsx export" Views style (`xls_data_export`) and a PhpSpreadsheet
serialization encoder producing real `xls`/`xlsx`/`ods` files with headers, footers, per-column
colours, metadata and embedded images. Depends on `rest`, `views`, `views_data_export`; requires the
`phpoffice/phpspreadsheet` library. No settings page (`configure` null), no permissions, no Drush.

- **The `xls_data_export` style: how to build the export display and every `xls_settings` option** →
  [configure/style.md](configure/style.md)
- **`XlsEncoder` internals, formats, hyperlink/image handling, and the two alter hooks** →
  [api/encoder.md](api/encoder.md)

Key facts:
- Style plugin `xls_data_export` (`src/Plugin/views/style/XlsxExport.php`) extends Views Data Export's
  `DataExport`; adds formats `xls`/`xlsx`/`ods` (provider `serialization`) and an **xlsx Settings**
  options group.
- Encoder service `xls_serialization.encoder.xls` (`src/Encoder/XlsEncoder.php`, format `xls`, also
  handles `xlsx`/`ods`/`gnumeric`); request subscriber `XlsSubscriber` maps the MIME types to request
  formats.
- Hooks for other modules: `xls_encoder_header_alignment`, `xls_encoder_data` (both `invokeAll` with
  the worksheet by reference).
- Access/download uses Views Data Export's own export route; this module adds no route of its own.
