<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# "Share cart" button, modal & builder

Turns the current cart into a shareable `/cart-links` URL.

## The builder service
- Service id `commerce_cart_links.cart_links_builder`, class `CartLinksBuilder` implements
  `CartLinksBuilderInterface`.
- `buildUrl(OrderInterface $order): Url` iterates `$order->getItems()`, emits
  `purchasedEntity->id() . '-' . intval(quantity)` per item, and returns an **absolute** `Url` for
  route `commerce_cart_links.process_cart_links` with query `existing=empty` and `products[]` set.
  (Result path looks like `/cart-links/57-2/384-1?existing=empty`.)

## The Views area button
- `hook_views_data_alter()` (`commerce_cart_links.views.inc`) adds a `share_cart_button` area to
  `commerce_order`, handler id `commerce_cart_links_share_cart_button`.
- Plugin `ShareCartButton` (`#[ViewsArea("commerce_cart_links_share_cart_button")]`) renders nothing
  from `render()`; it builds a **views form** (`viewsForm`, shown even when empty via
  `viewsFormEmpty`) containing a `#type => link` to route
  `commerce_cart_links.share_cart_modal` for the view's `order_id` argument, with
  `use-ajax` + `data-dialog-type: modal` and `core/drupal.ajax` attached. The link's `#access` is the
  modal route's own access. The form sets `max-age => 0` (never cached).

## The modal
- Route `commerce_cart_links.share_cart_modal` → `/commerce_cart_links/share-cart-modal/{commerce_order}`
  → `ShareCartModalController::modal`. Renders a textfield holding
  `CartLinksBuilder::buildUrl($order)->toString()` plus a `#theme => commerce_copy_link` copy button.
- Access (`ShareCartModalController::checkAccess`): the order must be a cart
  (`$order->get('cart')->value`) **and** be one of the current user's cart ids
  (`cartProvider->getCartIds($account)`), **and** the user must have the
  `generate cart share links` permission. This prevents generating a share link for another user's
  cart.

## To place it
Add the "Share cart button" area handler to a cart/order View (header or footer). The button opens
the modal for that order and shows the copyable link.
