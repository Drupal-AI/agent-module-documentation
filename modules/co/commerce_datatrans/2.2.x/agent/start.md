<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Datatrans (commerce_datatrans) — agent index

Drupal Commerce **off-site payment gateway** for **Datatrans** (a Swiss payment
service provider), built on the Datatrans **JSON / v1 API**. The customer is
redirected to a Datatrans-hosted payment page; the result is confirmed on the
browser **return** and, optionally, via an asynchronous server-to-server
**webhook**. Version **2.2.0**. Core `^10.1 || ^11`. License GPL-2.0-or-later.
Package `Commerce`.

## Dependencies

- Drupal module: **`commerce_payment`** (from Drupal Commerce) — the only
  dependency (`.info.yml`).
- Composer: **`drupal/commerce` `^2.25 || ^3`** (`composer.json`). No third-party
  PHP libraries; API calls go through Drupal's `http_client` (Guzzle).

## What it provides (from source)

- **Payment gateway plugin** `datatrans` (`Plugin/Commerce/PaymentGateway/Datatrans`,
  extends `DatatransBase`) — an `OffsitePaymentGatewayInterface` that also
  `SupportsRefundsInterface`. Payment method types: `credit_card` and the module's
  own `datatrans_alias`. Declares a long `credit_card_types` list (VIS, ECA, AMX,
  TWI, PAP, PFC, …).
- **Off-site form** `PluginForm/DatatransForm` (extends `PaymentOffsiteForm`) —
  calls `initializePayment()` to create a Datatrans transaction, then
  `buildRedirectForm()` redirects the browser to the `Location` returned by
  Datatrans (`successUrl`/`cancelUrl`/`errorUrl` come from Commerce's own
  return/cancel URLs).
- **Webhook controller** `Controller/PaymentNotificationController::notifyPage` —
  route `commerce_datatrans.notify` → `POST /commerce/datatrans/notify`
  (`_access: 'TRUE'`; authenticated by HMAC, see below).
- **Payment method type** `datatrans_alias`
  (`Plugin/Commerce/PaymentMethodType/DatatransAlias`) — stores an alias/token for
  recurring/card-on-file payments, with fields `pmethod`, `masked_cc`, `expm`,
  `expy`.
- **Helper** `DatatransHelper` — `generateSign()` (HMAC-SHA256 over
  `timestamp . body`, key `pack('H*', $sign2)`) and `mapErrorCode()` (Datatrans
  numeric error-code → message).
- **Value object** `PaymentInitializeResponse` (redirect `Location` + decoded body).
- **Config schema** (`config/schema/…`) for the gateway settings. No `.module`,
  no `.install`, no permissions of its own, no Drush commands. Kernel tests under
  `tests/src/Kernel/` (`DatatransGatewayTest`, `DatatransWebhookTest`).

## Configuration (gateway plugin settings)

From `DatatransBase::buildConfigurationForm()` / `defaultConfiguration()`:

- **Merchant-ID** (`merchant_id`, required) — used as the HTTP Basic username to the
  API.
- **Password** (`password`, required) — the Server-to-Server UPP security password;
  HTTP Basic password to the API.
- **Webhook Sign Key (sign2)** (`hmac_key_2`) — HMAC key for verifying webhook
  notifications; required only if you use the webhook (the field's description shows
  the absolute webhook URL to register in the Datatrans backend).
- **Automatically settle the payment** (`auto_settle`, default TRUE).
- **Use Alias** (`use_alias`, default FALSE) — request an alias for recurring
  payments.
- **Initiate the initial payment without amount** (`no_initial_amount`, default
  FALSE) — for alias flows with Twint/PayPal.
- Plus the standard Commerce **mode** (test → `api.sandbox.datatrans.com`,
  live → `api.datatrans.com`).

## Payment flow (from source)

- **Checkout / initialize** — `DatatransForm` → `initializePayment()` POSTs
  `transactions` (amount in minor units, `refno = order->id()`, currency,
  `autoSettle`, optional alias options) and redirects the browser to the returned
  `Location`. Data is alterable via `hook_commerce_datatrans_initialize_payment_alter`.
- **Return** — `Datatrans::onReturn()` reads `datatransTrxId` from the query, and
  (if no completed payment exists yet) does an authenticated `GET transactions/{id}`
  to read the authoritative transaction status from Datatrans, then
  `processPayment()`.
- **Webhook** — `PaymentNotificationController::notifyPage()` looks up the order by
  the posted `refno`, resolves the Datatrans gateway, then **verifies the HMAC
  signature** before doing anything: it requires `sign2` to be configured (returns
  `403` if not), requires the `Datatrans-Signature: t=…,s0=…` header (rejects with
  `403` when absent), recomputes `DatatransHelper::generateSign()` over the raw
  request body, and rejects on mismatch. Only signed, whitelisted statuses
  (`settled`, `transmitted`, `authorized`) are processed; it then calls
  `processPayment()` and `PaymentOrderUpdater::updateOrders()`. This is a
  fail-closed, HMAC-authenticated webhook: without the `sign2` secret a caller
  cannot produce a valid signature. The base `onNotify()` (the generic Commerce
  notify callback) is intentionally disabled (returns `400`).
- **processPayment()** — de-dupes by transaction id (a non-pending payment for the
  same remote id is a no-op), creates/updates the Commerce payment at the order
  total, maps status → state (`settled`/`transmitted` → completed,
  `authorized` → authorization, else throws), and — when `use_alias` is on — creates
  a reusable `datatrans_alias` payment method from the returned alias/card data.
- **Refunds** — `refundPayment()` asserts state + amount, POSTs
  `transactions/{remoteId}/credit`, and moves the payment to
  `partially_refunded` / `refunded`.
- **Recurring / alias** — `authorizePayment()` POSTs `transactions/authorize` using
  a stored alias (per-method for TWI/PAP/PFC, otherwise `card.alias` + expiry) for
  merchant-initiated payments.

## Transport

All API calls (`DatatransBase::doRequest()`) go over `https://` with
`allow_redirects => FALSE` and HTTP Basic auth (`merchant_id`:`password`); test mode
targets the Datatrans sandbox host. TLS verification is left at the Guzzle default
(enabled).

The surface is a single gateway plugin plus its webhook controller and helper, so
everything is documented here — no separate subdocs are warranted.
