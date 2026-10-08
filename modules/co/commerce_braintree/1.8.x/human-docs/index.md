# Commerce Braintree — manual setup guide

**Commerce Braintree** (`commerce_braintree`) connects **Drupal Commerce** to
Braintree Payments, giving your store an on‑site **Hosted Fields** payment gateway for
credit cards, PayPal, and PayPal Credit, with optional **3‑D Secure 2** (SCA)
authentication. "On‑site" means customers enter their card details on your checkout page
rather than being redirected to Braintree — but the card data itself never touches your
server: the browser tokenizes it with Braintree's JavaScript into a one‑time nonce, and
your server exchanges that nonce for the transaction. That keeps your PCI scope low.

The module adds one Commerce payment gateway plugin, **Braintree (Hosted Fields)**, that
implements the full set of Commerce operations — authorize, capture, void, and refund —
plus the ability to **vault** (securely store) a customer's card or PayPal account for
reuse on future orders and subscriptions. It supports multiple store currencies by mapping
each currency to a Braintree merchant account, and it can send billing/shipping data along
for fraud and address verification. Developers can attach custom metadata to each sale via
the `commerce_braintree.transaction_data` event.

Because it's a payment gateway, it does **not** work on enable alone. You must have a
Braintree merchant account, then add and configure the gateway with your Braintree
credentials (merchant ID, public key, private key). It depends on Drupal Commerce's payment
module and on the official Braintree PHP SDK, both pulled in by Composer.

One reassuring note about this release: **1.8.x is the legacy 8.x‑1.x branch and has no
webhook/IPN endpoint** — there is no server‑to‑server callback route, so there's nothing of
that kind to secure or configure. It ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in Commerce
   and the Braintree SDK) and enable the module.
2. [Configuration](configuration/index.md) — add and configure the Braintree gateway,
   enter credentials safely, map currencies, and enable 3‑D Secure.

## Where it lives in the admin menu

You configure everything on the payment gateway itself, under **Commerce → Configuration →
Payment → Payment gateways** (`/admin/commerce/config/payment-gateways`). There is no
separate module settings page. The 3‑D Secure step is added under **Commerce →
Configuration → Checkout flows**.

## How to use it

At a glance: enable the module, add a **Braintree (Hosted Fields)** payment gateway, set it
to *Test* (sandbox) while you're setting up, paste in your Braintree credentials, map each
currency to a Braintree merchant account, and — if you need SCA — turn on 3‑D Secure and add
its checkout pane. Switch the gateway to *Live* when you're ready. The full walkthrough is in
[Configuration](configuration/index.md).
