# Commerce Paypal Subscriptions — manual setup guide

**Commerce Paypal Subscriptions** (`commerce_paypal_subscriptions`) enables
**recurring payments (subscriptions)** through the **modern PayPal API** for Drupal
Commerce. A customer subscribes at checkout and is then billed recurringly by PayPal,
which manages the subscription lifecycle. (If you need the older NVP/SOAP API
instead, use the separate *Paypal subscriptions* project; this module uses PayPal's
modern API.)

A nice convenience is that PayPal **products and plans can be generated dynamically**
— the plan's price is based on the Commerce order total — so you don't have to
pre-create every plan by hand. Alternatively, you can point the gateway at a **default
subscription plan** you created earlier in PayPal.

To add it you create a payment gateway using the **"Paypal checkout subscriptions"**
payment method and supply your PayPal **client ID** and **client secret**. To finish
configuring checkout you need a product and a plan in your PayPal account — either
auto-generated (select *Dynamic plans* and tick *Autogenerate product*) or a plan you
reference in *Default subscription plan*.

**Security notes:** store the PayPal **client ID / client secret as secrets** and
operate over HTTPS. When a shopper approves the subscription, the module confirms it
by **re-fetching the subscription from PayPal's authenticated API server-side** and
matching its plan to the order before recording payment (using the server-side order
total as the amount). Restrict who may **administer payment gateways**, protect your
configuration exports, and always confirm whether you're pointed at **sandbox or
live**.

It depends on Drupal **Commerce** and the **Commerce PayPal** (`commerce_paypal`)
module, whose Checkout gateway and PayPal REST SDK this module extends.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the gateway and set up your PayPal
   product/plan.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway with the **Paypal checkout subscriptions** payment method. You
then attach it to your checkout flow.
