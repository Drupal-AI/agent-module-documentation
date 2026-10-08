# Blocks

Four core `@Block` plugins (place at `/admin/structure/block`, or render programmatically with
`\Drupal::service('plugin.manager.block')->createInstance('<id>')->build()`).

| Block id | Admin label | Shows |
|---|---|---|
| `basket_count` | Basket count | The cart summary (item count / total) with a link to the cart; theme `basket_count_block`. This is the block the add/update/delete AJAX endpoints re-render live. |
| `basket_currency` | Basket currency | A currency **switcher**; selecting one posts to `/basket/api-change_currency` (`Currency::setCurrent()`) and reloads. |
| `basket_currency_rate` | Basket currency rate | The current exchange-rate display (theme `basket_rate_block`). |
| `basket_user_discount` | Basket user discount percent | The signed-in user's personal discount % (theme `basket_user_discount`); re-rendered alongside `basket_count` after cart changes. |

The cart-count and user-discount blocks are `max-age: 0` / vary by the `basket_currency` cache
context, so they always reflect the live cart and selected currency. Product listings themselves are
built with Views (the `basket` / `cart_goods` views), not blocks.
