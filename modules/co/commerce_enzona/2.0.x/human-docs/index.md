# Commerce Enzona — manual setup guide

**Commerce Enzona** (`commerce_enzona`) integrates the **EnZona** payment gateway —
the payment platform used in Cuba — with Drupal Commerce. It adds an off-site
payment gateway: at checkout the shopper is redirected to EnZona's hosted payment
page to pay, and when they return the module checks the transaction status with
EnZona and records the payment against the order.

It depends on Drupal Commerce and its payment, order and checkout modules
(`commerce`, `commerce_payment`, `commerce_order`, `commerce_checkout`) and runs on
Drupal 11 with PHP 8.3 or newer. Like all contributed modules whose maintainers
have not opted in, it is not covered by the Drupal security advisory policy
(`security coverage: not-covered`).

To use it you need an **EnZona merchant account** and its API credentials
(consumer key and secret, merchant id, and — depending on your account — a merchant
UUID and terminal id). EnZona provides a sandbox environment for testing before you
go live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add and configure the EnZona gateway.

## Where it lives in the admin menu

Commerce Enzona has no settings page of its own. Like every Commerce payment
method, it is added under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`) by clicking **Add payment
gateway** and choosing the **Enzona Redirect Checkout** plugin.
