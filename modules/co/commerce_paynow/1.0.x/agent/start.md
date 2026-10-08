<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Paynow (commerce_paynow) — agent index

A **Drupal Commerce offsite payment gateway for Paynow (mBank)** — the Polish payment provider
run by mBank (`api.paynow.pl` / `api.sandbox.paynow.pl`), **PLN only**. At checkout the shopper
is authorized against Paynow's REST API and redirected to Paynow; the outcome is then confirmed
two ways — a signed async webhook and, on browser return, a live status re-fetch from Paynow's
authenticated API. Package `Commerce`. Core `^11` (from `.info.yml`). License GPL-2.0-or-later.
Installed as **1.0.2** (version dir `1.0.x`). Maintainer: Piotr Ramotowski (ramotowski).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (required, from `.info.yml`).
- PHP libraries (`composer.json`): **`pay-now/paynow-php-sdk` `^3.0`** (the official Paynow SDK),
  **`drupal/commerce` `^3.0`**, **`drupal/core` `^11`**.

## What it provides (from source)

- **One payment gateway plugin** `paynow` — `src/Plugin/Commerce/PaymentGateway/Paynow.php`
  (`#[CommercePaymentGateway]`, extends `OffsitePaymentGatewayBase`, implements
  `SupportsNotificationsInterface`, `requires_billing_information: FALSE`). Offsite-redirect form
  `src/PluginForm/PaynowForm.php` (`offsite-payment`). Config keys on the
  `commerce_payment_gateway.<id>` entity: `api_key`, `signature_key`, `application_name`,
  `environment` (`sandbox`/`production`), `enable_logging`.
- **One route** `commerce_paynow.webhook` →
  `POST /commerce-paynow/webhook/{commerce_payment_gateway}` (`_access: 'TRUE'`), controller
  `src/Controller/PaynowWebhookController.php` — a thin adapter that delegates to
  `$plugin->onNotify($request)`.
- **Services** (`commerce_paynow.services.yml`): `NotificationProcessor` (async webhook),
  `ReturnFlowProcessor` (browser return), `PaymentDataBuilder`, `PaymentAuthorizer`,
  `PaynowClientFactory`, `IdempotencyKeyGenerator`, `OrderNumber`, `PaymentRepository`,
  and a `PaynowLoggerFactory` producing an immutable `BoundPaynowLogger`.
- **Value object** `src/ValueObject/PaynowStatusMap.php` — the single allowlist/classifier for
  Paynow statuses (`NEW`, `PENDING`, `CONFIRMED`, `REJECTED`, `ERROR`, `EXPIRED`, `ABANDONED`).
- **Config schema** `config/schema/commerce_paynow.schema.yml` for the gateway plugin. No
  `.install`, no `.module`, no `.permissions.yml`, no templates, no JS of its own (the offsite
  redirect and checkout-return routes come from `commerce_payment`).

## Verification posture (payment gateway)

Server-authoritative on both paths — never trusts a client-supplied status or amount.
- **Async webhook** (`onNotify` → `NotificationProcessor`): the Paynow SDK
  `new Notification($signatureKey, $payload, $headers)` **verifies the `Signature` header
  (HMAC-SHA256) and throws on mismatch** before anything else; the payment is recorded with the
  **server-side order total** (`$order->getTotalPrice()`), bound to the order via
  `externalId → order_number` and `paymentId → remote_id`; a distributed lock + terminal-state
  guard make it idempotent.
- **Browser return** (`onReturn` → `ReturnFlowProcessor`): ignores the `paymentStatus` query
  param and **re-fetches the authoritative status from Paynow's authenticated API**
  (`Paynow\Service\Payment::status($paymentId)`), completing only on a remote CONFIRMED; the local
  payment is loaded bound to `order_id` + `payment_gateway` (BOLA defense).

See [payment/verification-flow.md](payment/verification-flow.md).

## Credentials

`api_key` and `signature_key` come from the Paynow merchant panel. In the admin form they are
`#type => 'password'` with blank-to-keep behaviour (leave empty to keep the stored value). Store
them env-backed (e.g. DDEV dotenv) and never commit them.

## Solution docs

- **Offsite authorization, webhook & return verification, status map, idempotency, config form** →
  [payment/verification-flow.md](payment/verification-flow.md)

> Live Paynow API calls need real merchant credentials. Ground local work in the gateway **config
> entity** (`commerce_payment_gateway.<id>`, plugin `paynow`) using `sandbox` environment and
> placeholder keys; the offsite redirect and status checks require a reachable Paynow sandbox.
