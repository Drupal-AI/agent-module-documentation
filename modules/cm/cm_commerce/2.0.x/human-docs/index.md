# CM.com Payment — manual setup guide

**CM.com Payment** (`cm_commerce`) adds a [CM.com](https://www.cm.com/) payment
gateway to Drupal Commerce. It's an **off‑site** gateway: at checkout the shopper
is redirected to CM.com to choose a payment method (credit card, iDEAL, PayPal and
so on — the choice is handled by CM.com's "menu" option) and pay, then returns to
your site, where the order is reconciled.

It solves the problem of accepting payments through CM.com without building the
integration yourself. If you run a Drupal Commerce store and use CM.com as your
payment service provider, this module wires the two together as a standard Commerce
payment gateway plugin.

A reassuring detail on the security side: on the return/notify path the gateway
**re‑fetches the order status directly from CM.com's API** (a server‑to‑server
`GET` on the order) using your merchant key, and only marks the payment complete
when CM.com's own API reports success. It does not trust a status value handed back
by the shopper's browser, which closes off a common class of payment‑spoofing
attacks. Keep your CM.com merchant credentials (merchant name, password, merchant
key) restricted to trusted administrators.

The module depends on Drupal Commerce's `commerce_payment` and supports Drupal 10.3
and 11. This release is a beta (`2.0.0-beta1`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Payment.
2. [Configuration](configuration/index.md) — add the CM.com gateway to your store
   and enter your credentials.

## Where it lives in the admin menu

There is no standalone settings page. Like all Commerce gateways, CM.com Payment is
configured as a payment gateway at **Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`).
