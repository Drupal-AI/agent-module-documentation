# Enforcement behavior & messages

## What it does (no config needed to work)

`commerce_stock_enforcement_form_alter()` hooks three places:
- **Add-to-cart form** — loads the selected variation, checks availability via
  `commerce_stock.service_manager` (minus quantities already in carts). If out of stock it sets
  the submit button to "Out of stock" and disables it (and the quantity field). A validator
  rejects requested quantities above the available level.
- **Cart page** (a view tagged `commerce_cart_form`) — validates each line item's quantity
  against stock on update.
- **Checkout** (`commerce_checkout_flow`) — re-checks the whole order; if anything is out of
  stock it adds an error and redirects back to `/cart` (throws `NeedsRedirectException`).

Enforcement only bites when the resolved stock service reports finite levels — i.e. a
variation using `local_stock`. With `always_in_stock`, `getStockLevel()` returns effectively
infinite and nothing is blocked.

## Configurable messages — `commerce_stock_enforcement.settings`

Form `StockEnforcementConfigForm` at
`/admin/commerce/config/stock/enforcement/settings` (route
`commerce_stock_enforcement.settings`, permission `administer commerce stock`).

| Key | Placeholders | Default | Shown when |
|---|---|---|---|
| `insufficient_stock_cart` | `%name`, `%qty` | `The maximum quantity for %name that can be ordered is %qty.` | cart / checkout / order quantity too high |
| `insufficient_stock_add_to_cart_zero_in_cart` | `%qty`, `%qty_asked` | `Sorry, we only have %qty in stock and you've asked for %qty_asked.` | add-to-cart, nothing yet in cart |
| `insufficient_stock_add_to_cart_quantity_in_cart` | `%qty`, `%qty_o` | `Sorry, we only have %qty in stock and you already added %qty_o to your cart.` | add-to-cart, some already in cart |

```bash
drush cget commerce_stock_enforcement.settings
drush cset commerce_stock_enforcement.settings insufficient_stock_cart 'Only %qty of %name left.' -y
```
Or in PHP:
```php
\Drupal::configFactory()->getEditable('commerce_stock_enforcement.settings')
  ->set('insufficient_stock_cart', 'Only %qty of %name left.')
  ->save();
```

Messages are passed through `Xss::filter()` before use. Keep the documented placeholders so
the quantity values interpolate.
