<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Switch flow — route, access, confirm form, SwitchManager

The end-to-end path a shopper takes to swap a cart line to an alternative
variation. All classes under `src/`.

## Route

`.routing.yml` → `commerce_product_alternative.switch`:

```
path: /cart/variation-alternative/{commerce_order_item}/{commerce_product_variation}
_form: \Drupal\commerce_product_alternative\Form\SwitchConfirmForm
_commerce_product_alternative_switch_access: 'TRUE'
```

Both params are entity-upcast (`commerce_order_item`, `commerce_product_variation`).
The `commerce_product_variation` is the **target** to switch to.

## Access checker — `Access/SwitchAccessChecker`

Registered in `.services.yml` as an `access_check` tagged with
`applies_to: _commerce_product_alternative_switch_access`. `access()` returns
forbidden unless **all** hold:

1. The order item has a parent order.
2. The order is a **draft cart** — `state === 'draft'` and the `cart` field is
   TRUE.
3. The order belongs to the current user — `$order->getCustomerId() === (int)
   $account->id()`.
4. The source (purchased) variation has a `variation_alternative` field.
5. The target id appears in the source variation's `variation_alternative`
   items (`target_id` match).
6. The target variation `isPublished()`.
7. A temp order item built from the target passes
   `AvailabilityManagerInterface::check()`, using a `Context` carrying
   `['commerce_product_alternative_switch' => TRUE]` so availability checkers
   that gate on cart state (e.g. "one membership per cart") can treat this as a
   replacement, not an addition, and return neutral.

The result carries cacheable dependencies on order/source/target.

## Confirm form — `Form/SwitchConfirmForm`

AJAX modal (`FormBase`). `buildForm()` pulls the order item + target from the
route match, resolves source and target prices via
`commerce_price.chain_price_resolver`, and renders "Current: label (price)" /
"Switch to: label (price)" (label + price are escaped `t()` placeholders;
prices formatted by `commerce_price.currency_formatter`). Buttons:

- **Confirm** — `#ajax` callback `::ajaxSubmit`; `submitForm()` calls
  `SwitchManager::switchItem()`, then `ajaxSubmit()` returns a `RedirectCommand`
  to the `referer` header (default `/`) so the cart page reloads.
- **Cancel** — button with `::ajaxCancel` returning a `CloseDialogCommand`;
  `#limit_validation_errors => []`.

Attaches `core/drupal.dialog.ajax`.

## Switch manager — `SwitchManager::switchItem(OrderItemInterface, ProductVariationInterface)`

1. Reads the parent order, source purchased variation, and quantity.
2. `cartManager->removeOrderItem($order, $order_item, FALSE)` (no save yet).
3. `order_item_storage->createFromPurchasableEntity($target)`, then
   `setQuantity()` to the preserved quantity.
4. Resolves the target price (`chainPriceResolver->resolve()` with a `Context`
   of current user + store); sets it if non-null.
5. `copyFieldValues()` — copies user/custom fields: iterates source field
   definitions, **skips `BaseFieldDefinition`** fields and any field missing on
   the destination bundle, copies the rest verbatim (source and target may be
   different order-item bundles).
6. `cartManager->addOrderItem($order, $new_item, FALSE, TRUE)` (saves cart).
7. Generates a `commerce_log` entry with template
   `commerce_product_alternative_item_switched` and args
   `from_label` / `to_label`.

## Rendering the links

Two entry points build the switch link and both skip a target when
`!$url->access()` (so the access checker above is the single source of truth for
what a shopper may switch to):

- **Formatter** `commerce_product_variation_alternative` — only renders when
  `$entity->_context['order_item']` is set (i.e. an order item is in render
  context); otherwise returns `[]`. Link text = per-item `cta` or
  `prefix . target->label()`. Adds `use-ajax` + `data-dialog-type: modal`.
- **Views field** `commerce_product_alternative_variation_links` on
  `commerce_order_item` — the recommended cart-view integration; renders an
  `item_list` with configurable CSS classes. Link text = `cta` or
  `target->label()`.

Both add `user` cache context and the order-item + target cache tags.
