# Payson Checkout — manual setup guide

**Payson Checkout** (`payson_checkout`) integrates the Swedish payment provider
**Payson** into Drupal Commerce as a payment gateway, implementing the **Payson
Checkout 2.0 API**. It lets a Commerce store accept payments through Payson's
hosted checkout, which is popular in the Nordics. Thanks to Payson's REST API, no
external PHP library needs to be installed — the module talks to Payson directly.

It plugs into Drupal Commerce, so it depends on **Commerce Payment** and
**Commerce Tax**. Payments are determined **server-to-server**: the module creates
and reads the checkout through Payson's API and decides the payment state from the
authoritative API status codes rather than trusting any value handed back through
the shopper's browser. That means a forged or replayed return request cannot make
an order look paid — the real status always comes from Payson's API.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Commerce, then enable it.
2. [Configuration](configuration/index.md) — add the Payson gateway in the
   Commerce UI and enter your Payson API credentials.

## Where it lives in the admin menu

Payson Checkout has no standalone settings page. You configure it as a **payment
gateway** inside Drupal Commerce, at **Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`). See
[Configuration](configuration/index.md).
