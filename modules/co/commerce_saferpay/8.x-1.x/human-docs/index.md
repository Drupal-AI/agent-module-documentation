# Commerce Saferpay — manual setup guide

**Commerce Saferpay** (`commerce_saferpay`) adds a Drupal Commerce payment
gateway for **Saferpay**, the hosted payment platform run by Six Payment
Services / Worldline. When a customer chooses it at checkout, the module opens a
payment against Saferpay's API, redirects the customer to Saferpay's own hosted
payment page to enter their card details, and — this is the important part — when
the customer comes back it *asserts the transaction by calling Saferpay's API
server-to-server* rather than trusting whatever the browser sends in the return
URL. That is exactly the right shape for a redirect gateway: because the final
"paid / not paid" answer is fetched from Saferpay directly, a customer cannot
forge a successful payment by tampering with the return link.

It exists to let a store that has a Saferpay contract accept card payments (and
Saferpay's other supported methods such as Twint) while keeping all card entry
off your own site. Card data never touches your server — it stays on Saferpay's
hosted page — which keeps your PCI scope small.

The module depends only on Commerce's **Payment** module (`commerce_payment`).
Note the project's own **deprecation notice**: the current gateway uses
Saferpay's newer JSON API (required for 3-D Secure 2.0 and methods like Twint),
and it lives in the main module — there is nothing extra to enable. The older,
pre-JSON submodules are deprecated and are not what you should set up on a new
site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — create the Saferpay payment gateway
   and enter your Saferpay credentials, field by field.

## Where it lives in the admin menu

Saferpay does not add a settings page of its own. Like every Commerce gateway,
you configure it by adding a payment gateway under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`)
and choosing the **Saferpay PaymentPage** plugin (the current JSON API gateway). See
[Configuration](configuration/index.md) for the walkthrough.
