# Stripe Pay — manual setup guide

**Stripe Pay** (`stripe_pay`) integrates Stripe Checkout into Drupal without
requiring Drupal Commerce. It adds a **Stripe Payment field** you can attach to
nodes and other entities: you set a price on the entity, and the field renders a
pay button. When a visitor clicks it, the module creates a Stripe Checkout
session through the Stripe PHP library and sends them to Stripe's hosted checkout
page, then handles their return through success and cancel pages.

The problem it solves is taking a one-off payment for a product or entity with a
minimum of setup — no full commerce stack, just a field, a settings form for your
keys, and a few routes. You configure the publishable and secret keys (for both
test and live mode) and the currency on a settings form, add the payment field to
whatever content types need it, and control the button text, price format, and
quantity from the entity's Manage display page. A Twig template
(`stripe-payment.html.twig`) can be copied into your theme for full control of the
button's markup, and four hooks let a developer customize the success and cancel
messages and redirect targets.

Stripe Pay depends on core **Field** and pulls in the Stripe PHP library via
Composer; it requires **PHP 7.4+**. Note that the Composer package
(`drupal/stripe_pay`) matches the machine name (`stripe_pay`) — some older
instructions mention `drupal/stripe`, which is a different project; use
`drupal/stripe_pay`.

> **Important security note.** As shipped, this module's payment flow is not safe
> for authoritative order fulfilment, and this is a recorded finding rather than a
> hypothetical. All three payment routes are fully public, the charge **amount is
> taken directly from the browser's request** (so a visitor can change the price),
> and the success page treats the visitor's *return* as proof of payment — it
> shows "success" and redirects using request-supplied values **without verifying
> anything with Stripe**. Do not rely on it to grant anything of value until you
> add server-side verification (a signature-checked webhook plus a Checkout
> Session retrieval). See [Configuration](configuration/index.md) for the details
> and the caveats.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter your Stripe keys, add the
   payment field, and understand the security caveats before going live.

## Where it lives in the admin menu

The settings form lives at **`/admin/stripe-configurations`** and is gated by the
**Administer site configuration** permission. The payment field itself is added
per content type through the normal **Manage fields** / **Manage form display** /
**Manage display** screens.
