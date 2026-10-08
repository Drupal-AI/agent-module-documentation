# PayPal Subscriptions — manual setup guide

**PayPal Subscriptions** (`paypal_subscriptions`) extends Drupal Commerce's PayPal
integration to support **recurring billing**. It adds a "PayPal recurring (Express
Checkout)" payment gateway that, instead of taking a single charge, creates a
PayPal **recurring payments profile** at checkout — so a Commerce order can start a
subscription or membership that PayPal then bills on a schedule.

It is a thin extension on top of the [Commerce PayPal](https://www.drupal.org/project/commerce_paypal)
module: the gateway plugin subclasses `commerce_paypal`'s Express Checkout gateway
and reuses its off-site payment form and NVP API plumbing, adding a configurable
**billing period** (Day, Week, SemiMonth, Month, or Year). Because of that, this
module is an add-on — it needs both **Commerce Payment** and **Commerce PayPal**
installed and working first.

When a shopper returns from PayPal, the gateway calls PayPal server-to-server
using the token stored on the order, confirms the details, creates the recurring
profile, and only records a Commerce payment when PayPal reports the profile is
`ActiveProfile`. Because the return handler re-fetches transaction details from
PayPal via the server-issued token bound to the order — rather than trusting
anything in the return request — it is **not a forgeable success callback**: a
crafted return URL cannot fake an active subscription.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Commerce and Commerce PayPal, then enable it.
2. [Configuration](configuration/index.md) — add the recurring gateway in the
   Commerce UI and set the billing period.

## Where it lives in the admin menu

This module has no standalone settings page. You configure it as a **payment
gateway** inside Drupal Commerce, at **Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
