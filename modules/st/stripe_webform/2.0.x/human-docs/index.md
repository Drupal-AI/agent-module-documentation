# Stripe's Webform Integration — manual setup guide

**Stripe's Webform Integration** (`stripe_webform`) bridges the
[Stripe](https://www.drupal.org/project/stripe) and
[Webform](https://www.drupal.org/project/webform) modules, so you can take Stripe
payments directly on a Webform. It adds Stripe payment **elements** you drop into a
form, plus a Stripe **handler** that creates a Stripe customer (and, optionally, a
recurring subscription) when the form is submitted. It's a straightforward way to
build a donation form, a paid registration, a booking deposit, or a simple product
order.

Two payment elements are provided:

- **Stripe** — a credit-card element that collects the card and creates the
  charge.
- **Stripe payment request** — an Apple Pay / Google Pay-style "Payment Request"
  button for browser wallets.

Both support Webform tokens, so the amount, billing details, and metadata can be
driven by other fields on the form. The amount can be fixed or dynamic, entered in
dollars and automatically converted to Stripe's cents. On submission, the Stripe
handler creates a Customer with the billing details and can start a Subscription
from a configured Stripe Price. Incoming Stripe webhooks (verified by the base
Stripe module) are surfaced as an event you can react to in code or in Rules — for
example to mark a submission paid when an invoice is paid.

> **Where the API keys live.** This module does **not** store your Stripe API
> keys — it reads them from the base **Stripe** module's configuration. Set your
> keys there, and keep the **secret** key out of version control by supplying it
> through an environment variable / Key entity (see Installation).

> **Don't use AJAX or wizard (multi-page) webforms** for a Stripe form. Payment
> happens client-side, and it breaks across AJAX submissions and wizard pages —
> the module warns you about this, and the card element even refuses to save on an
> AJAX-enabled webform.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with Stripe and
   Webform) and set your Stripe keys.
2. [Configuration](configuration/index.md) — add a payment element and the Stripe
   handler to a webform.

## Where it lives in the admin menu

This module has no settings page of its own. You work with it inside individual
webforms under **Structure → Webforms** (`/admin/structure/webform`), and your
Stripe API keys are configured in the base **Stripe** module's settings.
