<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Coinbase (commerce_coinbase) — agent index

An **off-site Drupal Commerce payment gateway** for **Coinbase Commerce** (crypto checkout). At
checkout the module creates a Coinbase *charge* via the Coinbase Commerce REST API and redirects the
shopper to Coinbase's hosted invoice; Coinbase later POSTs a **signed webhook** back to the site,
and the order is placed on a verified `charge:confirmed` event. Package `Commerce`. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version **2.0.2** (version dir `2.0.x`).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`**, **`commerce:commerce_payment`**. Nothing else.
- **No external PHP library** and **no cURL requirement** — HTTP is done with core's Guzzle
  `@http_client`. (Historical drupal.org text about a "coinbase-php" library / cURL / cron polling
  describes the old D7 line and does **not** apply to 2.0.x.)
- **No cron / no `.module` file.** Settlement is entirely webhook-driven; there is no polling.
- No `.permissions.yml` (the module declares no permissions).

## What it provides (from source)

- **Payment gateway plugin** `coinbase_offsite` (label "Coinbase (Off-site)") —
  `src/Plugin/Commerce/PaymentGateway/OffsiteRedirect.php`, extends `OffsitePaymentGatewayBase`.
  Config form fields: `api_key`, `secret` (webhook shared secret), `charge_name`,
  `charge_description` (token-enabled). `onReturn()` is a no-op (all fulfilment is via the webhook).
- **Off-site redirect form** `src/PluginForm/OffsiteRedirect/PaymentOffsiteForm.php` — builds the
  charge params from the order/payment and calls the API, then redirects to Coinbase's `hosted_url`.
- **Webhook controller** `src/Controller/CommerceCoinbaseController.php::handleIncomingWebhook()` —
  route `commerce_coinbase.webhook` → `POST /coinbase/webhook/{commerce_payment_gateway}`,
  `_access: 'TRUE'` (anonymous; secured by HMAC signature, not access control).
- **API service** `commerce_coinbase.api` (`src/CoinbaseApi.php`) — `createCharge()` against
  `https://api.commerce.coinbase.com/charges` (headers `X-CC-Api-Key`, `X-CC-Version: 2018-03-22`),
  Symfony-validator param validation, and a `log()` helper writing to a DB table.
- **Payment method type** `crypto_wallet` (`src/Plugin/Commerce/PaymentMethodType/CryptoWallet.php`)
  with `crypto_type` / `crypto_number` fields (largely a stub; `buildLabel` hardcodes "123").
- **Log table** `commerce_coinbase_log` (`hook_schema` in `commerce_coinbase.install`): id, uid,
  url, order_id, type, hostname, created, data (serialized blob). No UI to view it.
- **Config schema** (`config/schema/commerce_coinbase.schema.yml`): `api_key`, `secret` (both
  `string`) on the gateway plugin config.

## Webhook security posture (positive)

The webhook is anonymous by design (Coinbase's servers must reach it) and is secured by an
**HMAC-SHA256 signature over the raw request body**: the controller recomputes
`hash_hmac('sha256', <raw payload>, <shared secret>)` and rejects the request (no fulfilment) unless
it matches the `X-CC-Webhook-Signature` header. The order id is read from the signed payload's
`event.data.metadata.order_id`, and an already-`completed` payment short-circuits (replay-safe).
Coinbase API calls use Guzzle's default TLS verification against a hardcoded HTTPS host.

## Solution docs

- **Gateway config, off-site charge creation, API service, payment method type** →
  [config/gateway.md](config/gateway.md)
- **Webhook endpoint, signature verification, order fulfilment, log table** →
  [webhook.md](webhook.md)
