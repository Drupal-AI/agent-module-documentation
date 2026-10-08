# PayTR Virtual Pos iFrame API — manual setup guide

**PayTR Virtual Pos iFrame API** (`paytr_payment`) is a Drupal Commerce payment
gateway for **PayTR**, a Turkish payment service provider. It takes card payments
through PayTR's hosted **iFrame** checkout: at checkout the shopper is redirected
into PayTR's PCI-DSS Level 1 secure payment page, enters their card details there,
and PayTR then notifies your site of the result.

Because PayTR is an off-site (redirect) gateway, the sensitive card handling never
touches your server. When PayTR finishes processing, it sends an asynchronous
**callback** to your site, and this module completes the Commerce order only when
that callback is genuine. It also adds a small settings form for configuring
**installment options** per product collection.

To use it you need a **PayTR merchant account**, from which you copy three values —
the **Merchant ID**, **Merchant Key**, and **Merchant Salt** — into the gateway
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Commerce, then enable it.
2. [Configuration](configuration/index.md) — add the PayTR gateway with your
   merchant credentials, and (optionally) set up installment options.

## Where it lives in the admin menu

Two places matter:

- The **payment gateway** (where your PayTR merchant credentials live) is added
  under **Commerce → Configuration → Payment gateways**
  (`/admin/commerce/config/payment-gateways`).
- The **installment settings form** is at **`/admin/commerce/config/paytr-settings`**
  (route `paytr_payment.settings`).

## How order completion is protected

PayTR POSTs its payment result to `/paytr-payment/callback`. The module does **not**
trust that request blindly: it recomputes an **HMAC-SHA256** signature over the
order reference, salt, status, and amount (keyed with your Merchant Key) and marks
the Commerce payment and order **completed** only when that computed hash matches
the hash in the callback **and** the reported status is `success`. Otherwise the
order is set to *canceled*. Because both the authenticity **and** the paid amount
are covered by the signature, a forged or tampered callback cannot complete an
order. A route access check additionally requires that the order referenced by the
callback actually exists before the handler runs.
