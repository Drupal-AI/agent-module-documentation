# Commerce Cart Links — manual setup guide

**Commerce Cart Links** (`commerce_cart_links`) lets you build **URLs that
manipulate a customer's shopping cart through query parameters**. A single link
can empty or replace an existing cart, add one or more products with set
quantities, apply a coupon, target a specific store, and then redirect the shopper
to a landing page. It's the kind of link you drop into a marketing email, a
printed QR code, a Google Merchant Center ad, or a partner's site so that clicking
it lands the customer in a pre‑filled basket — or takes them straight toward
checkout.

This revives a much‑loved Drupal Commerce 1 feature for Commerce 3. Beyond
campaign links, it also provides a **share‑cart modal**: a customer can generate a
link to their own basket and send it to a colleague — a genuinely useful B2B
approval flow. All links are handled by the `/cart-links` route; the path and
query parameters after it describe what happens to the cart (for example
`/cart-links/57-2` adds two of product variation 57).

The access model is layered and worth understanding before you launch a campaign.
The `/cart-links` route runs a custom access check that validates the query
parameters, **checks the HTTP referer**, and requires the **`view commerce cart
links`** permission. There is a separate `generate cart share links` permission
for the share feature, and an administer permission for the settings form. Two
things to design around, covered in detail in [Configuration](configuration/index.md):
the referer check is what stops other sites from firing cart manipulations at your
customers, but a referer is frequently absent (email clients, QR scans,
`noreferrer` links), so links can silently return 403 if the allowed‑referer
setting doesn't cover your channels; and the `existing=delete` parameter discards
the customer's current cart, so decide deliberately whether campaign links should
be able to do that.

Commerce Cart Links depends on Commerce **Cart** (`commerce_cart`) and works on
Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Cart.
2. [Configuration](configuration/index.md) — the settings form, the permissions,
   the referer check, and how to build the link URLs.

## Where it lives in the admin menu

Once enabled, the settings form is at **Commerce → Configuration → Orders → Cart
Links** (`/admin/commerce/config/orders/cart-links`). Access to it is restricted
to users with the module's administer permission.
