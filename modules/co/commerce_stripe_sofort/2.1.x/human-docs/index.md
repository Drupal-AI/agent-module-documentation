# Commerce Stripe Sofort — manual setup guide

**Commerce Stripe Sofort** (`commerce_stripe_sofort`) provides an **off-site** Drupal
Commerce payment gateway for the **Sofort** bank-transfer method through Stripe. Sofort is an
asynchronous EU payment method available in Austria, Belgium, Germany, Italy, the
Netherlands, and Spain, where approval can take from a couple of days up to around two weeks.
Because confirmation arrives long after the customer has left checkout, the gateway relies on
a Stripe **webhook** to complete the order.

It solves accepting Sofort through your Stripe account. It is a **standalone** gateway —
it depends on Commerce Payment and uses the Stripe PHP library (included via Composer) — and
it completes orders from Stripe's webhook notification at `/stripe-sofort-webhook`.

Crucially, the webhook does not trust the notification body to decide payment state: on
receiving a webhook it takes only the charge ID, **re-fetches that charge from Stripe**
(`Charge::retrieve()`), derives the order from the re-fetched charge's metadata, and
completes the order only when Stripe's authoritative record shows the charge was paid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.
2. [Configuration](configuration/index.md) — add the gateway with the required machine name,
   enter your Stripe keys, and set up the Stripe webhook.

## Where it lives in the admin menu

You add and configure it as a payment gateway at **Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) — choose **Add payment gateway** and
select **Stripe Sofort**. The webhook endpoint is at `/stripe-sofort-webhook`, which you
register in your Stripe Dashboard.
