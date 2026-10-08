<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config schema and Excel presentation options

This module owns **only** a config-schema file; it stores no config object of its own and has no
settings route. The schema extends the Views Data Export display/style schema so the Excel-specific
options are validated when a View is exported. File:
`config/schema/views_data_export_excel.views.schema.yml`.

## `views.display.data_export_excel` (display options)

Extends `views.display.data_export`. Adds header-row presentation keys:

| Key | Type | Meaning |
|---|---|---|
| `header_bold` | boolean | Render the header (first) row bold. |
| `header_italic` | boolean | Render the header row italic. |
| `header_background_color` | string | RGB hex (no `#`) fill for the header row. |
| `header_text_color` | string | Header text colour. |

These are read by XLS Serialization's `ExcelExportDisplayTrait` (form + summary) and applied by its
`Xls` encoder (`setHeaderRowBold()`, `setHeaderRowItalic()`, `setHeaderRowBackgroundColor()`).
The trait also manages up-to-5 **conditional formatting** rules
(`conditional_formatting_base_field_N`, `_operator_N`, `_compare_to_N`, `_background_color_N`) via
`buildConditionalFormattingRulesForm()`; those are defined/stored by the trait, not by this
module's schema file.

## `views.style.data_export_excel` (style options)

Extends `views.style.data_export`. Adds an `xls_settings` mapping:

| Key | Type | Meaning |
|---|---|---|
| `xls_format` | string | Output format, e.g. `Xlsx` (default) or `Xls` (legacy). |
| `strip_tags` | boolean | Strip HTML tags from each cell value before writing. |
| `trim` | boolean | Trim whitespace from each cell value. |
| `metadata` | mapping | Document properties written onto the workbook. |

`metadata` keys: `creator`, `last_modified_by`, `title`, `description`, `subject`, `keywords`,
`category`, `manager`, `company`. These map to phpspreadsheet document properties via the encoder's
`setMetaData()`.

## Where the file is actually written

This module does **not** write cells. The serializer format registered by the style plugin is
handled by XLS Serialization's encoder `Drupal\xls_serialization\Encoder\Xls` (and its `Xlsx`
subclass), which builds a `PhpOffice\PhpSpreadsheet\Spreadsheet`, calls `setHeaders()` /
`setData()` / `setStyles()`, applies the header and conditional formatting, and streams the result
with `IOFactory::createWriter($xls, $this->xlsFormat)->save('php://output')`. `strip_tags` and
`trim` are applied per value in the encoder's `formatValue()`; the format/format-conversion is in
its `setSettings()`. To understand or audit the concrete cell-writing behaviour, read
`xls_serialization/src/Encoder/Xls.php` — not this module.

## Config example (View display + style)

```yaml
# in the Views config for the display of type data_export_excel
display_options:
  display_extenders: {  }
  header_bold: true
  header_italic: false
  header_background_color: 'DDDDDD'
  header_text_color: '000000'
  style:
    type: data_export_excel
    options:
      xls_settings:
        xls_format: Xlsx
        strip_tags: true
        trim: true
        metadata:
          creator: 'Reporting'
          title: 'Monthly export'
          company: 'Example Ltd'
```

## Operational notes

- Generation is **in-memory** (the workbook is fully built before `save('php://output')`), so a
  large export is memory-hungry; use the Data Export display's batching for big result sets.
- Choosing `Xls` produces a legacy `.xls`; `Xlsx` is the default modern format.
- Compatible with the **XLS Serialization Extras** feature set (the encoder's `setStyles()` hook is
  reserved for it).
