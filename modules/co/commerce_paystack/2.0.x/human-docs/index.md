# Commerce Paystack — manual setup guide

**Commerce Paystack** (`commerce_paystack`) adds a Drupal Commerce payment
gateway for **Paystack**, the payment processor widely used in Nigeria and across
Africa. It is an *off-site* (redirect) gateway: at checkout the shopper is sent to
Paystack's hosted payment page to pay by card, and when they return the module
verifies the transaction with Paystack before recording the payment.

The problem it solves is accepting card payments through Paystack without your
site ever touching card details — Paystack hosts the sensitive part. This module
wires Paystack into Commerce's checkout and payment system so a Paystack payment
becomes a normal Commerce payment on the order.

It does **not** work on enable alone. Two things are needed: the
`yabacon/paystack-php` PHP library (installed with Composer, and enforced by the
module — Drupal will report the module as not ready without it), and a configured
gateway holding your Paystack Secret Key. Once configured, the flow is
reassuringly safe: the module does not trust the browser redirect blindly — on
return it makes an authenticated server-side call to Paystack to **verify the
transaction** and only then records a completed payment. There is no inbound
webhook route to spoof.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   Paystack PHP library with Composer, then enable it.
2. [Configuration](configuration/index.md) — add the Paystack gateway, set the
   mode and Secret Key, field by field.

## Where it lives in the admin menu

Commerce Paystack adds no settings page of its own. You configure it as a payment
gateway under **Administration → Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`), where you add a new gateway and
choose the **Paystack Standard (Off-site)** plugin. See
[Configuration](configuration/index.md) for the walkthrough.
