# eSewa Payment Gateway — manual setup guide

**eSewa Payment Gateway** (`esewa`) adds Nepal's **eSewa** digital wallet as an
off‑site payment option in **Drupal Commerce**, using the official **eSewa ePay
v2** API. When a customer chooses eSewa at checkout, they are redirected to eSewa's
secure payment page; after paying, eSewa redirects them back to your site with a
base64‑encoded, cryptographically signed response.

The module's central safety feature is that it **verifies that signed response
before it records a payment**. It checks the HMAC‑SHA256 signature through the
official `remotemerge/esewa-php-sdk` library, cross‑checks the transaction against
the value it stored in the session (replay‑attack protection), requires the
returned status to be `COMPLETE`, and confirms the returned amount matches the
order total (within a ±0.01 tolerance). Only when all of those pass does it
complete the Commerce payment and advance checkout — so a forged or tampered
callback cannot fulfil an order.

eSewa processes **NPR (Nepalese Rupee) only**, so your store and order currency
must be NPR. In test mode the module uses eSewa's sandbox credentials
automatically; for production you supply your live merchant credentials.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PHP SDK with
   Composer, and enable it.
2. [Configuration](configuration/index.md) — set your store currency to NPR, add
   the eSewa payment gateway, and store your credentials safely.

## Where it lives in the admin menu

You add and manage eSewa as a Commerce payment gateway at **Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). There is no separate settings page —
the gateway's fields live on that payment‑gateway form.

## How to use it

Once the gateway is configured, eSewa appears as a payment option during Drupal
Commerce checkout for NPR orders. The customer is redirected to eSewa, pays, and is
returned to your site; the module verifies the signed response and, on success,
records the payment and completes checkout. A cancelled or failed payment returns
the customer to checkout so they can retry. You can customise the success and
failure messages shown to customers via the `hook_esewa_success_message()` and
`hook_esewa_failure_message()` hooks.
