# Commerce Mercado Pago — manual setup guide

**Commerce Mercado Pago** (`commerce_mercado_pago`) is a Drupal Commerce payment
gateway for **[Mercado Pago](https://www.mercadopago.com/)**, the payment platform
widely used across Latin America. It implements Mercado Pago's **Checkout Pro**
flow: the customer is sent to Mercado Pago to pay and then returns to your store,
where the module records the payment.

The gateway offers two redirect styles for Checkout Pro — **Redirect** (the
default, which sends the customer within the same browser window) and **External
redirect** (which opens the checkout in a new window) — and, in this 3.0 release,
adds **installments** support, per-country payment methods, the ability to
**exclude** specific payment methods or types, refunds (initiated on your site or
in Mercado Pago), richer product/customer data sent to Mercado Pago, and a
debugging mode with cleaner logs. It works alongside the Commerce Shipment module.

Payment results are handled safely: when the customer returns, the module
**verifies the payment with the Mercado Pago API before trusting the return query
parameters**, and it also implements an `onNotify()` **IPN webhook** — so an
order is only marked paid based on Mercado Pago's authenticated answer, not on
forgeable request data. It depends on Drupal Commerce's Payment module and the
Mercado Pago PHP SDK (3.x), and targets **Drupal 9, 10, and 11**. Note this module
is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Mercado Pago gateway, choose
   the environment, and enter your public key and access token.

## Where it lives in the admin menu

Commerce Mercado Pago adds no admin page of its own. Like every Commerce payment
gateway, you configure it under **Administration → Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`), where you add a
new gateway of type **Mercado Pago (Checkout Pro)**.
