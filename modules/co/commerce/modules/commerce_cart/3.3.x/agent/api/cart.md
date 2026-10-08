# Cart services

| Service | Class | Purpose |
|---|---|---|
| `commerce_cart.cart_provider` | `CartProvider` | Get/create the current user's cart(s). `getCart($order_type, $store)`, `getCarts()`, `createCart(...)`, `getCartIds()`, `finalizeCart($cart)`. |
| `commerce_cart.cart_manager` | `CartManager` | Mutate a cart: `addEntity($cart, $purchasable, $qty)`, `addOrderItem()`, `updateOrderItem()`, `removeOrderItem()`, `emptyCart()`. Fires cart events. |
| `commerce_cart.cart_session` | `CartSession` | Track anonymous cart ids across requests (`ACTIVE` / `COMPLETED`). |
| — | `OrderItemMatcher` | Find an existing matching order item so duplicates combine instead of adding a new line. |

Example — add a product variation to the current cart:
```php
$cart_provider = \Drupal::service('commerce_cart.cart_provider');
$cart_manager  = \Drupal::service('commerce_cart.cart_manager');
$store = $variation->getStores()[0];
$cart  = $cart_provider->getCart('default', $store) ?: $cart_provider->createCart('default', $store);
$cart_manager->addEntity($cart, $variation, 1);
```

Cart events (`CartEvents`): `CART_ENTITY_ADD`, `CART_ORDER_ITEM_ADD/UPDATE/REMOVE`,
`CART_EMPTY` — subscribe to react to cart changes. `Cron` (`commerce_cart.cron`) purges
expired anonymous carts. Add-to-cart form, cart block and `/cart` page are provided as
form/block/view plugins and lazy builders.
