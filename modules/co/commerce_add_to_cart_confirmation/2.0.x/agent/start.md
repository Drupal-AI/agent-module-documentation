<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce add to cart confirmation (`commerce_add_to_cart_confirmation`) — agent index

Shows a modal **confirmation dialog** after a product is added to a Drupal Commerce cart, in place
of Commerce's default status message. Version **2.0.0**, core `^10.3 || ^11`. Requires
`commerce_cart`, `commerce_product` and core **`views`** (composer requires `drupal/commerce:^3`).
GPL-2.0-or-later. **No settings form, no routes, no permissions, no Drush.**

## How it actually works (server-driven, no custom route)

1. **Capture** — `src/EventSubscriber/ConfirmationMessageSubscriber.php` subscribes to
   `\Drupal\commerce_cart\Event\CartEvents::CART_ENTITY_ADD`. On add-to-cart it calls
   `CartConfirmationManager::recordAddToCart(['order_item_id' => …, 'quantity' => …])`, which stores
   that array in the **private** tempstore collection `commerce_add_to_cart_confirmation`
   (service `commerce_add_to_cart_confirmation.manager`, backed by `@tempstore.private`).
2. **Place** — `commerce_add_to_cart_confirmation_page_bottom()` (hook_page_bottom) inserts a
   `#type => 'commerce_add_to_cart_confirmation_message'` render element into every page and attaches
   the `commerce_add_to_cart_confirmation/commerce_add_to_cart_confirmation` library.
3. **Render** — `src/Element/AddToCartMessage.php` (RenderElement) turns itself into a placeholdered
   `#lazy_builder` → `AddToCartMessage::renderMessage()`. That callback calls
   `CartConfirmationManager::getCartItemInfo()` which **reads and then clears** the tempstore (one-shot).
   If an `order_item_id` is pending it loads the `commerce_order_item`, runs the
   `confirm_message_product_display` view with the order item ID as contextual argument, and injects
   the rendered HTML + view title into `drupalSettings.commerce_add_to_cart_confirmation.{content,title}`.
   The body is themed by `templates/commerce_add_to_cart_confirmation.html.twig`
   (`#theme` = `commerce_add_to_cart_confirmation`; preprocess in the `.module`).
4. **Display** — `js/commerce_add_to_cart_confirmation.js` reads `drupalSettings`, and if `content`
   is set opens a `Drupal.dialog` (core/drupal.dialog) modal titled with `title`, width 745. The
   Twig template provides a **"Go to cart"** link (`commerce_cart.page`) and a **"Continue shopping"**
   link (`.commerce-add-to-cart-confirmation-close`) that just closes the dialog.

## What it provides

- **Render element** `commerce_add_to_cart_confirmation_message` (`AddToCartMessage`) — reusable.
- **Service** `commerce_add_to_cart_confirmation.manager` (`CartConfirmationManager` /
  `CartConfirmationManagerInterface`): `recordAddToCart()`, `getCartItemInfo()`, `clear()`.
- **View** `confirm_message_product_display` (optional config; base table `commerce_order_item`,
  arg = order item ID, `access: none`, no page/path display) — the confirmation body.
- **Two view modes**: `commerce_product.add_to_cart_confirmation_view` and
  `commerce_product_variation.add_to_cart_confirmation`.
- **Two Views area handlers** (`hook_views_data` in `.views.inc`, classes in
  `src/Plugin/views/area/`): `OrderItemOrderTotal` ("Order total for views with order item id
  argument") and `OrderOtherCount` ("Order other total count" → "N other items in your Cart").
- **Theme hook + template**, CSS, and JS library.
- **Runtime requirement** (`.install`): warns if the `confirm_message_product_display` view is deleted.

## Configuration (there is no admin UI)

Everything is customised by editing the **view** and the two **view modes** — see
[`config/customization.md`](config/customization.md). Internals for reuse/extension are in
[`api/internals.md`](api/internals.md).

## Security / access

The order item ID is taken **only** from the current user's own private tempstore, never from
request input — there is no route or controller that echoes cart content. Confirmation body is
rendered through Views/Twig (auto-escaped) before it reaches `drupalSettings`. No known
vulnerabilities; covered by the security advisory policy.
