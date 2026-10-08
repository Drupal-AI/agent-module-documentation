<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Data Formatter — agent index

Adds one **field formatter** that renders selected keys from the `map`-type **`data` field** on
Commerce orders and order items. Version **1.0.3**; core `^8.9||^9||^10||^11`; depends on
`drupal:field` + `commerce:commerce_order`. No routes, no permissions, no services, no config
entities — just the formatter plugin plus two hooks.

## Formatter plugin
`src/Plugin/Field/FieldFormatter/CommerceOrderDataFormatter.php`
- Id `commerce_order_data_formatter`, label **"Commerce Order Data (key|value)"**, `field_types = {map}`.
- `isApplicable()` restricts it to fields on entity types **`commerce_order`** and **`commerce_order_item`**.
- Settings (`defaultSettings`): `keys` (string, default `NULL`) and `key_name` (bool, default `FALSE`).
  - `keys` — comma-separated list of keys to show; empty = **all** keys. Parsed by `getKeys()`
    (`explode(',')` → `trim` → `array_filter`).
  - `key_name` — checkbox; when on, each value is labelled with its key.
- `viewElements()`: for each `MapItem`, `$item->toArray()` gives the stored assoc array.
  - Exactly **one** key configured → `viewSingle()` (bare value).
  - Zero keys (all) or **more than one** key → `getKeysItemList()` → `#theme => item_list`.
- `viewSingle($key, $value)`: booleans cast to int; arrays flattened via
  `http_build_query($value, NULL, '<br>')` then `=`→`: `. Output render array is either a plain
  `['#markup' => $value]` or an `inline_template` `'<b>{{ key }}:</b><br> {{ value }}'` whose
  `value` context is itself `['#markup' => $value]`. All value output goes through `#markup`, so
  Drupal applies its admin XSS filtering; access to the value follows the standard field/entity
  display access of whatever display or View the field sits on.

## Hooks (`commerce_order_data_formatter.module`)
- `hook_help()` — About text on `help.page.commerce_order_data_formatter`.
- `hook_entity_base_field_info_alter()` — on `commerce_order` and `commerce_order_item`, sets the
  base **`data`** field to `setDisplayConfigurable('view', TRUE)` so it can be placed on
  **Manage display** / Views (otherwise the base field is not display-configurable).

## Usage in one line
Manage display (or a View) on an order/order-item → set the **Data** field's format to
*Commerce Order Data (key|value)* → enter the key(s) and optionally tick *Display key name*.
No settings page; the formatter has no global config. `data.json` reports `provides_config_schema:
true` (the formatter's `keys`/`key_name` settings schema).
