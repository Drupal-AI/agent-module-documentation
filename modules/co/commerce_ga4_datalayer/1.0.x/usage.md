<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce GA4 DataLayer pushes GA4 ecommerce events (view_item, add_to_cart, purchase, and more) to window.dataLayer for consumption by Google Tag Manager or gtag.js.
---
The module wires Drupal Commerce lifecycle events into a GA4-shaped dataLayer without any custom JavaScript. A `GA4EventSubscriber` listens to cart add/remove, order place transition, kernel request (for checkout-step detection) and user login/insert; `GA4DataLayerBuilder`/`GA4DataLayerHelper` build standard GA4 item payloads (SKU, promotion-adjusted price, coupon, hierarchical taxonomy categories resolved through Token), queue them in the PHP session, and `hook_page_attachments` flushes the queue into `drupalSettings.ga4Events` on the next page load for the shipped JS to push. Editors choose which events fire and map custom item params (item_brand, item_variant, item_category) to product/variation tokens.

The only route is the admin settings form at `/admin/commerce/config/ga4-datalayer`, gated by `administer commerce ga4 datalayer` (restrict access: true). There are no mutating public endpoints; the session read is guarded so it does not break the anonymous page cache. Token replacement is emitted as JSON into drupalSettings (not raw HTML) so there is no XSS, and the login event hashes the user email with SHA-256. Set up by enabling the events you want and mapping any custom item params on the settings page.
---
- Emit GA4 ecommerce events to window.dataLayer for GTM/gtag
- Toggle individual events (view_item, add_to_cart, remove_from_cart, view_cart)
- Fire begin_checkout / add_shipping_info / add_payment_info by checkout step
- Track purchase transactions with tax/shipping breakdown
- Report discounted (promotion-adjusted) unit prices
- Capture coupon codes and promotion id/name per line item
- Map item_brand to a product token
- Map item_variant / item_size to variation attribute tokens
- Configure a hierarchical item_category walking taxonomy parents
- Add arbitrary custom GA4 item params by name
- Exclude admin/staff roles from tracking
- Hash user email into the login event for GA4 user identification
- Distinguish first-time vs returning login
- Emit sign_up on user registration
- Programmatically queue a custom event from another module (builder API)
- Build a select_item event from a listing click
- Add add_to_wishlist via a custom subscriber
- Alter item payloads via hook_commerce_ga4_datalayer_item_alter()
- Decorate the helper service to override buildItemData()
- Feed GTM ecommerce reports without editing theme JS
