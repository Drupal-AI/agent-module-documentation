# Commerce Pei Payment Gateway — manual setup guide

**Commerce Pei Payment Gateway** (`commerce_pei`) adds a Drupal Commerce payment
gateway for **Pei** (https://www.pei.is). Unlike a redirect gateway, this is an
*on-site* gateway: the shopper enters their payment details during checkout on
your own site, and the payment is created and captured synchronously while the
buyer is present — buyer authorization is handled in the payment-method creation
step.

The problem it solves is accepting Pei payments directly in your Commerce
checkout, keeping the buyer on your site through the payment step. Because it
processes payment synchronously with the buyer present, there is no anonymous
asynchronous callback to worry about — the whole exchange happens during the
checkout request.

It depends on **Drupal Commerce** (Commerce Payment) and Drupal core's
**Telephone** module, and supports Drupal 10 and 11. It does **not** work on
enable alone: you must add a Pei gateway and enter your Pei API credentials before
it can take a payment.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Pei gateway and enter your
   API credentials.

## Where it lives in the admin menu

Commerce Pei adds no settings page of its own. You configure it as a payment
gateway under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway and
choose the Pei plugin. See [Configuration](configuration/index.md).

> **Note:** This release is an alpha (3.0.0-alpha3). Test it thoroughly before
> relying on it in production.
