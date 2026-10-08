# Commerce Wise — manual setup guide

**Commerce Wise** (`commerce_wise`) adds a **Wise** (formerly TransferWise)
off‑site payment gateway to Drupal Commerce, integrating with **Wise Quick Pay**.
The customer pays via Wise, and Wise notifies your site of balance/transfer events
through a **webhook**, keeping Commerce payments synchronized with Wise.com in
real time.

The problem it solves: it connects Drupal Commerce Core to your Wise **business
account** so you can take Wise payments without writing the API and webhook plumbing
yourself. It depends on Commerce **Payment** (`commerce_payment`) and Commerce
**Order** (`commerce_order`) — there are no other requirements beyond Commerce
Core 3.

When Wise sends a deposit notification, `onNotify()` reads the `X-Signature-SHA256`
header and runs `openssl_verify` against **Wise's public key**, then matches the
transfer reference to a local order and records the payment, transitioning the order
to placed.

The gateway does **not** work on enable — you must add and configure a Wise Quick Pay
gateway, providing your **Wise @tag** and **Wise's webhook public key** and choosing
the test/live mode, and you need a Wise business account. There is no API token to
enter.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Wise gateway, enter the Wise
   @tag and public key, and set up the webhook.

## Where it lives in the admin menu

Commerce Wise adds no top‑level admin page. As a Commerce payment gateway you
configure it under **Administration → Commerce → Configuration → Payment
gateways** (`/admin/commerce/config/payment-gateways`), choosing **Wise** as the
plugin. See [Configuration](configuration/index.md).
