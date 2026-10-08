<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The repeat-order route, controller, config and event

## Install & enable

```bash
# No composer.json ships in the module; require the project directly.
composer require drupal/commerce_repeat_order
drush en commerce_repeat_order -y
```

Depends on `commerce` and `commerce_cart` (both from the Commerce project). No sub-modules.

## Routes (`commerce_repeat_order.routing.yml`)

| Route id | Path | Method | Requirement |
|---|---|---|---|
| `commerce_repeat_order.repeat_order` | `/commerce-repeat-order/{commerce_order}` | GET | `_permission: 'view own commerce_order'` |
| `commerce_repeat_order.settings_form` | `/admin/commerce/config/order/repeat-order` | GET/POST | `_permission: 'commerce repeat order admin access'` |

`{commerce_order}` is upcast to a `commerce_order` entity (`options.parameters.commerce_order.type:
entity:commerce_order`), so a non-existent id yields a 404 before the controller runs. The
reorder action mutates the cart and then `redirect('commerce_cart.page')`.

## How to expose it

There is no UI link out of the box. Add a link/button pointing at
`/commerce-repeat-order/{ORDER_ID}` — e.g. from a Twig template, a Views "custom text"/link field on
an order-history view, or an order-detail block:

```
Url::fromRoute('commerce_repeat_order.repeat_order', ['commerce_order' => $order->id()])
```

## Controller: `CommerceRepeatOrder::repeatOrder()`

File `src/Controller/CommerceRepeatOrder.php`. Constructor injects
`commerce_cart.cart_manager` (`CartManager`), `commerce_cart.cart_provider` (`CartProvider`),
`messenger`, and `event_dispatcher`. Flow:

1. **Ownership gate.** `$uid = $this->currentUser()->id();
   $order_uid = $this->order->getCustomerId();` then
   `if (!empty($order_uid) && $uid == $order_uid) { … }`. If the order is not owned by the current
   user, it does **not** touch the cart — it calls `messenger->addError(t('You can only repeat your
   own order.'))` and redirects. (The `!empty($order_uid)` guard also blocks orders whose customer
   id is 0, i.e. guest/anonymous orders.) So the route's plain `view own commerce_order` permission
   is backstopped by an explicit in-controller ownership comparison; a user cannot rebuild a cart
   from an order they do not own.
2. **Config.** Reads `commerce_repeat_order.settings`, key `add_or_override`.
3. **Cart.** `cartProvider->getCart('default', $order->getStore())`; if none, `createCart(...)`.
   If a cart exists **and** `add_or_override == 'override'`, `cartManager->emptyCart($cart)`.
4. **Copy items.** For each `$order->getItems()`:
   - `$variation = $order_item->getPurchasedEntity(); $product = $variation ? $variation->getProduct() : NULL;`
   - Only if `$product && $product->isPublished()`:
     `$new = $order_item->createDuplicate(); $new->enforceIsNew(); $new->id = NULL;
     $new->order_item_id = NULL; $new->save();` then `cartManager->addOrderItem($cart, $new)`.
   - Otherwise the item is skipped and a `$message` ("Some products weren't copied…") is prepared.
   - `dispatcher->dispatch(new OrderCloneEvent($this->order, $cart), OrderCloneEvent::ORDER_CLONED)`
     is called **inside the loop** (once per item; note the "new" argument passed is the cart, not
     a per-item clone).
5. **Message.** If `$message` was set and `status_message == 'show'`, `messenger->addStatus($message)`.
6. **Redirect** to `commerce_cart.page`.

### Notes on the item copy

`createDuplicate()` produces a copy of the source order item and adds it to the cart; the new item
is then subject to Commerce's normal cart/order-refresh processing. Availability is only checked
here via `$product->isPublished()` (unpublished-product items are skipped); stock/quantity limits
and per-variation availability are left to Commerce's own cart/checkout availability processors on
the resulting cart. The event is dispatched per iteration, and the "new order" it carries is the
`$cart`, so subscribers get the cart object rather than the individual duplicated item.

## Settings form (`Form\CommerceRepeatOrderSettingsForm`)

Config object **`commerce_repeat_order.settings`** (no `config/schema`, no `config/install`
defaults ship — values are null until an admin first saves the form):

| Key | Options | Meaning |
|---|---|---|
| `add_or_override` | `add` / `override` | *Add Product* appends the order's items to the existing cart; *Override* empties the cart first. Radios are `#required`. |
| `status_message` | `show` / `hide` | Whether to show the "some products weren't copied" status message. |

Both fields are `#required` radios with `#default_value` read from config; because no install
default exists, the very first render has no selection until saved.

## Event (`Event\OrderCloneEvent`)

Subscribe to `commerce_repeat_order.order_cloned` (constant `OrderCloneEvent::ORDER_CLONED`) to run
custom logic when an order is repeated. `getOriginal()` returns the source order;
`getNew()` returns the object passed as the second constructor arg (the cart, per the controller).

## Permissions (`commerce_repeat_order.permissions.yml`)

- `commerce repeat order admin access` — guards the settings form only.
- The reorder route uses Commerce's core `view own commerce_order` permission; grant it to the
  roles that should be able to reorder.

## Operating checklist

1. `drush en commerce_repeat_order -y`.
2. Visit `/admin/commerce/config/order/repeat-order`, choose Add vs Override and Show vs Hide,
   save (do this before first use so the config keys exist).
3. Grant `view own commerce_order` to customer roles (and `commerce repeat order admin access` to
   admins).
4. Surface a link to `/commerce-repeat-order/{order_id}` where customers should see it.
