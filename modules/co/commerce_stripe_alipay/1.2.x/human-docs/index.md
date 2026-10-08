# Commerce Stripe Alipay — manual setup guide

**Commerce Stripe Alipay** (`commerce_stripe_alipay`) adds **Alipay** as a Stripe-backed
payment method in Drupal Commerce. It is an off-site payment gateway: at checkout it creates
a Stripe **PaymentIntent** for the order and redirects the shopper through Stripe's Alipay
flow. When the shopper returns, the module retrieves the PaymentIntent **directly from
Stripe** and completes the Commerce payment only when Stripe itself reports that the payment
succeeded.

It solves the specific case of accepting Alipay through your existing Stripe account, using
Stripe's Wallet integration. This is a **standalone** gateway — it depends on Commerce
Payment and the official `stripe/stripe-php` library, but it does not require the main
Commerce Stripe module — so you can offer Alipay on its own if that is all you need.

Because the payment state is driven by retrieving the PaymentIntent from Stripe's
authoritative API (matched to the stored payment by intent ID and client secret) rather than
by trusting anything in the return request, an attacker cannot mark an order paid by
tampering with the redirect. Refunds and partial refunds are supported through Stripe, and
the module dispatches success/failure events other modules can react to.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add the payment gateway and enter your Stripe
   keys.

## Where it lives in the admin menu

You add and configure it as a payment gateway at **Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) — choose **Add payment gateway** and
select **Stripe Alipay**. Although it uses Stripe, it stands on its own and does not require
you to configure the main Commerce Stripe gateway first.
