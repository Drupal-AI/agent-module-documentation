# Commerce Qliro Checkout — manual setup guide

**Commerce Qliro Checkout** (`commerce_qliro_checkout`) integrates
[Qliro Checkout](https://qliro.com/) — a Nordic payment and checkout provider —
with Drupal Commerce as an **off-site payment gateway**. Instead of building your
own card form, you hand the shopper off to Qliro's embedded checkout, and Qliro
handles the payment. When the customer comes back, the module reads the
authoritative order state from Qliro's server-side Merchant API and updates the
Commerce order accordingly.

The problem it solves is regional: Qliro is a popular way to pay in the Nordics
(invoice, instalments, cards), and this module is the bridge that lets a Drupal
Commerce store accept it. It exposes the callback and shipping-method endpoints
Qliro needs, embeds Qliro's checkout, and drives the order through Qliro's
Merchant API. Its only hard dependency is Commerce's Payment module
(`commerce_payment`), and it runs on Drupal 10 and 11.

This is not a "works on enable" module — like every payment gateway it does
nothing until you add and configure a Qliro gateway with your API credentials.
One detail worth knowing: the module's validation callback
(`/commerce_qliro_checkout/validate/{gateway}`) is reachable anonymously, but in
this release its handler is a no-op. Order completion is driven by calls to
Qliro's server-side Merchant API, and the amount recorded against the order is
read from that authenticated response. Keep your Qliro API credentials out of
code and configuration exports (see the configuration guide).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Payment.
2. [Configuration](configuration/index.md) — add the Qliro payment gateway and
   enter your API credentials safely.

## Where it lives in the admin menu

Commerce Qliro Checkout has no standalone settings page of its own. Like all
Commerce payment methods, you set it up as a **payment gateway** under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Click **Add payment gateway**, pick
Qliro Checkout, and fill in the form described in
[Configuration](configuration/index.md).
