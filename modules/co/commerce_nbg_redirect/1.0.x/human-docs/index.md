# Commerce National Bank of Greece (Redirect) — manual setup guide

**Commerce National Bank of Greece (Redirect)** (`commerce_nbg_redirect`) adds the
**National Bank of Greece (NBG)** payment gateway to Drupal Commerce for Greek
stores. It uses an offsite redirect flow built on the **GlobalPayments Hosted
Payment Page**: the shopper is sent to NBG's hosted page to pay and returned to your
site once the payment is confirmed.

The problem it solves is accepting NBG card payments (and digital wallets) without
handling card data yourself. It supports credit cards, **Google Pay and Apple Pay**
(which require separate testing/activation with your merchant account), **3‑D Secure**
authentication, and both **Test and Live** modes. It depends only on Commerce
**Payment** (`commerce_payment`).

This is not a works-on-enable module: you add a Commerce payment gateway of type
**National Bank of Greece (Redirect)** and enter your NBG credentials. On the
customer's return the gateway completes the order.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the NBG payment gateway and enter
   your credentials.

## Where it lives in the admin menu

NBG is a payment gateway, so you set it up under **Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`) → **Add payment
gateway** → choose **National Bank of Greece (Redirect)**.
