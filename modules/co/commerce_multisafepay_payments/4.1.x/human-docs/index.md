# Commerce MultiSafepay Payments — manual setup guide

**Commerce MultiSafepay Payments** (`commerce_multisafepay_payments`) connects a
Drupal Commerce 2.x store to the **MultiSafepay** payment service provider.
MultiSafepay is a collecting PSP — it handles the agreements, technical plumbing
and collection for a large catalogue of European payment methods — and this module
exposes **70+ of those methods and gift cards** as individual Commerce payment
gateways. Shoppers pick a method (iDEAL, Bancontact, Klarna, PayPal, Sofort, credit
cards, and many national gift cards) and are redirected offsite to MultiSafepay to
pay.

The problem it solves is offering MultiSafepay's full method list without building
each integration yourself. You set one global API key and mode (live/test), then
add one Commerce payment gateway per MultiSafepay method you want to offer at
checkout. It depends on Commerce **Payment** (`commerce_payment`) and Commerce
**Log** (`commerce_log`), and it records payment events through Commerce Log.

This is not a works-on-enable module: it needs configuration (an API key and at
least one gateway). The module talks to MultiSafepay over HTTPS with certificate
verification enabled, and — importantly for correctness — payment confirmation is
**server-authoritative**: the notification handler and return controller re-fetch
the authoritative order status from the MultiSafepay API rather than trusting data
in the incoming request. It can also send shipment tracking back to MultiSafepay on
fulfilment and supports refunds and updates through the API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — set the global API key and mode, then
   add a payment gateway per MultiSafepay method.

## Where it lives in the admin menu

The **global settings** (API key + live/test mode) live at **Configuration →
Commerce MultiSafepay Payments** (`/admin/config/commerce_multisafepay_payments`,
route `commerce_multisafepay_payments.settings`, requiring *Administer site
configuration*). The individual method gateways are added under **Commerce →
Configuration → Payment gateways**.
