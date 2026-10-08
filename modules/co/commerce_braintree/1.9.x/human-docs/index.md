# Commerce Braintree — manual setup guide

**Commerce Braintree** (`commerce_braintree`) integrates **Braintree Payments**
with **Drupal Commerce**, letting your store accept credit cards, PayPal, and
PayPal Credit — with optional 3-D Secure 2 (SCA) authentication — right on your own
checkout. It provides an on-site **Hosted Fields** payment gateway: the card form
appears on your site, but the sensitive card data is tokenized in the browser by
Braintree's JavaScript and never touches your Drupal server, which keeps your PCI
scope small.

The problem it solves is taking real payments in Drupal Commerce through Braintree
without redirecting customers off-site for card entry, and without storing card
numbers yourself. The browser turns card (or PayPal) details into a one-time
**payment-method nonce**; your server exchanges that nonce with Braintree to create
transactions and, optionally, to **vault** (securely store) a payment method for
future orders and subscriptions.

The gateway supports the full set of Commerce payment operations — authorize and
capture (together or separately), void, and full or partial refunds — plus multiple
store currencies by mapping each currency to a Braintree **merchant account ID**.
3-D Secure is added through a dedicated checkout pane that runs authentication as
the last step before submit. Payment method types include credit card, PayPal, and
a distinct PayPal Credit option.

A couple of important notes. This 1.9.x release is the legacy `8.x-1.x` branch, and
it has **no webhook/IPN endpoint** — there is no server-to-server callback, so
there's nothing of that kind to secure. And on **PCI compliance**: the module is
intended to work within SAQ A-EP requirements, but the maintainers offer no
warranty — you remain responsible for your own compliance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Drupal Commerce.
2. [Configuration](configuration/index.md) — add the Braintree payment gateway and
   enter your credentials, currencies, and 3-D Secure settings.

## Where it lives in the admin menu

Braintree is configured as a Commerce **payment gateway** at **Commerce →
Configuration → Payment → Payment gateways**
(`/admin/commerce/config/payment-gateways`). There is no separate module settings
page — all options live on the gateway you create there. Use core Commerce's
payment permissions to control access.

## How to use it

Create a Braintree Hosted Fields payment gateway (see
[Configuration](../configuration/index.md)), enter your Braintree API credentials,
and choose Test (sandbox) or Live mode. Once it's set up and enabled, Braintree
appears as a payment option during checkout: customers enter card details in the
on-site Hosted Fields form (or choose PayPal / PayPal Credit), the browser
tokenizes it, and your server completes the transaction. From the order's
**Payments** tab you can capture authorized payments, void authorizations, and
issue refunds.
