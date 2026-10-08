<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Facebook Pixel Commerce is the Drupal Commerce bridge for Facebook Pixel: it fires `ViewContent` on product pages, `AddToCart` when an item is added to a cart, `InitiateCheckout` on the first real checkout step and `Purchase` when an order is placed.

---

The submodule depends on `facebook_pixel` and `commerce_checkout` and adds no configuration of its own. `FacebookCommerce` (service `facebook_pixel_commerce.facebook_commerce`) builds the two payload shapes: `getOrderData(OrderInterface $order)` returns `value` (the rounded total, always a string), `currency`, `num_items`, `content_name: 'order'`, `content_type: 'product'` plus `contents`/`content_ids` collected from the order items, and `getOrderItemData(OrderItemInterface $order_item)` returns the unit price, currency, `order_id`, the purchased entity's SKU (falling back to the purchased entity id) in `content_ids`/`contents[0].id`, the item title and its quantity. `CartSubscriber` (service `facebook_pixel_commerce.cart_subscriber`) listens to `CartEvents::CART_ENTITY_ADD` → `addEvent('AddToCart', …, TRUE)` — forcing a session so the event survives the redirect — and to `commerce_order.place.post_transition` → `addEvent('Purchase', …)`. `hook_ENTITY_TYPE_view()` for `commerce_product` in the `full` view mode fires `ViewContent` with every variation's SKU in `content_ids`, a `contents` array of `{id, value, quantity}`, `content_type` of `product` or `product_group` depending on whether the product has more than one variation, and `value`/`currency` from the default variation. Finally the checkout pane plugin `facebook_checkout` (`@CommerceCheckoutPane`, default step `order_information`, label "Facebook Pixel Commerce: Trigger 'InitiateCheckout' Event (order_information)") queues `InitiateCheckout` with the order payload from `buildPaneForm()`, guarded so it only fires on a non-XHR request. That pane is **not** added to any checkout flow automatically — you must place it on `/admin/commerce/config/checkout-flows`, on the first step after login.

---

- Report Facebook `Purchase` conversions with real order totals from Drupal Commerce.
- Report `AddToCart` events with SKU, unit price, currency and quantity.
- Report `InitiateCheckout` when a customer reaches the order-information step.
- Report `ViewContent` on Commerce product pages with all variation SKUs.
- Distinguish single products from variation groups via `content_type: product` / `product_group`.
- Feed Meta's catalogue matching using SKUs as `content_ids`.
- Measure add-to-cart → checkout → purchase funnel drop-off in Meta Events Manager.
- Build Meta Advantage+ / dynamic product ads from the emitted product events.
- Attribute ad spend to actual order revenue rather than page views.
- Track checkout initiation on a custom checkout flow by placing the pane there.
- Move `InitiateCheckout` to a later step by moving the pane in the checkout flow.
- Disable checkout tracking entirely by removing the pane from the flow.
- Use `getOrderData()` from custom code to build a consistent order payload.
- Use `getOrderItemData()` to report a single line item in a custom event.
- Swap SKUs for product ids in `content_ids` with `hook_facebook_pixel_event_data_alter()`.
- Add a custom dimension (campaign, channel) to Purchase payloads via the same alter hook.
- Report the currency correctly on multi-currency stores through `commerce_price.rounder`.
- Avoid duplicate `InitiateCheckout` events on Ajax refreshes (the pane skips XHR requests).
- Keep cart events across the redirect that follows an add-to-cart submit.
- Combine with the parent module's role/path visibility to exclude staff from conversion data.
- Exclude the checkout pages from tracking while still reporting the final Purchase.
- Validate the payload shape in a staging store before spending on ads.
- Debug a missing Purchase event by checking the `commerce_order.place.post_transition` subscriber.
- Provide server-rendered event data for a Commerce store that has no front-end tag manager.
