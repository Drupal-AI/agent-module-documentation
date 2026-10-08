<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs table — provided plugins

All three plugins operate on the **`entity_reference_revisions`** field type (Paragraphs
reference fields). This module defines plugin *instances*, not plugin types.

## Formatter — `paragraphs_table_formatter`

Class `ParagraphsTableFormatter` (extends `EntityReferenceFormatterBase`). Renders referenced
paragraphs as a table. `defaultSettings()` (schema
`field.formatter.settings.paragraphs_table_formatter`):

| Setting | Default | Meaning |
|---|---|---|
| `view_mode` | `default` | View mode used to render each paragraph. |
| `form_mode` | `default` | Form mode for inline add/edit. |
| `vertical` | `false` | Vertical table (fields down the side) vs horizontal (row per paragraph). |
| `caption` | `''` | Table caption. |
| `mode` | `''` | Table library: `''` (plain), `datatables`, `bootstrapTable`, `googleCharts`. |
| `number_column` | `false` | Add a leading number column. |
| `number_column_label` | `N°` | Its header. |
| `chart_type` | `''` | Google Charts chart type (when `mode` = `googleCharts`). |
| `chart_width` / `chart_height` | `900` / `300` | Chart dimensions. |
| `empty_cell_value` | `false` | Fill blank cells. |
| `empty` | `false` | Hide empty columns. |
| `ajax` | `false` | Load the table via AJAX. |
| `custom_class` | `''` | Extra CSS class on the table. |
| `hide_line_operations` | `false` | Hide per-row edit/duplicate/delete ops. |
| `hide_add_button` | `false` | Hide the add button. |
| `import`, `form_format_table`, `footer_text`, `sum_fields`, `export_name` | — | Import UI, footer, column sums, export filename. |

`mode` options come from `getConfigurableViewModes()`:
`datatables` → Datatables, `bootstrapTable` → Bootstrap Table, `googleCharts` → Google Charts.

## JSON formatter — `paragraphs_table_json_formatter`

Class `ParagraphsTableJsonFormatter`. Outputs the paragraphs as JSON. One setting
(`field.formatter.settings.paragraphs_table_json_formatter`): `recursion_level` (int,
default `2`) — how deep to serialize nested references.

## Widget — `paragraphs_table_widget`

Class `ParagraphsTableWidget` (extends the Paragraphs module's `ParagraphsWidget`). Edits
paragraphs in a table. `defaultSettings()` (schema
`field.widget.settings.paragraphs_table_widget`, which extends
`field.widget.settings.paragraphs`):

| Setting | Default | Meaning |
|---|---|---|
| `vertical` | `false` | Vertical editing table. |
| `paste_clipboard` | `false` | Enable paste-from-spreadsheet. |
| `field_reference` | `''` | Field used by the reference-search helper (shown when paste is on). |
| `show_all` | `false` | Show all rows at once instead of "add more". |
| `features` | `{duplicate: duplicate}` | Enabled row features (e.g. duplicate). |

Because it extends the core Paragraphs widget, all standard Paragraphs widget settings also
apply.
