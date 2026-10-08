<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The xls_data_export Views style & its settings

Source: `src/Plugin/views/style/XlsxExport.php` (extends `views_data_export`'s `DataExport`).

## Building the export

1. Create a **Data export** display (Views Data Export) — or edit an existing one.
2. Set the display **Style** to **Xlsx export** (`xls_data_export`).
3. In the style's **Format** setting choose one or more of `xls`, `xlsx`, `ods` (the style registers
   these three extra formats with provider `serialization`; `slk`/`gnumeric` are also recognised by the
   encoder). The last selected format wins at encode time.
4. Configure the **xlsx Settings** group (below). The export is downloaded via Views Data Export's
   standard export path (a `rest_export`-style display); no extra route or permission is added here.

## `xls_settings` options (shown when a spreadsheet format is selected)

| Key | Widget | Purpose |
|---|---|---|
| `header` | `text_format` (Views/Token replacement, `;`-separated multi-column) | Print header row above the data. Single value → bold, merged across all columns; multiple `;` values → a header row of cells. |
| `footer` | `text_format` (Token, `;`-separated) | Footer line. Single value → merged bold row at the bottom and set as the odd-page footer with `Page P of N`. Can contain a formula, e.g. `Total;;;=sum(D:D)`. |
| `row_color` | textfield | Comma-separated **row numbers** to colour (e.g. `1,2`) instead of whole columns. |
| `color` (per field) | `color` inputs under a details group | Background colour per non-excluded field/column. `#000`/`#000000` are treated as "no colour". |
| `metadata` | (creator, last_modified_by, title, subject, description, keywords, category, manager, company) | Written to the spreadsheet's document properties (only on the first/offset-0 chunk). |

Column colours also drive **auto-size** on each column. The worksheet **title** is taken from the
View's title (sanitised to alphanumerics + spaces, max 31 chars). In a Views **live preview** the
encoder falls back to CSV output.

## Drush note

The style's options live on the view config (`display.<id>.display_options.style.options.xls_settings`).
Edit through the Views UI; there is no separate config object or settings form for the module.
