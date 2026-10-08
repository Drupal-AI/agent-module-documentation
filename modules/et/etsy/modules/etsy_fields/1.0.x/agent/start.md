<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etsy Fields (etsy_fields) — agent index

Submodule of **Etsy API** providing an Etsy-specific price field. Package `Etsy`. Depends on **`etsy`**. Core `^9.4 || ^10` (per its info.yml). License GPL-2.0-or-later. Version-dir 1.0.x. `etsy_fields.module` is empty — everything is plugins.

## Solution docs

- **The `etsy_price` field type, widget and formatter** → [fields/price.md](fields/price.md)

## What it provides (from source)

- **Field type** `etsy_price` — `Drupal\etsy_fields\Plugin\Field\FieldType\EtsyPriceItem` (`src/Plugin/Field/FieldType/EtsyPriceItem.php`). Columns: `amount` (int, unsigned, default 0), `divisor` (tiny int, unsigned, default 100), `currency_code` (varchar 5). `default_widget`/`default_formatter` = `etsy_price_default`. `category = "Etsy"`.
- **Widget** `etsy_price_default` — `EtsyPriceDefaultWidget` (`src/Plugin/Field/FieldWidget/EtsyPriceDefaultWidget.php`): textfields for amount + divisor, a currency `select` built from `etsy_supported_currencies()`.
- **Formatter** `etsy_price_default` — `EtsyPriceDefaultFormatter` (`src/Plugin/Field/FieldFormatter/EtsyPriceDefaultFormatter.php`): renders `#theme => 'etsy_price'` with `amount = number_format(amount/divisor, 2)`, `symbol` from the currency map, and `currency_code`.

No routes, permissions, services, config, or Drush. The `etsy_price` theme hook is registered by the **etsy_shop** submodule, so the formatter's markup depends on etsy_shop being enabled.

Note: the etsy_shop submodule ships an identical trio of `etsy_price` plugins (same ids) under its own namespace — see the etsy_shop tree.
