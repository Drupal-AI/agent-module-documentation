<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Properties field

The module adds one field type and its widget/formatters. There is **no module settings page** (`configure` route is null); everything is done on the entity's Manage fields / form display / display.

## Plugin IDs

- Field type: `properties` (label "Properties", category "General"). Cardinality is forced to UNLIMITED. Default widget `properties_default`, default formatter `properties_table`.
- Widget: `properties_default` (label "Properties", `multiple_values = TRUE`).
- Formatters: `properties_table` (default) and `properties_list`.
- Validation constraint: `UniqueProperties` — attached to the field type; rejects two items with the same `label` or same `machine_name` (case-insensitive) within one entity.

## Item structure & storage

Each field item has four columns (see `PropertiesItem::schema`):

| Column | Storage | Notes |
|---|---|---|
| `machine_name` | varchar(64) | required |
| `label` | varchar(255) | required |
| `type` | varchar(50) | a value-type plugin ID |
| `value` | blob, **serialized** | scalar or small array (size/weight store `['value'=>…, 'unit'=>…]`) |

`isEmpty()` treats an item as empty unless all four of machine_name/label/type/value are set. Programmatic set example:

```php
$entity->set('field_specs', [
  ['machine_name' => 'width', 'label' => 'Width', 'type' => 'size',
   'value' => ['value' => 12.5, 'unit' => 'cm']],
  ['machine_name' => 'sku', 'label' => 'SKU', 'type' => 'string', 'value' => 'ABC-1'],
]);
```

## Widget (`properties_default`)

Renders a drag-orderable table with columns Label, Machine name, Type, Value, Weight (+ Remove when >1 row), plus "Add another item". Behaviour:

- **Label** is a textfield with an autocomplete that suggests labels already used for the same field on the same entity type/bundle (route `properties_field.label_autocomplete`, gated by the target entity's create/update access).
- **Machine name** is auto-derived from the label (core `machine_name` element); no uniqueness callback (the `UniqueProperties` constraint enforces it on save instead).
- **Type** is a select of value-type plugins; changing it requires confirming (an AJAX "Select" reloads the Value control for the new type). Widget setting `value_types` holds per-value-type widget config (most types add none).

## Formatters

- `properties_table` — one `#theme => 'table'` with a header cell (label) and a value cell per item. Setting `striping` (bool, default TRUE) toggles zebra rows.
- `properties_list` — a `<dl>` via the `properties_list` theme hook / `properties-list.html.twig` (`<dt>`=label, `<dd>`=value).

Both delegate value rendering to the item's value-type plugin (`formatterRender`); the `value_types` formatter setting stores per-type options (e.g. decimal/thousand separators). Output is autoescaped by the table render element / Twig template — labels and values are printed as plain text, no raw markup.
