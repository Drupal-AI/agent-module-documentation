# Commerce DIAS — manual setup guide

**Commerce DIAS** (`commerce_dias_redirect`) is an off‑site Drupal Commerce
payment gateway for the Greek **DIAS** bank redirection service. When a shopper
chooses this method at checkout, they are sent to their bank's environment to
enter their card details and are then returned to your site to finalise the
order. Because the card data is entered on the bank's page and never touches your
Drupal database, you avoid storing sensitive card details and the extra
compliance cost that comes with it.

The module adds a single payment gateway plugin (**DIAS Payment Redirect**) that
depends on Drupal Commerce and its Payment module (`commerce`,
`commerce_payment`). Nothing happens on enable alone — you have to add and
configure the gateway with the API URLs and merchant credentials from your DIAS
bank agreement before it can take payments. On the shopper's return, an anonymous
callback route re‑queries DIAS for the authoritative order status and only then
records a completed payment; the amount is taken server‑side from the order
balance rather than from anything the browser sends back.

The currency is fixed to EUR.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the Commerce dependencies.
2. [Configuration](configuration/index.md) — add the DIAS gateway, enter the API
   URLs and credentials, and review the amount caveat.

## Where it lives in the admin menu

Commerce DIAS has no settings page of its own. Like every Commerce payment
method, it is added and configured under **Administration → Commerce →
Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`) by adding a gateway and choosing the
**DIAS Payment Redirect** plugin.
