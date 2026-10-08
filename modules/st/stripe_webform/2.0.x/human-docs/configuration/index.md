# Configuration

There's no central settings page for this module — you configure payments *inside*
each webform, by adding a Stripe payment **element** and the Stripe **handler**.
Make sure you've set your Stripe API keys in the base Stripe module first (see
[Installation](../installation/index.md)).

## Step 1 — Add a Stripe payment element

1. Go to **Structure → Webforms** (`/admin/structure/webform`) and build (or edit)
   the form you want to take payment on.
2. Add an element and choose one from the **Stripe** category:
   - **Stripe** — the credit-card element.
   - **Stripe payment request** — the Apple Pay / Google Pay button.
3. Configure the element. The important properties (all of which accept Webform
   tokens, including submission tokens) include:
   - **Amount** (`webform_stripe_amount`) — the amount to charge. Can be a fixed
     number or a token that pulls from another field.
   - **Multiply amount by 100** (`webform_stripe_amount_multiply`, default **on**)
     — when on, you enter the amount in dollars and it's converted to Stripe's
     cents automatically. Turn it off if you're already entering cents.
   - **Currency** (`stripe_currency`, default `usd`) and **Country**
     (`stripe_country`, default `US`).
   - **Label** (`stripe_label`) — the payment label; falls back to the webform
     title if left blank.
   - **Subscriptions** (`webform_stripe_subscriptions`, default off) — when on,
     the payment method is captured for off-session reuse so a subscription can be
     created (pair this with a Price ID on the handler, below).
   - **Billing / receipt fields** — name, email, receipt email, and address
     (address lines, city, state, country, postal code, phone), which you can
     prefill from other form values.
   - **Shared** (`stripe_shared`, default on) — share one payment configuration
     across all Stripe elements on the form.

The element validates against Stripe's **per-currency minimum charge** (for
example USD 0.50), so a too-small amount is rejected at validation time.

> Remember: **do not** enable AJAX on the webform or use wizard (multi-page)
> layouts — the card element will refuse to save on an AJAX form, and the
> client-side payment flow breaks across pages.

## Step 2 — Add the Stripe handler

The element collects the card and creates the charge client-side; the **handler**
runs after submission to create the Stripe Customer (and optional Subscription).

1. In the webform, go to **Settings → Emails / Handlers → Add handler → Stripe**.
2. Fill in the handler's settings:
   - **Amount** *(required)* — the amount to charge (tokens allowed).
   - **Price ID** — a Stripe subscription **Price** id. If you set this, the
     handler creates a **subscription** instead of a one-off charge (tokens
     allowed).
   - **Quantity** — subscription quantity (defaults to 1).
   - **Metadata** (YAML) — extra Stripe metadata as `key: value` lines
     (token-aware).
   - **Customer create** (YAML) — extra fields merged into the Stripe
     `customers.create` call (it can't override keys the handler already sets).
   - **Subscription create** (YAML) — extra fields merged into the
     `subscriptions.create` call.
3. Save the handler.

On each **new** submission the handler retrieves the completed PaymentIntent,
creates a Stripe **Customer** with the billing details plus metadata (site uuid,
webform id, submission id), and — if subscriptions are enabled and a Price ID is
set — creates a **Subscription**. It reads the secret API key from the base Stripe
module; it never stores keys itself. Any Stripe SDK errors are shown as a form
error message.

## Step 3 — React to webhooks (optional)

After a payment, Stripe sends webhook events to the base Stripe module's endpoint
(which verifies the Stripe signature). This module then dispatches a
`stripe_webform.webhook` event carrying the matching webform submission — but only
for events whose metadata `uuid` matches this site, so one Stripe account serving
several Drupal sites won't cross-fire.

You can react to it two ways:

- **In Rules** — the event is registered as a Rules event (with `type` and
  `webform_submission` context), so you can, for example, mark a submission paid on
  `invoice.paid` without writing code.
- **In custom code** — subscribe to the
  `\Drupal\stripe_webform\Event\StripeWebformWebhookEvent` (`stripe_webform.webhook`)
  event and inspect `$event->type` and `$event->webform_submission`.

## Permissions

There are no permissions specific to this module — configuring elements and the
handler requires the standard Webform *administer / configure* permission, i.e. a
trusted form builder.
