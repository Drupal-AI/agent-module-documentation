# Commerce Paymob — manual setup guide

**Commerce Paymob** (`commerce_paymob`) is a Drupal Commerce **payment gateway** for
**Paymob**, a payment provider popular across the Middle East and North Africa
(Egypt, Oman, Saudi Arabia, and the UAE are supported regions). It offers two ways to
take payment:

- **Paymob Redirect** (`paymob_redirect`) — an **offsite** flow: the customer is
  sent to Paymob to pay and then redirected back to your store.
- **Paymob Pixel** (`paymob_pixel`) — an **onsite**, tokenized flow that can store
  reusable card tokens, so returning customers can pay with a saved card.

Both flows share a solid security model. Every callback — the customer return and the
server-to-server webhook — is **verified against your Paymob HMAC secret before any
payment state changes**; a bad or missing signature throws a payment exception rather
than fulfilling the order. The Pixel flow additionally re-checks that the amount
actually charged equals the amount expected. Traffic to Paymob goes over HTTPS to the
region-specific host (TLS is not disabled), and only card **tokens** (with the last
four digits and card subtype) are stored — never full card numbers.

Your Paymob credentials — public key, secret key, API key, one or more payment
integration IDs, and the HMAC secret — are stored as plain gateway configuration, so
protect config exports and access accordingly.

It depends only on Commerce's **Payment** module (`commerce_payment`). Version 2.0.x
is developed and sponsored by Coders Enterprise Web & Mobile Solutions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and configure a Paymob payment
   gateway (Redirect or Pixel).

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway and choosing the **Paymob Redirect** or **Paymob Pixel** plugin.
You then attach it to your checkout flow.
