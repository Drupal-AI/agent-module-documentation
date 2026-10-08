<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etsy price field (etsy_price)

The whole module is three field plugins sharing the id family `etsy_price` / `etsy_price_default`. Enable with `drush en etsy_fields` (requires `etsy`).

## Field type — `EtsyPriceItem`

`src/Plugin/Field/FieldType/EtsyPriceItem.php`, `@FieldType(id="etsy_price", category="Etsy", default_widget="etsy_price_default", default_formatter="etsy_price_default")`.

- `schema()` columns:
  - `amount` — `int`, size normal, unsigned, not null, default 0.
  - `divisor` — `int`, size tiny, unsigned, not null, default 100.
  - `currency_code` — `varchar(5)`, not null.
- `propertyDefinitions()`: `amount` (integer), `divisor` (integer), `currency_code` (string).
- `isEmpty()` — empty when `amount` is NULL or `''`.

Mirrors Etsy's money representation (integer amount + divisor → a decimal value).

## Widget — `EtsyPriceDefaultWidget`

`src/Plugin/Field/FieldWidget/EtsyPriceDefaultWidget.php`, `@FieldWidget(id="etsy_price_default", field_types={"etsy_price"})`. `formElement()` renders:
- `amount` — textfield.
- `divisor` — textfield.
- `currency_code` — `select`, options from `currencyCodeOptions()` → `etsy_supported_currencies()` (base module), formatted `"{symbol} {label} ({code})"`, with an empty "Select a currency" option.

## Formatter — `EtsyPriceDefaultFormatter`

`src/Plugin/Field/FieldFormatter/EtsyPriceDefaultFormatter.php`, `@FieldFormatter(id="etsy_price_default", field_types={"etsy_price"})`. `viewElements()`:
- For each item: `$amount = amount / divisor`; builds `['#theme' => 'etsy_price', '#amount' => number_format($amount, 2, '.'), '#symbol' => currencyMap[code]['symbol'] ?? NULL, '#currency_code' => code]` and renders it via the `renderer` service into `#markup`.
- The `etsy_price` theme hook (variables amount/symbol/currency_code) is declared in `etsy_shop_theme()` with template `templates/etsy-price.html.twig` in the **etsy_shop** submodule — so this formatter needs etsy_shop enabled to render its markup.

## Usage

Add an "Etsy price" field to any fieldable entity (typically the `etsy_listing` node bundle from Etsy Shop) via *Manage fields*; the default widget/formatter are selected automatically. The etsy_shop import writes this shape directly: `['amount' => price->amount, 'divisor' => price->divisor, 'currency_code' => price->currency_code]`.

Duplication caveat: etsy_shop ships an identical `etsy_price` field type + widget + formatter (same plugin ids, its own classes using `etsy_shop_supported_currencies()`). Enabling both modules registers two classes for the same ids; on a typical Etsy Shop install the etsy_shop copies are what back the `field_etsy_price` field.
