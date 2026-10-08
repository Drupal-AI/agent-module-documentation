# Commerce Webform Order — manual setup guide

**Commerce Webform Order** (`commerce_webform_order`) bridges
[Webform](https://www.drupal.org/project/webform) and
[Drupal Commerce](https://www.drupal.org/project/commerce). Its centerpiece is a
Webform **handler** that turns a form submission into a Commerce order (a cart)
selling any purchasable entity — a product variation, or anything implementing
Commerce's purchasable‑entity interface. Add the handler to a webform and a
submission can add a product to the customer's cart and send them to checkout. It's
the module you reach for to build donation forms, membership/subscription signups,
"pay what you want" pricing, or any bespoke form‑driven purchase flow.

What makes it flexible is that **almost any handler setting can be sourced from the
form**. Using a `:input[name="element_key"]` selector or a token, you can map the
price, quantity, title, owner, and more to values the visitor submits — that's how
a donor types their own amount, for example. On submission the handler builds or
updates an order item, links it to the submission, places it in the cart, and can
optionally set the payment gateway/method, order state, and arbitrary order data
before redirecting to checkout.

Beyond the handler, the module ships three Webform **elements** — Payment Method
(an on‑form gateway selector), Order State, and Payment Status — plus a replacement
Commerce **Payment process** checkout pane, tokens for the associated order and
order item, and event subscribers that sync order state and payment status back
onto submissions.

The module requires **Commerce** (with Cart, Checkout, Order, Price, and Store),
**Webform**, **Commerce Purchasable Entity**, **PHP 8.1+**, and Drupal 9/10/11. It
has no global settings page and no permissions of its own — everything is set up
per webform handler by users with webform‑admin rights. The Token and Token OR
modules are suggested for a nicer token UI.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce and Webform.
2. [Configuration](configuration/index.md) — add and configure the Commerce
   Webform Order handler (Store, Order item, Checkout tabs), the value mapping, the
   webform elements, and the checkout pane.

## Where it lives in the admin menu

There is no dedicated settings page. You configure everything on a specific
webform, at **Structure → Webforms → {your form} → Settings → Handlers**
(`/admin/structure/webform/manage/{form}/handlers`), by adding the **Commerce
Webform Order** handler.

## How to use it

Build (or pick) a webform, open its **Handlers** tab, and add the **Commerce
Webform Order** handler. In the handler's settings choose the store and the
purchasable entity, decide how the cart behaves, and optionally map price/quantity
to form elements for variable pricing. When a matching submission comes in, the
order item is created and added to the cart, and — if you leave the redirect on —
the visitor is taken to Commerce checkout. See
[Configuration](configuration/index.md) for a field‑by‑field walkthrough.
