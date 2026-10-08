<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `CartUnifier` service & triggers

Service `commerce_combine_carts.cart_unifier` = `Drupal\commerce_combine_carts\CartUnifier`,
constructed with `commerce_cart.cart_provider`, `commerce_cart.cart_manager`,
`current_route_match`, `database`. This is the whole module — there is no config.

## Triggers (automatic)

1. **On login** — `commerce_combine_carts_user_login(UserInterface $account)` (`hook_user_login`)
   calls `CartUnifier::combineUserCarts($account)`.
2. **On order assignment** — `CartEventSubscriber` subscribes to `OrderEvents::ORDER_ASSIGN`; when the
   assigned order is a cart (`$order->get('cart')->value`), it calls
   `CartUnifier::assignCart($order, $event->getCustomer())`.

## Public methods

| Method | Behaviour |
|---|---|
| `getMainCarts(UserInterface $user): ?array` | Clears cart caches, loads the user's carts, returns **one main cart per order type** (keyed by bundle; later carts overwrite earlier for the same type). NULL if none. |
| `combineUserCarts(UserInterface $user): void` | For each main cart, merges every other same-type cart into it and **deletes** the emptied carts. Used by the login flow. |
| `assignCart(OrderInterface $cart, UserInterface $user): void` | Merges a just-assigned cart with the user's same-type main cart (direction depends on which is being checked out). Used by the order-assign flow. |
| `combineCarts(OrderInterface $main, OrderInterface $other, bool $delete = FALSE): void` | Moves all order items from `$other` into `$main` inside a DB transaction; then deletes `$other` (if `$delete`) or saves it empty. No-op if same id. |

## Merge rules an agent should know

- **Per order type only.** Carts of different bundles are never merged together.
- **Checkout-aware.** If a cart is the order currently on the `commerce_checkout.form` route
  (`isCartRequestedForCheckout()`), it is treated as the destination so the customer keeps checking out
  the cart they are on.
- **Item combining.** `shouldCombineItem()` reads the product's `variations` component on its default
  view display (`EntityViewDisplay`), and combines like items only when that component's
  `settings.combine` is truthy (and the purchased entity is still a valid `ProductVariationInterface`).
- **Atomic.** `combineCarts()` runs in a `database->startTransaction()` and rolls back on exception.

## Calling it from custom code

```php
/** @var \Drupal\commerce_combine_carts\CartUnifier $unifier */
$unifier = \Drupal::service('commerce_combine_carts.cart_unifier');
$unifier->combineUserCarts($user);          // consolidate to one cart per type
// or move items between two specific carts:
$unifier->combineCarts($mainCart, $otherCart, TRUE);
```

There is no config to read/write; to change behaviour you decorate/replace the service or the
subscriber.
