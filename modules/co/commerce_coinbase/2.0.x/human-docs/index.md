# Commerce Coinbase — manual setup guide

**Commerce Coinbase** (`commerce_coinbase`) integrates the **Coinbase Commerce
API** into Drupal Commerce as an **off‑site cryptocurrency payment gateway**,
letting customers pay with cryptocurrency. At checkout the module creates a Coinbase
*charge* and redirects the shopper to Coinbase's **hosted invoice** at
commerce.coinbase.com; Coinbase then notifies your site of the payment status via a
**webhook**, and the order is placed only once Coinbase confirms the charge.

The gateway authenticates to the Coinbase Commerce API with an **API key** (sent as
the `X-CC-Api-Key` header). Settlement is entirely **webhook‑driven** — there is no
cron polling and the customer's return from Coinbase does not itself complete the
order; the order is finalized when the signed `charge:confirmed` webhook arrives.

The webhook at `/coinbase/webhook/{payment_gateway}` is anonymous by design (so
Coinbase's servers can reach it) but **verifies the `X-CC-Webhook-Signature` HMAC**:
it recomputes an HMAC‑SHA256 of the raw request body with your shared secret and
rejects the request on any mismatch before doing anything, so forged callbacks
cannot complete an order. Because the callback carries a secret validation value,
your site should also serve **HTTPS**, and you should keep the webhook secret
confidential.

Commerce Coinbase depends only on Commerce (`commerce`) and Commerce **Payment**
(`commerce_payment`) and works on Drupal 9, 10, and 11. It needs **no external PHP
library, no cURL setup, and no cron** — HTTP is handled by Drupal core's HTTP
client. (Older drupal.org text mentioning a separate "Coinbase PHP" library, cURL,
or cron polling describes the legacy Drupal 7 line and does not apply to this 2.0.x
release.) The project is minimally maintained, so verify current Coinbase Commerce
API availability before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install and enable the module alongside
   Commerce Payment.
2. [Configuration](configuration/index.md) — adding the gateway, entering the API
   key and webhook secret, and wiring the webhook on the Coinbase side.

## Where it lives in the admin menu

Like every Commerce payment method, Coinbase is set up under **Administration →
Commerce → Configuration → Payment gateways**
(`/admin/commerce/config/payment-gateways`). You add a gateway there and choose the
Coinbase plugin. The webhook endpoint is `/coinbase/webhook/{payment_gateway}`.
