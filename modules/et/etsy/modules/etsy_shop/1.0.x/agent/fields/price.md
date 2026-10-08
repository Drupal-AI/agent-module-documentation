<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Etsy price field + etsy_price theme (etsy_shop copy)

Etsy Shop ships its own copy of the price field plugins (same ids as the etsy_fields submodule) and owns the `etsy_price` theme hook the formatter renders through. On an Etsy Shop install these are what back the `field_etsy_price` field on `etsy_listing`.

## Plugins (`Drupal\etsy_shop\Plugin\Field\...`)

- **Field type** `etsy_price` — `EtsyPriceItem` (`src/Plugin/Field/FieldType/EtsyPriceItem.php`): columns `amount` (int unsigned, default 0), `divisor` (tiny int unsigned, default 100), `currency_code` (varchar 5). `default_widget`/`default_formatter` = `etsy_price_default`.
- **Widget** `etsy_price_default` — `EtsyPriceDefaultWidget`: amount textfield, divisor textfield, currency `select` from `etsy_shop_supported_currencies()`.
- **Formatter** `etsy_price_default` — `EtsyPriceDefaultFormatter`: renders `#theme => 'etsy_price'` with `amount = number_format(amount/divisor, 2)`, `symbol` from `etsy_shop_supported_currencies()`, `currency_code`, then `renderer->render()` into `#markup`.

These are byte-for-byte the same shape as `etsy_fields` except they call `etsy_shop_supported_currencies()` instead of `etsy_supported_currencies()` (identical maps). Enabling both etsy_fields and etsy_shop registers two classes for the ids `etsy_price` / `etsy_price_default`.

## Theme hook `etsy_price`

Declared in `etsy_shop_theme()` (`etsy_shop.module`): variables `amount`, `symbol`, `currency_code`; template `templates/etsy-price.html.twig`:

```
<span class="etsy-listing-price" data-currency-symbol="{{ symbol }}" data-amount="{{ amount }}" data-currency-code="{{ currency_code }}">
  {% if symbol is not empty %}{{ symbol }} {% endif %}{{ amount }} ({{ currency_code }})
</span>
```

All values are Twig-autoescaped. Because this theme hook lives in etsy_shop, the etsy_fields formatter also depends on etsy_shop being enabled to render.

## Population

The cron importer writes the field directly: `$node->set('field_etsy_price', ['amount' => listing->price->amount, 'divisor' => listing->price->divisor, 'currency_code' => listing->price->currency_code])` (see [../config/import.md](../config/import.md)).
