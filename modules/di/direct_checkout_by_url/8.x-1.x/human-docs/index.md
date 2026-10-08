# Direct checkout by URL — manual setup guide

**Direct checkout by URL** (`direct_checkout_by_url`) lets you share a single link
that fills a visitor's cart with specific products and sends them straight to the
checkout page, skipping the catalogue and the product pages entirely. It is a
conversion shortcut for Drupal Commerce: an email that offers a specific bundle, an
ad that should land on payment rather than on a listing, a renewal link that drops
the same subscription back in the basket, or a QR code on packaging that reorders a
refill. Each removes several steps between a shopper's intent and their purchase.

The module adds one endpoint, `/direct-checkout-by-url`, that reads the products
from the URL and builds the cart from them. You can pass a simple comma-separated
list of SKUs — `?products=1234,5678` adds one of each — or an array that also
carries quantities — `?products[0][sku]=1234&products[0][quantity]=2`. By default
the visitor is then forwarded to checkout, but you can send them elsewhere with
Drupal's standard `destination` query parameter (for example
`?products=123&destination=cart` lands them on the cart instead).

It builds on Drupal Commerce and requires four of its modules — Product, Order,
Cart, and Checkout — so it only makes sense on a site that already runs Commerce.
Two permissions gate it: `use direct checkout` controls who may use the endpoint,
and `administer direct checkout by url` controls the settings page.

A word of caution before you build campaign links with it. **A URL that fills a
cart is a URL anyone can craft**, so prices, quantities, and any discount must
always be resolved server-side from the product itself, never trusted from the
link. And **campaign links are shared and archived**, so treat them as permanently
public — a link that carries a discount is effectively a discount code with no
expiry unless you design one in.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Commerce, and grant the two permissions.
2. [Configuration](configuration/index.md) — where the settings page lives and how
   to grant access safely.

## Where it lives in the admin menu

The module's own settings form is exposed through the
`direct_checkout_by_url.settings` route and requires the **Administer direct
checkout by URL** permission. The working part of the module, though, is the public
endpoint `/direct-checkout-by-url`, which you link to from your emails, ads, or
codes.
