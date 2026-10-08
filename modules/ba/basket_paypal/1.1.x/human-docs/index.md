# Basket PayPal — manual setup guide

**Basket PayPal** (`basket_paypal`) adds PayPal payment to the **Basket** store
module. On the front end it uses PayPal's JavaScript SDK ("Smart Buttons"), and
on the back end it talks to the **PayPal Orders API from your server** to create
and capture the payment. It only makes sense on a site already running Basket.

The important thing to know about any payment module is where it decides an order
is actually paid, and Basket PayPal gets this right (this was verified in the
source). The order is **created server‑side** with the order's amount, and when
the buyer approves, the payment is **captured server‑side** — the module reads
the capture status from PayPal's own API response and only fulfils the order when
that status is `COMPLETED`. It does **not** trust a "paid" flag sent from the
browser, and the amount is fixed server‑side at order creation, so a tampered
client cannot change what is charged.

That said, this module handles money and secrets, so treat it accordingly. You
will configure a PayPal **client ID** and **client secret**; the client secret is
a credential and must be kept out of committed configuration — store it in an
environment variable (or a Key entity) rather than in an exported `.yml` file.
And run the whole checkout over **HTTPS**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Basket must be present first).
2. [Configuration](configuration/index.md) — entering PayPal credentials safely,
   sandbox vs live, and HTTPS.

## Where it lives in the admin menu

Basket PayPal is configured as a payment method within the **Basket** store — you
set its PayPal credentials in the module's settings. See
[Configuration](configuration/index.md).
