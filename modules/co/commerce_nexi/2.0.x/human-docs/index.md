# Commerce Nexi — manual setup guide

**Commerce Nexi** (`commerce_nexi`) adds **Nexi (XPay)** as an offsite payment
gateway for Drupal Commerce. Nexi is a major European payment provider; this module
builds a signed request to the Nexi **hosted checkout** page, redirects the shopper
there to pay, and brings them back to your store afterwards. It also provides a Nexi
**credit-card payment-method type** for the checkout flow.

The problem it solves is accepting Nexi/XPay card payments without hosting card data
yourself. It depends on Drupal Commerce and Commerce **Payment**
(`commerce_payment`).

This is not a works-on-enable module: you add a Commerce payment gateway of type
**Nexi**, enter your merchant alias and MAC secret, and choose test or live mode.
Outbound requests to Nexi are signed with a MAC (message authentication code) the
module computes, and on return the payment is confirmed **server-side** — the
gateway re-fetches the payment from Nexi's API rather than trusting the returned
query string.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Nexi payment gateway and enter
   your merchant alias and MAC secret.

## Where it lives in the admin menu

Nexi is a payment gateway, so you set it up under **Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) → **Add payment
gateway** → choose the **Nexi** plugin.
