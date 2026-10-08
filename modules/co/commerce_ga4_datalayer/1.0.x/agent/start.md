<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce GA4 DataLayer (commerce_ga4_datalayer) — agent index

**Pushes GA4 ecommerce events to window.dataLayer for GTM / gtag.js.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Package:** Commerce (contrib)
- **Dependencies:** commerce_order, commerce_cart, commerce_product, commerce_checkout, token
- **Configure:** `commerce_ga4_datalayer.settings` → `/admin/commerce/config/ga4-datalayer` (`administer commerce ga4 datalayer`, restricted)
- **Services:** `commerce_ga4_datalayer.event_subscriber` (GA4EventSubscriber), `.builder` (GA4DataLayerBuilder), `.helper` (GA4DataLayerHelper)
- **Events:** CART_ENTITY_ADD, commerce_order.place.post_transition, KernelEvents::REQUEST, CART_ORDER_ITEM_REMOVE; hook_user_login/insert for login/sign_up. Extension hook: `hook_commerce_ga4_datalayer_item_alter()`.
- **Security:** Only route is the admin settings form (permission-gated, restricted). No public/mutating endpoints. Events queued in session → flushed to `drupalSettings.ga4Events` as JSON (not raw HTML → no XSS); session read guarded to preserve anonymous page cache. Email hashed with SHA-256. No security findings.

See [configure/events.md](configure/events.md).
