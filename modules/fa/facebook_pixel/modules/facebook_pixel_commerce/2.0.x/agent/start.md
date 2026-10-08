<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Facebook Pixel Commerce — agent index

Submodule of [`facebook_pixel`](../../../../2.0.x/agent/start.md). Adds four Drupal Commerce
events to the pixel. **No config object, no settings form, no routes, no permissions, no
`configure` route** — the only thing a site builder must do is place one checkout pane.

- **Which event fires when, and the exact payload shape of each** →
  [api/events.md](api/events.md)
- **Placing the `facebook_checkout` pane in a checkout flow** →
  [configure/checkout-pane.md](configure/checkout-pane.md)

Quick facts:

| Thing | Value |
|---|---|
| Dependencies | `facebook_pixel`, `commerce:commerce_checkout` (pulls in `commerce_cart`, `commerce_order`, `commerce_price`) |
| Services | `facebook_pixel_commerce.facebook_commerce` (`FacebookCommerce`), `facebook_pixel_commerce.cart_subscriber` (`CartSubscriber`) |
| Checkout pane plugin | `facebook_checkout`, `default_step = order_information` |
| Events | `ViewContent` (product, `full` view mode), `AddToCart`, `InitiateCheckout`, `Purchase` |
| Subscribed events | `CartEvents::CART_ENTITY_ADD`, `commerce_order.place.post_transition` |
| Alter hook | the parent's `hook_facebook_pixel_event_data_alter()` sees all of these |

Pane gotcha: a pane missing from `configuration.panes` is **not** off — it runs on its
plugin `default_step` (`order_information`). Disable it with an explicit `step: _disabled`.
See [configure/checkout-pane.md](configure/checkout-pane.md).
