<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Stripe — manual setup guide

**Commerce Stripe** (`commerce_stripe`) connects [Stripe](https://stripe.com) to
Drupal Commerce so your store can take card and wallet payments. It provides Stripe
payment-gateway plugins, Strong Customer Authentication (SCA / 3D Secure),
express checkout with Apple Pay and Google Pay, and Stripe Connect — and it lets
you offer many local payment methods (Klarna, Affirm, Cash App, ACH bank debit,
Alipay, WeChat Pay, Amazon Pay, Link) through a single gateway.

It ships two gateway plugins. **Stripe Payment Element** (`stripe_payment_element`)
is the modern, recommended choice, built on Stripe's PaymentIntents and the Payment
Element UI. **Stripe Card Element** (`stripe`) is the older, on-site card form kept
for backwards compatibility. You add a gateway under Commerce's payment-gateway
configuration, choose test or live mode, and provide your Stripe API keys (or
connect an account with Stripe Connect OAuth).

To keep payment status in sync — captures, refunds, disputes, asynchronous
methods — Stripe sends **webhooks** back to your site, verified with a signing
secret you store on the gateway. A bundled submodule,
**commerce_stripe_webhook_event**, logs and processes those incoming events.
Developers can adjust the PaymentIntent and express-checkout behavior through
events — see the [`agent/`](../agent/start.md) docs.

> **Handle your Stripe secret key carefully.** The secret key (`sk_live_…`) is a
> credential that must never be committed to your repository or exported
> configuration. The [Configuration](configuration/index.md) page shows how to keep
> it in an environment variable using DDEV's dotenv support rather than in plain
> config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Stripe PHP library) and enable the module.
2. [Configuration](configuration/index.md) — add and configure the Stripe gateway,
   store your API keys securely, set up the webhook, and the global settings.

## Where it lives in the admin menu

- Global settings: **Commerce → Configuration → Stripe settings**
  (`/admin/commerce/config/stripe`).
- The gateway itself: **Commerce → Configuration → Payment gateways**
  (`/admin/commerce/config/payment-gateways`).

## How to use it

1. Install the module and enable it (see [Installation](installation/index.md)).
2. Add a Stripe payment gateway, choose the Payment Element plugin, set test mode,
   and provide your test API keys.
3. Configure the Stripe webhook so payment status stays in sync.
4. Test a checkout with Stripe's test cards, then switch to live mode with your
   live keys. See [Configuration](configuration/index.md) for each step.
