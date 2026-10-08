# Commerce Stripe Checkout — manual setup guide

**Commerce Stripe Checkout** (`commerce_stripe_checkout`) is a Drupal Commerce payment
gateway that uses **Stripe Checkout**, Stripe's hosted, pre-built payment page. Instead of
embedding a card form on your site, customers are redirected to Stripe's secure hosted page
to pay; afterwards Stripe redirects them back and the order is confirmed and unlocked through
Commerce's standard workflow. No card details ever touch your server, so the integration is
PCI-DSS compliant out of the box.

It solves the "accept many payment methods with minimal effort" problem: a single gateway
instance can offer any of the 57 Stripe Checkout payment methods (Card with Apple Pay and
Google Pay, Link, Klarna, iDEAL, SEPA Direct Debit, ACH, Alipay, WeChat Pay, PayPal, and
more), with asynchronous confirmation via webhook for methods where the result arrives after
the customer leaves checkout. It supports full and partial refunds, zero-decimal currencies,
and a locale setting for the hosted page. It depends on the Commerce order, cart, and payment
stack.

The gateway has built-in safeguards: a per-checkout CSRF/replay token embedded in the return
URLs and verified on callback, an idempotency guard so a webhook and a redirect can never
create duplicate payments, and automatic recovery when a configured payment method is not yet
activated in your Stripe Dashboard. As part of setup you also configure the **webhook signing
secret** so incoming Stripe events are verified — see [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add the gateway, choose payment methods, set
   the webhook and its signing secret.

## Where it lives in the admin menu

You add and manage it at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) — choose **Add payment gateway** and select the
Stripe Checkout plugin. The gateway also exposes a webhook endpoint at
`/stripe-pay/webhook/{gateway_id}` that you register in your Stripe Dashboard.

## A word on the webhook signing secret

The webhook endpoint verifies each incoming event against the **webhook signing secret**
(`whsec_…`) from your Stripe Dashboard webhook endpoint. Configure it on the gateway as part of
setup: with the signing secret in place, every incoming event is checked against Stripe's
`Stripe-Signature` header and events that do not validate are rejected with HTTP 400. Copy it from
the Stripe Dashboard before going to production. Details are in
[Configuration](configuration/index.md).
