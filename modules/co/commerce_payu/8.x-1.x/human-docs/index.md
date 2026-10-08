# Commerce PayU — manual setup guide

**Commerce PayU** (`commerce_payu`) adds a Drupal Commerce payment gateway for
**PayU** (PayU.pl), built on the official OpenPayU PHP SDK. It is an *off-site*
(redirect) gateway: at checkout the shopper is POST-redirected to PayU's hosted
payment page, and PayU then notifies your site — server to server — of the result.

The problem it solves is accepting PayU payments in Commerce without handling card
data yourself. This module builds the PayU order from the Commerce cart (amounts,
buyer and billing details, and the line items), sends the shopper to PayU, and
turns PayU's completion notification into a Commerce payment on the order. It
depends only on **Drupal Commerce** (Commerce Payment).

It does **not** work on enable alone — you must add a PayU gateway and enter your
PayU merchant credentials (POS ID, signature key, and OAuth client id/secret)
before it can take a payment. Security is handled correctly: PayU's inbound
notification (IPN) is anonymous by design, but the module **verifies PayU's
`Openpayu-Signature` against your signature key before recording any payment**,
and it records the amount from your local order total rather than from the
callback body — so a forged or tampered notification cannot fulfil an order or
change the charged amount.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the PayU gateway and enter your
   merchant credentials.

## Where it lives in the admin menu

Commerce PayU adds no settings page of its own. You configure it as a payment
gateway under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway and
choose the **PayU (Redirect/Checkout)** plugin. See
[Configuration](configuration/index.md).

> **Note:** This is an early release (8.x-1.0-alpha1) and the project is seeking a
> co-maintainer. Test it thoroughly against PayU's sandbox before production use.
