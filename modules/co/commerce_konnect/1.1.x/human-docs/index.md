# Commerce Konnect — manual setup guide

**Commerce Konnect** (`commerce_konnect`) integrates the **Konnect** payment
gateway (Konnect.network) with Drupal Commerce. Konnect is one of Tunisia's
leading payment gateways, and this module lets a Tunisian merchant accept payments
via **bank cards (Visa, Mastercard)**, **E‑Dinar**, and **Flouci** wallets. The
shopper is redirected to Konnect's secure hosted payment page and returns to your
store afterward.

It is built specifically for the Tunisian market: it handles the **Tunisian Dinar
(TND)** with its correct 3‑decimal (millimes) precision, syncs Drupal order IDs
with Konnect transaction IDs for easy reconciliation, passes billing information
(name and email) to Konnect, and supports both **sandbox** and **live** modes. It
depends on **Commerce Payment** (`commerce_payment`) and supports **Drupal 10 and
11**.

The verification model is the strongest of its kind. When the shopper returns,
`onReturn()` **re‑fetches the transaction server‑side from Konnect's API** (using
Basic authentication) by its payment ID, **rejects order‑ID switching** (the
transaction's order ID must match the order being completed), completes the payment
**only when the API status is `CAPTURED`**, records it using the order's own
total, and is **idempotent** (a repeated return does not create a second payment,
because it dedups on the Konnect transaction ID). The completion decision therefore
always comes from Konnect's authenticated API rather than from anything in the
returning request, so a forged return cannot mark an order paid. Your job is to
store the **Konnect API credentials** securely — environment‑backed, never
committed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Konnect payment gateway,
   enter your credentials, and choose sandbox versus live.

## Where it lives in the admin menu

Konnect is configured as a Commerce **payment gateway** under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Add a new gateway, choose the Konnect
plugin, and configure it as described in [Configuration](configuration/index.md).
