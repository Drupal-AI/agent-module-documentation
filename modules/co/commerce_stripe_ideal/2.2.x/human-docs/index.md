# Commerce Stripe iDEAL — manual setup guide

**Commerce Stripe iDEAL** (`commerce_stripe_ideal`) adds **iDEAL** — the Dutch bank-transfer
payment method — as a Stripe-backed payment gateway in Drupal Commerce. At checkout it
creates a Stripe **PaymentIntent** for the order and redirects the shopper through the iDEAL
flow. It confirms the payment in two complementary ways: when the shopper returns (by
retrieving the intent from Stripe) and via a Stripe **webhook** whose signature it verifies.

It solves accepting iDEAL through your existing Stripe account. This is a **standalone**
gateway — it depends on Commerce Payment and the official `stripe/stripe-php` library, but
not on the main Commerce Stripe module — so you can offer iDEAL on its own.

Payment state comes from Stripe's authoritative API, never from request data: the return
handler re-retrieves the PaymentIntent from Stripe, and the webhook handler verifies the
`Stripe-Signature` header before acting, rejecting requests with an invalid signature. It
supports full and partial refunds and validates your key/mode against the Stripe Balance API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add the gateway, enter your Stripe keys, and
   register the signed webhook.

## Where it lives in the admin menu

You add and configure it as a payment gateway at **Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) — choose **Add payment gateway** and
select **Stripe iDEAL**. It uses Stripe but does not require the main Commerce Stripe gateway
to be configured first.
