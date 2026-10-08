# Commerce Decoupled Checkout — manual setup guide

**Commerce Decoupled Checkout** (`commerce_decoupled_checkout`) provides **REST API
endpoints** for a decoupled (headless) Drupal Commerce checkout, so a separate
front end — a JavaScript app, a mobile app — can create orders and take payment
over an API instead of using Drupal's built‑in checkout flow.

It exposes endpoints for the core steps of a purchase: creating an order (together
with the user account, customer profile, and order items), creating and
initializing a payment on that order, capturing (finalizing) a payment, and voiding
a payment that has not been captured. The maintainers report it has been used
successfully with PayPal Express Checkout, Stripe, Global Payments (formerly Realex),
and Direct Debits. It works with **on-site** payment gateways.

It depends on **Drupal Commerce** (`commerce_payment` and `commerce_checkout`) and
supports Drupal 8, 9, 10, and 11. Note that the project is **minimally maintained**.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it registers REST endpoints
rather than an admin form. The setup work is enabling and securing those endpoints,
described below.

## Where it lives

The module adds no admin page of its own. It registers Drupal REST resources at:

- `POST /commerce/order/create` — create a new order (optionally with a payment).
- `POST /commerce/payment/create/{order_id}` — create/initialize a payment.
- `POST /commerce/payment/capture/{order_id}/{payment_id}` — capture a payment.
- `POST /commerce/payment/void/{order_id}/{payment_id}` — void an uncaptured
  payment.

## Enabling and securing the endpoints

Because these are standard Drupal **core REST resources**, they are inactive until
you turn each one on. For every endpoint you plan to use you must:

1. **Enable the REST resource** — with the *RESTful Web Services* core module (and,
   most conveniently, the contributed *REST UI* module) enable each resource and
   pick the request format (for example `json`).
2. **Choose an authentication provider** — such as cookie, basic auth, or a token
   provider like *Simple OAuth* — appropriate to how your front end authenticates.
3. **Grant the permission** — each resource has an auto-generated permission
   (`restful post …`); grant it only to the roles that should call that endpoint. A
   public storefront commonly grants the order/payment endpoints to the
   *anonymous* role.

Then have your headless front end call the endpoints in sequence to build an order
and take payment, wiring in whichever on-site Commerce payment gateway you use.
Serve the API only over **HTTPS**, and review the access model for your deployment
before going live.

This guide is written for a **human** configuring the site. For terse, token‑cheap
references aimed at an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.
