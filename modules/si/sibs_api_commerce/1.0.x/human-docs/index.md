# SIBS API Commerce — manual setup guide

**SIBS API Commerce** (`sibs_api_commerce`) turns the SIBS payment integration into a
working **Drupal Commerce payment gateway**. With it enabled and configured, your
store can accept payments through SIBS — the widely used Portuguese payment provider —
including Multibanco (MB) reference payments, credit-card payments, and MB WAY. The
customer pays via SIBS off-site, and the module records the payment and completes the
order.

It sits on top of two other modules: the **SIBS API** base module (which holds the
merchant credentials and talks to SIBS) and Drupal Commerce's **Commerce Payment**.
You add it as a payment gateway in the usual Commerce way and pick which SIBS payment
methods you want to offer.

The way it confirms payments is its strongest feature, and worth understanding.
Fulfilment is **API-verified**: both the return handler and the status endpoint call
back to SIBS's authenticated API server-side to re-fetch the real payment status, and
the module only marks a payment `completed` (and moves the order forward) when **SIBS
itself** reports `Success` — the return handler throws on a Declined or Timeout result.
That means the outcome comes from SIBS, not from anything a browser could put in the
request. This is exactly the property you want in a payment gateway.

Store your **merchant credentials as secrets** (via the SIBS API module's env/Key
configuration) and serve the site over HTTPS.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its dependencies.
2. [Configuration](configuration/index.md) — configure the SIBS API and add the
   payment gateway.

## Where it lives in the admin menu

Setup happens in two places: the SIBS API credentials at **`/admin/config/sibs-api`**,
and the payment gateway itself under **Commerce → Configuration → Payment gateways →
Add** (`/admin/commerce/config/payment-gateways/add`), where you select **SIBS API SPG
OFFSITE**. See [Configuration](configuration/index.md).
