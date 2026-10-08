# Commerce Payin-Payout — manual setup guide

**Commerce Payin-Payout** (`commerce_payin_payout`) is an **off-site** Drupal
Commerce payment gateway for the **Payin-Payout** service. At checkout it
POST-redirects the buyer to Payin-Payout's hosted payment form; after payment, the
service sends a **signed server-to-server notification** back to your site, and the
module completes the order once that notification's signature checks out.

The signature is the integrity control, and the module handles it carefully. The
outbound redirect is signed with your API token, and the inbound notification is
verified by recomputing the signature over the notification fields and comparing it
to the received value with **`hash_equals()`** — so a forged or unsigned callback is
rejected before any payment is created. (The signing uses `md5`, which is required by
the Payin-Payout gateway itself.) The notification endpoint is anonymous by design,
as Commerce webhooks are, but fulfilment is gated behind that signature check.

Two things to know: Payin-Payout requires a **customer phone number**, so you must
have a phone field on the customer profile and point the gateway at it; and the API
**token is stored in plain gateway configuration** (there is no Key-entity
integration), so protect your configuration accordingly. Note also that the completed
payment's amount and currency come from the (signed) notification rather than being
independently re-fetched — the signature is what guarantees they're genuine.

It depends on **Commerce** and **Commerce Payment** (`commerce`,
`commerce_payment`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add and configure the Payin-Payout
   payment gateway, including the required phone field.

## Where it lives in the admin menu

Like every Commerce gateway, it is added under **Administration → Commerce →
Configuration → Payment gateways** (**Store → Configuration → Payments → Payment
Gateways**) by adding a new gateway and choosing the **Payin-Payout** plugin. You
then attach it to your checkout flow.
