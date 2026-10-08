<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs table — agent index

A field **formatter** + **widget** (plus a JSON formatter) that display/edit Paragraphs
reference fields (`entity_reference_revisions`) as a spreadsheet-style table — one paragraph
per row, sub-fields as columns. Requires the Paragraphs module.

- **The provided plugins (ids, field type, settings, table modes, JSON)** →
  [plugins/provided.md](plugins/provided.md)
- **How to apply the widget/formatter to a paragraphs field's display; item routes; permission** →
  [configure/display.md](configure/display.md)

Key facts:
- Plugin ids: formatter `paragraphs_table_formatter`, JSON formatter
  `paragraphs_table_json_formatter`, widget `paragraphs_table_widget` — all for field type
  `entity_reference_revisions`.
- Formatter `mode` chooses a JS table library: `datatables`, `bootstrapTable`, or
  `googleCharts` (empty = plain table). `vertical` flips rows/columns.
- Settings stored on the display: `field.formatter.settings.paragraphs_table_formatter`,
  `field.widget.settings.paragraphs_table_widget`,
  `field.formatter.settings.paragraphs_table_json_formatter`.
- Permission `administer paragraphs_item fields`. No configure route (`configure: null`) —
  you set it per field on Manage display / Manage form display.
- Ships `/paragraphs_item/*` routes (add/edit/clone/delete + json/ajax). No Drush, no plugin types.
