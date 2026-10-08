# Commerce Paynow — manual setup guide

**Commerce Paynow** (`commerce_paynow`) integrates the **Paynow (mBank)** payment
gateway — a widely used payment service in **Poland** — with Drupal Commerce. The
customer pays via Paynow, and Paynow posts a **webhook notification** back to your
site, which the module uses to update the payment status automatically.

The webhook handling is done the right way: the controller hands the request to a
notification processor that builds the Paynow SDK's `Notification` object with your
signature key, the payload, and the request headers. The SDK **verifies the
`Signature` header (an HMAC) and throws on mismatch** before the payment state is
changed — so a forged or unsigned notification is rejected rather than acted upon.
That's the defensive pattern you want from a callback-based gateway.

Configuration is short: add a Paynow gateway, enter your Paynow **API Key** and
**Signature Key**, and optionally enable logging for debugging. Store those
credentials securely (env-backed) and never commit them.

It depends on Commerce's **Payment** module and requires **Drupal Commerce 3**. Access to
add and configure the gateway is governed by Commerce's own *Administer commerce_payment_gateway*
permission — this module does not define permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and configure the Paynow payment
   gateway.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`) by
adding a new gateway and choosing the **Paynow** plugin. You then attach it to your
checkout flow.
