# Commerce GoCardless Client — manual setup guide

**Commerce GoCardless Client** (`commerce_gc_client`) integrates Drupal Commerce
with [GoCardless](https://www.drupal.org/project/commerce_gc_client), the bank-to-
bank / Direct Debit payment service. Its appeal is cost: GoCardless fees are
generally much lower than card processors, and it works across 30+ countries and
eight currencies (GBP, EUR, USD, SEK, AUD, NZD, DKK, CAD) — you can collect in any
of them even if your store uses a single currency.

The module supports three payment styles, chosen per product variation:

- **Instant payments** — single payments created at checkout via the open-banking
  protocol (no Direct Debit mandate needed). Currently available to shoppers with
  British or German bank accounts.
- **Subscription payments** — recurring payments GoCardless creates automatically
  on a schedule you define (for example £5 per week), backed by a Direct Debit
  mandate created at checkout.
- **One-off payments** — mandate-backed payments your site triggers on demand or
  on a client-side schedule, for ad-hoc amounts.

It also offers optional recurring orders (a separate order number and confirmation
per payment), a customer-choosable recurrence field, GoCardless webhooks for full
mandate/payment integration, and hooks for other modules to react to mandate and
payment events. There are no third-party libraries to install.

One thing to understand up front: **bank debits are asynchronous.** A payment is
not guaranteed settled at the moment of checkout — it can be confirmed, fail or be
returned days later — so the module relies on GoCardless's **signed webhooks** to
reconcile the real payment state. Handle your GoCardless API token and webhook
secret as secrets, always over HTTPS. It depends on Commerce Payment and Checkout
and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the GoCardless gateway, enter
   your credentials, register the webhook, and set per-variation payment types.

## Where it lives in the admin menu

Like every Commerce gateway, GoCardless is added under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). The per-variation payment settings
are configured on your product variations. See
[Configuration](configuration/index.md).
