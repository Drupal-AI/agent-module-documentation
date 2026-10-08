# Commerce Klarna Payments — manual setup guide

**Commerce Klarna Payments** (`commerce_klarna_payments`) provides a Drupal
Commerce **payment gateway** for **Klarna Payments**. The customer completes
payment through Klarna's off‑site / hosted flow — Klarna's JavaScript widget
captures an authorization token — and Klarna then notifies your store of the
order's status through a **push endpoint**. It's the "Klarna as one payment
option at checkout" integration (as opposed to Klarna's full hosted *Checkout*).

It depends on **Commerce Payment** (`commerce_payment`) and **Commerce Price**
(`commerce_price`), and requires **PHP 8.0+**.

The push endpoint is built the right way. Rather than trusting whatever the push
request contains, the controller **re‑fetches the order from Klarna's
authenticated API** (`getOrder`) and acts only on **verified statuses** —
`AUTHORIZED`, `PART_CAPTURED`, and `CAPTURED`. So a forged push to the endpoint
**cannot** mark an order paid: authenticity comes from the module's own
authenticated call back to Klarna. This is exactly the pattern you want from a
notification callback. Your responsibilities are to store the **Klarna API
credentials** as secrets and to confirm the correct **region/environment (test vs
live)**.

Note this release is a beta (`3.0.0-beta7`) and the project is marked *not
covered* by Drupal's security advisory policy, so test thoroughly before going
live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Klarna Payments gateway,
   enter your credentials, choose region and environment, and register the push
   endpoint with Klarna.

## Where it lives in the admin menu

Klarna Payments is configured as a Commerce **payment gateway** under
**Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Add a new gateway, choose the Klarna
Payments plugin, and configure it as described in
[Configuration](configuration/index.md).
