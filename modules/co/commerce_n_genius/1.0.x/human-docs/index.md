# Commerce N-Genius — manual setup guide

**Commerce N-Genius** (`commerce_n_genius`) adds **Network International's N-Genius**
hosted payment gateway to Drupal Commerce as an offsite (redirect) payment method.
N-Genius is widely used across the Middle East, particularly the UAE. At checkout
the shopper is redirected to the N-Genius hosted page to enter card details, and on
return the module queries N-Genius for the transaction's 3‑D Secure result.

The problem it solves is accepting card payments through N-Genius without hosting
card data yourself — the sensitive card entry happens entirely on N-Genius's pages.
It depends only on Commerce **Payment** (`commerce_payment`).

This is not a works-on-enable module: you add a Commerce payment gateway of type
**N-Genius**, supply your Outlet reference and API key, and choose live or test
mode. On return, the module exchanges your credentials for an OAuth
client-credentials access token and fetches the order's payment status over HTTPS,
completing checkout when the 3‑D Secure status is *SUCCESS*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the N-Genius payment gateway and
   enter your Outlet reference, API key and mode.

## Where it lives in the admin menu

N-Genius is a payment gateway, so you set it up under **Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) → **Add payment
gateway** → choose the **N-Genius** plugin.
