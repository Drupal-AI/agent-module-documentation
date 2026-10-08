<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals & extension points

## Service: `commerce_add_to_cart_confirmation.manager`

`Drupal\commerce_add_to_cart_confirmation\CartConfirmationManager`
implements `CartConfirmationManagerInterface`. Constructed with `@tempstore.private`.

- `recordAddToCart(array $cart_item_info): void` — stores `$cart_item_info` under key
  `cart_item_info` in the private tempstore collection `commerce_add_to_cart_confirmation`.
- `getCartItemInfo(): ?array` — returns the stored array **and clears it** if non-empty (one-shot;
  guarantees the dialog fires once per add).
- `clear(): void` — deletes the stored value.

The tempstore is **private** (per authenticated user or per anonymous session), so the pending
order item can only ever be the current visitor's own.

## Event subscriber

`src/EventSubscriber/ConfirmationMessageSubscriber.php` subscribes to
`CartEvents::CART_ENTITY_ADD` (`onAddToCart`) and records `order_item_id` + `quantity` from the
`CartEntityAddEvent`. This is the only trigger; there is no form-alter or submit handler.

## Render element `commerce_add_to_cart_confirmation_message`

`src/Element/AddToCartMessage.php` (`#[RenderElement(...)]`, extends `RenderElementBase`,
implements `ContainerFactoryPluginInterface`). Reusable:

```php
$build['x'] = [
  '#type' => 'commerce_add_to_cart_confirmation_message',
  '#include_fallback' => TRUE, // optional: adds a hidden fallback wrapper div
];
```

- `getInfo()` sets a `#pre_render` → `generatePlaceholder()`, which builds a `#lazy_builder`
  (`AddToCartMessage::renderMessage`) and **forces a placeholder** via
  `render_placeholder_generator` (so it works for both GET and POST; comment references core issue
  2367555).
- `renderMessage()` (static lazy-builder callback): loads the pending order item, runs the
  `confirm_message_product_display` view with the order item ID, themes it with
  `#theme => 'commerce_add_to_cart_confirmation'`, and attaches the rendered string +
  `$view->getTitle()` to `drupalSettings.commerce_add_to_cart_confirmation.{content,title}`.
  Title falls back to `$order_item->getTitle()` or `t('Your item')`.

## hook_page_bottom + JS handoff

`commerce_add_to_cart_confirmation_page_bottom()` places the element (weight -1000,
`#include_fallback => TRUE`) on every page and attaches the library. `js/…js` (deps: `core/once`,
`core/drupalSettings`, `core/drupal.dialog`) reads `drupalSettings…content`, and if set opens
`Drupal.dialog('<div>' + content + '</div>', {title, width: 745, …}).showModal()`, wiring
`.commerce-add-to-cart-confirmation-close` to close it.

## Theme

`hook_theme()` registers `commerce_add_to_cart_confirmation` with variables `title`, `message`,
`order_item`, `quantity`; `template_preprocess_commerce_add_to_cart_confirmation()` adds
`message-inner`, `commerce-add-to-cart-confirmation`, and an `item-type--<bundle>` class when the
order item has a purchased entity.

## Views area handlers

`src/Plugin/views/area/OrderItemOrderTotal.php` and `OrderOtherCount.php` — see
[`../config/customization.md`](../config/customization.md). Both iterate the view's arguments for a
`commerce_order_item.order_item_id` `NumericArgument`, load the order item, and render totals; they
return `[]` when no valid order can be resolved.
