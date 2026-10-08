# Commerce Decoupled Stripe — manual setup guide

**Commerce Decoupled Stripe** (`commerce_decoupled_stripe`) integrates **Stripe**
with a **decoupled (headless) Drupal Commerce checkout**. It is designed to work
alongside **Commerce Decoupled Checkout**: your front end collects payment with
Stripe.js and PaymentIntents, and this backend gateway records the resulting
Commerce payment. It provides two gateway types — **Decoupled Stripe** for one‑off
payments and **Decoupled Stripe Recurring** for recurring/monthly payments.

The typical flow is: the client creates an order via a Decoupled Checkout
endpoint, then creates a payment (which yields a Stripe PaymentIntent whose
`clientSecret` comes back in the payment's remote‑ID field), completes the payment
in the browser with the Stripe.js API, and finally calls the capture endpoint to
finalize the order.

> **On the security side — this integration is done right.** The module's review
> notes record that its payment trust boundary is implemented correctly: the
> gateway does **not** trust a client‑supplied "paid" status. When recording the
> payment it calls Stripe's **`PaymentIntent::retrieve()`** (authenticated with
> your Stripe **secret key**) to read the intent's real status from Stripe's own
> API, and it sets the Commerce payment to completed/authorized **only** based on
> that authoritative status (canceled or requires‑payment‑method → voided).
> Because the PaymentIntent amount is set **server‑side** when it is created,
> amount tampering is not a vector either. Your job is to keep the Stripe **secret
> key** secret and to run over **HTTPS** — see [Configuration](configuration/index.md).

It depends on **Commerce Payment** (`commerce_payment`) and supports Drupal 10.1
and 11. The project is minimally maintained (maintenance fixes only). It has no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Stripe gateway type and enter
   your Stripe keys.

## Where it lives in the admin menu

Like every Commerce gateway, Decoupled Stripe is added under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). The gateway's form is where you enter
your Stripe keys and choose the one‑off or recurring type.
