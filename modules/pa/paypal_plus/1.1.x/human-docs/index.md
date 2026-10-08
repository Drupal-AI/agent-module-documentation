# Paypal Plus — manual setup guide

**Paypal Plus** (`paypal_plus`) is a lightweight, standalone PayPal payment
integration — it lets a site take a one-off PayPal payment *without* installing
Drupal Commerce. It talks to PayPal through the modern **Orders v2 REST API** and
gives you three ways to collect a payment: a simple "pay this amount" form, a
placeable **pay block**, and a **Webform submit handler** that sends a submission
off to PayPal.

Under the hood it exposes a `paypal_plus` service whose `paypalPay()` method
creates a PayPal order and redirects the buyer to PayPal's approval page. When the
buyer returns, the module calls PayPal server-to-server to *capture* the order and
only reports success when PayPal itself says the payment is `COMPLETED` — success
is never inferred from the return URL's query parameters. A set of hooks lets you
plug in your own fulfilment logic, success/failure messages, and redirect targets.

This is aimed at sites that want to collect a payment — a donation, a fee, an
event ticket, a pay-what-you-want amount — with minimal code and no full commerce
stack. It depends only on core's **Block** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your PayPal API credentials,
   pick the currency, and switch between sandbox and live.

## Where it lives in the admin menu

The settings form is at **`/admin/paypal-configurations`** (route
`paypal_plus.configurations`), gated by the **Administer site configuration**
permission. That is where you enter your PayPal client ID/secret, currency, and
sandbox/live mode.

## How to use it

After you have configured your credentials, choose one of the three entry points:

- **Pay block** — go to **Structure → Block layout**, place the PayPal pay block
  in a region, and visitors can enter an amount and pay.
- **Webform handler** — on a Webform, add the PayPal handler; map the amount to a
  form field (or set a fixed default amount) and the submitter is redirected to
  PayPal after submission.
- **Service call** — from custom code, call the `paypal_plus` service directly,
  for example:

  ```php
  $provider = \Drupal::service('paypal_plus');
  $provider->paypalPay(['amount' => '10', 'currency_code' => 'USD']);
  ```

### A note on order fulfilment

The return handler is authoritative about *whether PayPal took the money* — it
re-fetches and captures the order from PayPal, so a forged return URL cannot mark
a payment as complete. However, this module does **not** by itself bind the
captured amount to any Drupal order entity or grant anything to the buyer.
Fulfilment (recording the payment, granting access, sending goods) is delegated to
**your** hook implementations — for example `hook_paypal_plus_success_redirect()`
or `hook_paypal_plus_set_item_ids()`. If you rely on this module for real sales,
make sure your fulfilment code verifies the captured amount and currency match
what you expected before delivering anything.
