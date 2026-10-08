# The `basket_price_field` field type

Basket has **its own price field** and the cart reads prices only from this type. Add it to your
product bundle as the price field (see [../configure/products.md](../configure/products.md)).

- **Field type:** `basket_price_field` (label "Basket Price Field", class
  `Plugin\Field\FieldType\BasketPriceField`). Field-type category `basket`
  (`basket.field_type_categories.yml`).
- **Default widget:** `BasketPriceFieldWidget`. **Default formatter:** `BasketPriceFieldFormatter`.

## Stored columns (per item)

| Property | Storage | Meaning |
|---|---|---|
| `value` | `numeric(10,2)`, indexed | Current price. |
| `old_value` | `numeric(10,2)` | Previous/"was" price (defaults to `0` on save via `preSave()`); used to show a strike-through old price. |
| `currency` | `int`, indexed, nullable | Currency id (references a row in `basket_currency`). |

`isEmpty()` treats the item as empty unless **both** `value` and `currency` are set. So a price item
always carries a currency; the cart converts it to the shopper's selected currency at display time
(`BasketCurrency`), which is why product renders vary by the `basket_currency` cache context.

## Reading a price in code

```php
$item = $node->get('field_price')->first();
$price    = $item->value;       // current
$was      = $item->old_value;   // old/struck price
$currency = $item->currency;    // currency id

// Or the resolved, currency-converted price used by the store:
$price = \Drupal::service('Basket')->getNodePrice($node, 'MIN');
```

The store never accepts a price from the request — order/line prices are recomputed server-side from
this field during checkout (`Cart::getItemPrice()` → `Entity::insertOrder()`).
