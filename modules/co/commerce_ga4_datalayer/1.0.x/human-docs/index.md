# Commerce GA4 DataLayer — manual setup guide

**Commerce GA4 DataLayer** (`commerce_ga4_datalayer`) pushes standard **GA4
Enhanced Ecommerce** events to `window.dataLayer`, ready to be consumed by Google
Tag Manager, gtag.js, or any tag-management solution. If you run Drupal Commerce
and want GA4 e-commerce reporting without hand-writing dataLayer pushes into every
Twig template, this module builds the correct event payloads for you.

It fires the full set of GA4 commerce events — `view_item`, `add_to_cart`,
`remove_from_cart`, `view_cart`, `begin_checkout`, `add_shipping_info`,
`add_payment_info`, `purchase`, `add_to_wishlist`, `login` and `sign_up` — and
each one can be toggled on or off independently. Core Commerce fields (SKU, title,
price, quantity, affiliation, promotions, coupons) are mapped automatically, and
you can map extra item parameters such as `item_brand`, `item_variant` or
`item_size` to product/variation fields using the **Token** module. It even walks
up to three taxonomy parent levels into `item_category`, `item_category2` and
`item_category3` for a hierarchical category tree.

Under the hood it queues events in the PHP session and flushes them to
`drupalSettings` on the next page load, so timing lines up with the GTM container
and AJAX-heavy flows don't fire duplicate events. It does **not** ship Google Tag
Manager or gtag.js — you still need a tag-management solution configured
separately to read `window.dataLayer`. It depends on Commerce (Order, Cart,
Product, Checkout) and the **Token** module, with Commerce Wishlist and Commerce
Shipping as optional companions for the wishlist and shipping events. It runs on
Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — choose which events fire, map item
   parameters to tokens, and exclude staff roles.

## Where it lives in the admin menu

The settings form is at **Commerce → Configuration → GA4 DataLayer**
(`/admin/commerce/config/ga4-datalayer`), reachable by users with the *Administer
commerce GA4 DataLayer* permission. That is where you toggle events, define token
mappings, and exclude roles.
