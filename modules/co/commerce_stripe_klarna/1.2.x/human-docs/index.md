# Commerce Stripe Klarna — manual setup guide

**Commerce Stripe Klarna** (`commerce_stripe_klarna`) adds **Klarna** — the buy-now-pay-later
method — as a Stripe-backed payment gateway in Drupal Commerce. At checkout it creates a
Stripe **PaymentIntent** for the order and redirects the shopper through Stripe's Klarna
flow. When the shopper returns, the module retrieves the PaymentIntent **directly from
Stripe** and completes the Commerce payment only when Stripe reports it succeeded.

It solves accepting Klarna through your existing Stripe account. This is a **standalone**
gateway — it depends on Commerce Payment and the official `stripe/stripe-php` library, not on
the main Commerce Stripe module — and it ships with a default payment gateway configuration
you can edit to add your keys.

Payment state is driven by Stripe's authoritative API and matched to the stored payment
before completing, so request data cannot mark an order paid; failed or cancelled payments
are voided, and the module avoids marking an already-paid order paid again. Refunds and
partial refunds are supported through Stripe.

Klarna availability is limited to specific countries and currencies. Per Stripe's rules, the
Stripe account and billing-address countries must be in Klarna's supported list (for
example AT, BE, DE, DK, ES, FI, GB, IE, IT, NL, NO, SE, FR and several more), and the
currency must be one of EUR, GBP, DKK, SEK, or NOK (USD for US accounts).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — edit the gateway, enter your Stripe keys, and
   confirm the supported countries/currencies.

## Where it lives in the admin menu

You manage it as a payment gateway at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). Because the module ships a default gateway
config, a **Commerce Klarna Stripe** gateway may already be present after install — edit it
to add your keys, or add a new one. It uses Stripe but does not require the main Commerce
Stripe gateway to be configured first.
