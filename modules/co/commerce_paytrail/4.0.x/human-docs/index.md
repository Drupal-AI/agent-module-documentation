# Commerce Paytrail — manual setup guide

**Commerce Paytrail** (`commerce_paytrail`) adds a Drupal Commerce payment
gateway for **Paytrail**, a Finnish payment service that aggregates the country's
banks, card schemes, and other local payment methods behind one checkout. It uses
a token/redirect flow: the shopper is taken to Paytrail to choose and complete
their payment, then returned to your Commerce order.

The problem it solves is accepting Finnish payments in Commerce without wiring up
each bank and card method yourself — Paytrail handles that, and this module
connects it to Commerce's checkout and payment system. It depends only on
**Drupal Commerce** (Commerce Payment) and lives in the Commerce (contrib)
package.

It does **not** work on enable alone — you must add a Paytrail gateway and enter
your Paytrail merchant credentials before it can take a payment. On the security
side the module behaves correctly: the payment return/notify handler **validates
the Paytrail HMAC signature** on every callback (using the Paytrail SDK's
signature calculation keyed by your merchant secret), so a forged callback with a
bad signature is rejected and cannot mark an order paid.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Paytrail gateway and enter
   your merchant credentials.

## Where it lives in the admin menu

Commerce Paytrail adds no settings page of its own. You configure it as a payment
gateway under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway and
choose the Paytrail plugin. See [Configuration](configuration/index.md).

> **Note:** This release is a beta (4.0.0-beta3). Test it thoroughly against
> Paytrail's test environment before relying on it in production.
