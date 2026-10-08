# Commerce Hyperpay — manual setup guide

**Commerce Hyperpay** (`commerce_hyperpay`) integrates Drupal Commerce with
**HyperPay** (the OPPWA payment platform) using its **COPYandPAY** widget, with an
Apple Pay variant. It is aimed at Middle-East / OPPWA merchants who use HyperPay to
process card payments. Card entry happens on your own page through the COPYandPAY
widget, and every payment is confirmed by re-querying HyperPay's API server-side.

The 2.0.x branch is a full revamp with API changes and no upgrade path from
earlier versions; as of this release it supports the **COPYandPAY** method. It
supports stored payment methods (card reuse), recurring payments and refunds.

This gateway is safe by design: it does not trust the browser return. When a
shopper comes back from paying, the module fetches the authoritative payment status
and amount from HyperPay over a server-to-server call, and it **verifies that the
returned amount matches the expected order amount and that the payment's order ID
matches the returning order** before it captures. A mismatch throws an exception
and the payment is not completed, so a forged browser return cannot fraudulently
capture an order. All API calls send a Bearer token over HTTPS with TLS
verification on. It depends only on Commerce Payment and runs on Drupal 9.3, 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the HyperPay gateway and enter
   your OPPWA credentials.

## Where it lives in the admin menu

Like every Commerce gateway, HyperPay is added under **Administration → Commerce
→ Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
