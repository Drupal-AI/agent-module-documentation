# Bambora Payment System — manual setup guide

**Bambora Payment System** (`bambora`) adds the Bambora (Worldline) payment
gateway to **Drupal Commerce**. It supports Interac Online and card checkout:
the customer is redirected to Bambora to pay and then returned to your site to
complete the order. It is aimed at Canadian payments in particular.

The completion step is handled safely. The return endpoints (for example
`/checkout/order/interac/complete`) are anonymous by design — the customer's
browser lands on them — but an order is only marked paid after a **server-side
API call** back to Bambora (`continuePayment()`), authenticated with your
merchant credentials, confirms the payment. The completed amount comes from the
order total on the server, not from the request. That means a forged callback
cannot mark an order paid — a genuine defensive positive in the module's design.

Because this is a payment gateway, it holds **Bambora API/merchant credentials**,
and those are secrets that fall under PCI scope. Store them in the environment and
reference them from configuration — never commit them to Git or a config export.
See [Configuration](configuration/index.md).

It depends on Drupal Commerce's **commerce_payment** and **commerce_order**
modules and runs on Drupal 9.3, 10 and 11 (shipped as a **1.0.x-dev** release).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in
   Commerce, and handle the credentials securely.
2. [Configuration](configuration/index.md) — add and configure the Bambora
   payment gateway in Commerce.

## Where it lives in the admin menu

Like every Commerce gateway, it is configured under **Commerce → Configuration →
Payment gateways** (`/admin/commerce/config/payment-gateways`).
