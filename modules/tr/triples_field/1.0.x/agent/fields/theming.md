<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Templates and theming

Three templates are registered by `hook_theme`, all with `render element => 'elements'`:

- **`triples-field-item.html.twig`** — used by the list formatters. Loops `item` (the three
  columns); for a `text` column it applies `|nl2br`, otherwise prints the auto-escaped value.
  Each column can be wrapped by the `triples_field_subfield` theme when its label is shown.
- **`triples-field-subfield.html.twig`** — renders one column value, optionally prefixed by an
  inline label (`field--label-inline`). Used by the Table and Details formatters and by
  `triples_field_item` when `show_label` is set.
- **`triples-field-definition-list.html.twig`** — `dl` output for the HTML-list formatter's `dl`
  mode: `first` as `<dt>`, `second` and `third` as `<dd>`.

All value output is Twig **auto-escaped**; there is no `|raw` and no `#markup` fed from a stored
column value, so column values cannot inject markup.

## Theme suggestions (all keyed by field name)

- `triples_field_item__<field_name>`
- `triples_field_subfield__<field_name>`
- `triples_field_definition_list__<field_name>`
- `item_list__triples_field__<field_name>` (via `hook_theme_suggestions_item_list_alter`, using
  the `#context.triples_field.field_name` passed by `HtmlList`)
- `table__triples_field__<field_name>` and `details__triples_field__<field_name>` (via the
  table/details suggestion alters, reading the `triples-field--field-name` attribute the
  formatters stamp on the render element)

## CSS / libraries (`triples_field.libraries.yml`)

- `triples_field/widget` — `css/widget.css`, attached by the widgets.
- `triples_field/drupal.triples-field-icon` — `css/triples_field.theme.css` plus a dependency on
  `field_ui/drupal.field_ui.manage_fields`; attached to the fallback field-type category so the
  field shows its icon (`icons/triple_field.svg`) in the "Add field" UI.
