# Commerce Eurobank — manual setup guide

**Commerce Eurobank** (`commerce_eurobank_redirect`) is an off‑site redirect
payment gateway for the **Eurobank / Modirum vPOS** platform (Greece). At checkout
the shopper is redirected to the Eurobank vPOS to enter their card details, and
Eurobank posts the transaction result back to your site as a callback. The module
validates each callback's **SHA‑256 digest** against the order's shared secret
before completing payment, so a forged or tampered callback is rejected. Because
card data is entered on the bank's page, nothing sensitive is stored on your
Drupal site.

It depends on Drupal Commerce and its **Payment** module (`commerce`,
`commerce_payment`). Nothing happens on enable alone — you add and configure a
gateway of type *Eurobank Payment Redirect* with your merchant id, currency,
confirm/cancel URLs, the vPOS post URL and, crucially, the shared secret issued by
Eurobank, and point Eurobank's confirm/cancel URLs at the module's callback route.

Security here is sound: the digest is `base64(sha256(response fields +
shared_secret))`, compared strictly (`!==`), and a completed payment is only
created when the digest matches **and** the status is CAPTURED/AUTHORIZED. The
payment amount is taken server‑side from the order balance, not from the raw
callback amount, and the order is resolved from the signed `orderid`. The one
must‑do is changing the default `shared_secret` (which ships as the literal
`"SECRET"`) to the value Eurobank issues you — see Configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Eurobank gateway, set the
   shared secret and URLs, and wire up the callback.

## Where it lives in the admin menu

Commerce Eurobank has no settings page of its own. Like every Commerce payment
method, it is added under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by adding a gateway and
choosing the **Eurobank Payment Redirect** plugin.
