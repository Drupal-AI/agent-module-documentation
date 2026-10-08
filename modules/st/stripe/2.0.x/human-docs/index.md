# Stripe — manual setup guide

**Stripe** (`stripe`) is a low‑level integration module that wires the official
`stripe/stripe-php` SDK and Stripe.js into Drupal. It is a *payment primitive*, not
a ready‑made store: it stores your Stripe API keys, loads Stripe.js on every page,
gives you Form API elements for collecting card payments, and turns Stripe's
incoming webhooks into events your code can react to. You use it to build a custom
donation form, a bespoke checkout, or a paid feature — anywhere you need to take a
Stripe payment without pulling in a full commerce system like Drupal Commerce.

Out of the box it does three things once configured. It provides an admin settings
form for your **test** and **live** API keys (with a one‑switch environment
toggle). It attaches Stripe.js site‑wide, which Stripe recommends for its
fraud/risk signals. And it exposes two Form API render elements — a **card
element** (`stripe`) and a **Payment Request button** (`stripe_paymentrequest`, for
Apple Pay / Google Pay) — that create a Stripe PaymentIntent server‑side and handle
the client‑side confirmation (including SCA / 3‑D Secure).

On the server side it registers a **webhook endpoint** at `POST /stripe/webhook`
that verifies Stripe's signature and dispatches a `WEBHOOK` event carrying the
Stripe event object — so you can fulfil an order, grant a role, or send a receipt
when `payment_intent.succeeded` arrives. A second `PAYMENT` event lets you adjust a
payment's amount or metadata just before it's confirmed. Reacting to either means
writing a small event subscriber (see the `agent/` docs for code).

The module works only after you enter API keys — installing and enabling it alone
does nothing visible. It provides an `administer stripe` permission and depends on
the `stripe/stripe-php` Composer library (no other Drupal modules). One optional
submodule, **Stripe examples** (`stripe_examples`), ships a complete working
checkout form, block, and event subscriber you can copy from.

> **A note on secrets:** your Stripe **secret key** and **webhook signing secret**
> are sensitive. This module stores keys in configuration, which is exported as
> plain text and usually committed to version control. Do **not** commit live
> secret keys. Instead, provide them from an environment variable in `settings.php`
> — see [Configuration](configuration/index.md#keeping-secrets-out-of-config).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Stripe PHP SDK), enable the module, and pick up the examples submodule.
2. [Configuration](configuration/index.md) — the settings form field by field,
   plus how to keep secret keys out of exported config and how to point Stripe's
   webhook at your site.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → Stripe**
(`/admin/config/system/stripe`), reachable by users with the **Administer stripe**
permission.

## How to use it

The short path: install the module with Composer, enter your test keys at
**Configuration → System → Stripe**, then use the `stripe` (or
`stripe_paymentrequest`) Form API element in a custom form to collect a payment. To
act on completed payments, add the webhook URL (`/stripe/webhook`) in your Stripe
dashboard and write an event subscriber for the `WEBHOOK` event. The
`stripe_examples` submodule shows the whole flow end to end. Full details are in
[Configuration](configuration/index.md).
