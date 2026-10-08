# Monobank — manual setup guide

**Monobank** (`monobank`) lets a Drupal store accept payments through
[Monobank](https://www.monobank.ua/), the Ukrainian bank's acquiring API. It
adds a payment method that creates a Monobank invoice, sends the customer off to
pay, and then records the result back in your store. It plugs into the
**AlternativeCommerce (Basket)** ordering system rather than Drupal Commerce.

The module registers a payment service you attach to a payment point in Basket's
settings, and it has its own settings page for the Monobank acquiring **token**
and a test-mode switch. It needs configuration before it can take payments — at
minimum you must enter your Monobank token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the Monobank token safely, set
   up the Basket payment point, and test the payment flow.

## Where it lives in the admin menu

- The gateway's own settings are at **`/admin/config/development/monobank`**
  (config route `monobank.settings`).
- You first create a payment point under Basket's payment settings at
  **`/admin/basket/settings-payment`** and select "Monobank" as its service;
  Basket then gives you a button through to the gateway settings above.

## Payment status callback

Monobank posts payment status updates to **`/monobank/status`**, which records the
payment as paid and runs the order's fulfilment step. Always serve the site over
HTTPS. The details are in [Configuration](configuration/index.md).
