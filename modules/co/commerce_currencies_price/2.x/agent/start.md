<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Currencies Price (commerce_currencies_price) — agent index

Adds one Drupal Commerce field type, **`commerce_currencies_price`**, that stores a manually-entered
price for every enabled `commerce_currency` inside a **single serialized (blob) field** — instead of
adding a separate `commerce_price` field per currency. The widget renders one `commerce_price`
sub-element per currency (grouped in a `details` element); the value is stored as a serialized map
under one `prices` column. It ships a default widget, a default formatter (which renders **nothing**),
and a `commerce_currencies_price` **render element**. The field item exposes a helper
`toPrices()` returning `\Drupal\commerce_price\Price[]` keyed by currency code, plus raw access via
`$entity->field_name->prices`. This module only **stores** the per-currency prices; it does **not**
resolve, select, or convert a price for cart/checkout — choosing the active price is left to the
consuming code (the README/project note a planned, not-yet-present, `commerce_currency_resolver`
integration).

- Depends on: `commerce:commerce`, `commerce:commerce_price`.
- Core: `^10.3 || ^11`. Package: `Commerce`.
- No settings page / `configure` route. Configuration is **per field-widget** (form-display settings).
- No permissions, no services, no routes, no controllers, no AJAX, no drush, no hooks, no `.install`,
  no config schema shipped. Defines **no new plugin type** — only field-plugin implementations.
- Field cardinality is unlimited by default (a map item has no main property).

## What you'd do → where

- **Add the field to a bundle, choose which currencies are editable, require all prices** →
  [fields/index.md](fields/index.md)
- **Read the stored prices in code (`toPrices()`, `->prices`), set values programmatically, or reuse
  the `commerce_currencies_price` render element** → [api/index.md](api/index.md)

## Key facts (real machine names)

- Field type: `commerce_currencies_price` — `Plugin/Field/FieldType/CurrenciesPrice`. One storage
  column `prices` (`blob`, `size: big`, `serialize: TRUE`), one property `prices`
  (`MapDataDefinition`), `mainPropertyName()` = `NULL`. `category: "commerce"`,
  `default_widget: "commerce_currencies_price_default"`,
  `default_formatter: "commerce_currencies_price_formatter"`.
- Field widget: `commerce_currencies_price_default` — `Plugin/Field/FieldWidget/CurrenciesPriceDefaultWidget`.
  Settings: `required_prices` (bool, default `FALSE`), `available_currencies` (array of currency
  codes, default `[]` = all enabled currencies).
- Field formatter: `commerce_currencies_price_formatter` — `Plugin/Field/FieldFormatter/CurrenciesPriceFormatter`.
  `viewElements()` returns `[]` (renders nothing).
- Render element (`#type`): `commerce_currencies_price` — `Element/CurrenciesPrice` (extends
  `FormElementBase`). Properties consumed: `#available_currencies` (list of currency codes),
  `#required_prices` (bool), `#default_value` (`['prices' => ['USD' => ['number' => ..,
  'currency_code' => ..]]]`). Builds a `details` element `prices` with one core `commerce_price`
  element per currency.
- Field-item API: `$item->toPrices()` → `Price[]` keyed by currency code (skips empty numbers);
  raw map via `$entity->field_name->prices` or `$entity->field_name->get(0)->prices`.
