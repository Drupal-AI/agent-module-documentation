# Stripe Webform Payment — manual setup guide

**Stripe Webform Payment** (`stripe_webform_payment`) adds a Stripe payment
element to Webform, so a form submission can collect a card payment. Drop the
element into any webform — a donation form, a registration with a fee, a simple
order — and the submission takes a payment through Stripe's Payment Elements. It
uses Stripe.js, so card data goes straight to Stripe and never touches your
Drupal server.

The problem it solves is a common one: collecting money inside a form. Webform is
where many sites build their forms, and this module lets those forms charge a card
as part of submission, with a good deal of flexibility — you can link the element
to an existing Stripe **product**, or set a **custom price and currency** without
a product; map Drupal users to Stripe **customers**; optionally collect shipping
and billing addresses; style the payment element to match your site; and retrieve
succeeded payment-intent values as Webform tokens. It is compatible with Webform's
AJAX and supports 3D Secure.

It builds on the contrib **Stripe** base module, and that split matters for
security. This module provides the Webform element and reads the configured keys;
the actual Stripe API calls and, critically, the **webhook signature
verification** are handled by the Stripe base module — which is the correct place
for them. That the module is wired for signed webhooks (rather than trusting
unverified callbacks) is the reassuring part. Because card numbers go directly to
Stripe via Stripe.js, your site stays out of most PCI scope — a benefit worth
preserving by not adding server-side card handling around it.

The security responsibilities that fall to you as the operator are the usual
payment ones: keep the Stripe secret key and webhook-signing secret out of plain
configuration and version control (use a Key entity or an environment variable),
and make sure the webhook endpoint provided by the Stripe base module has its
signing secret configured so forged payment-confirmation callbacks are rejected.
Note also that this module **requires PHP 8.1 or newer** — older PHP will produce
errors.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside the
   Stripe and Webform modules.
2. [Configuration](configuration/index.md) — configure keys on the Stripe module,
   then add and tune the Stripe payment element on a webform.

## How to use it

After installing, you configure your Stripe API credentials on the **Stripe
module's** settings (or in `settings.php`), then open any webform's build page and
add a **Stripe payment** element. The element ships with working defaults; each
field's help text explains the advanced options for products, custom pricing,
customer mapping, and address collection.
