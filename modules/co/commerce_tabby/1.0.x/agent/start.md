<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Tabby (commerce_tabby) — agent index

A **Drupal Commerce offsite payment gateway for Tabby** — the Tabby "buy now, pay
later" / instalments provider for the MENA / Saudi market. At checkout the shopper is
redirected to Tabby's hosted instalment checkout and returned to the store; the
outcome is confirmed on the return leg and via a Tabby webhook, in both cases by
re-fetching the payment from **Tabby's authenticated API** (`GET v2/payments/{id}`).
Package `Commerce (contrib)`. Core `^11.1` (`.info.yml`); `composer.json` is looser
(`drupal/core ^10 || ^11`, `drupal/commerce ^2.25 || ^3`, PHP `>=8.0`). License
GPL-2.0-or-later. Installed as **1.0.0-beta5** (version dir `1.0.x`) — a beta release.

## Dependencies

- Drupal module (`.info.yml`): **`commerce:commerce_payment`** (pulls in the Commerce
  order/payment stack). No PHP-library requirements beyond Commerce itself.
- Uses Tabby's REST API at `https://api.tabby.ai/api/` via core `http_client`
  (Guzzle). No bundled JS, CSS, templates, routing, permissions, or install hooks —
  the offsite redirect, return, and notify routes all come from `commerce_payment`'s
  `OffsitePaymentGatewayBase`.

## What it provides (from source)

- **One payment gateway plugin** `tabby` —
  `src/Plugin/Commerce/PaymentGateway/Tabby.php` (`@CommercePaymentGateway`, label/
  display label "Tabby Payment"), extends `OffsitePaymentGatewayBase`, implements
  `TabbyInterface` which extends `OffsitePaymentGatewayInterface`,
  `SupportsRefundsInterface`, `SupportsAuthorizationsInterface`,
  `SupportsNotificationsInterface`. Payment method type `credit_card`; card types
  amex/dinersclub/discover/jcb/maestro/mastercard/visa.
- **Offsite redirect form** `src/PluginForm/TabbyRedirectForm.php` (`offsite-payment`
  form, extends `PaymentOffsiteForm`) — calls `prepareCheckout()` to create the Tabby
  checkout session, then `buildRedirectForm()` GET-redirects the shopper to
  `session.configuration.available_products.installments[0].web_url`. If no
  `available_products` are returned it throws with the session's
  `rejection_reason_code`.
- **Hook class** `src/Hook/CommerceTabbyHooks.php` (attribute-based
  `#[Hook(...)]`): `commerce_payment_gateway_presave` re-registers the Tabby webhook
  (unregister + register), and `commerce_payment_gateway_delete` unregisters it.
- **Config schema** `config/schema/commerce_tabby.schema.yml` for the gateway plugin
  config. No `.permissions.yml`, no `.install`, no Drush commands.

## Configuration fields (gateway plugin form)

`merchant_code`, `public_key`, `secret_key` (all required text fields);
`telephone_field` (required select — a `profile:customer` field holding the buyer
phone, which Tabby requires); `birthdate_field` (required select — a `user` field for
the buyer date of birth); `auto_capture` (checkbox); `webhook_id` (hidden, populated
automatically on save). Plus the base `mode` (test/live) and `collect_billing`.
Defaults in `defaultConfiguration()`.

## Payment flow (from source)

1. **Checkout / redirect** — `TabbyRedirectForm::buildConfigurationForm()` →
   `Tabby::prepareCheckout($order, $payment, $form)` builds a Tabby v2 checkout
   payload (amount/currency from `$order->getTotalPrice()`, buyer name/email/phone/
   dob, shipping address, per-item lines, tax/shipping/discount totals, plus
   `buyer_history` and `order_history` derived from the customer's prior completed
   orders) with `merchant_urls.success/failure = #return_url`,
   `merchant_urls.cancel = #cancel_url`, and **`meta.payment_id` = the local payment
   id**. It POSTs `v2/checkout` and the shopper is redirected to the returned
   `web_url`.
2. **Return** — `onReturn($order, $request)` reads `payment_id` from the query and
   calls `authorisePayment()`.
3. **Webhook** — `onNotify($request)` reads `id` from the JSON body and calls
   `authorisePayment()`. The notify URL is auto-registered with Tabby (`v1/webhooks`,
   `X-Merchant-Code` header) on gateway save and deleted on gateway delete
   (`registerWebhook` / `unregisterWebhook`, stored in `webhook_id`).
4. **`authorisePayment($payment_id)`** — re-fetches the payment from Tabby with an
   authenticated `GET v2/payments/{id}` (secret key bearer token), proceeds only when
   the API status is `CLOSED` or `AUTHORIZED`, resolves the local payment via the
   API's `meta.payment_id`, then under a `lock` (`tabby_payment_{id}`) transitions the
   payment: `CLOSED` → `completed`; otherwise if `auto_capture` → `capturePayment`;
   else apply the `authorize` transition. It no-ops once the local payment has left
   state `new`.
5. **Capture / refund** — `capturePayment()` POSTs `v2/payments/{id}/captures`;
   `refundPayment()` POSTs `v2/payments/{id}/refunds` (partial vs full handled),
   each with a server-generated `reference_id`. `voidPayment()` only asserts state.

## API surface

All Tabby calls go through `sendRequest($resource_path, $method, $params, $headers)`
against `https://api.tabby.ai/api/`, adding `Authorization: Bearer {secret_key}` and
`Content-Type: application/json`; POST sends JSON, GET sends a query string. Endpoints
used: `v2/checkout`, `v2/payments/{id}` (GET), `v2/payments/{id}/captures`,
`v2/payments/{id}/refunds`, `v1/webhooks` (POST/DELETE).

## Gotchas / notes

- **Beta**: 1.0.0-beta5 — under active development.
- `prepareCheckout()` and `buildOrderHistory()` assume the order has a **`shipments`**
  field with at least one shipment (`$order->get('shipments')->referencedEntities()[0]`)
  — an order without Commerce Shipping shipments will error. The billing profile is
  also assumed present.
- `birthdate_field` reads a **user** field, `telephone_field` a **customer profile**
  field; both are required by the config form because Tabby requires buyer phone and
  DOB.
- Language is sent as `ar` when the current UI language is Arabic, else `en`.

## Related docs

- `usage.md` — one-paragraph task-level summary.
- `human-docs/` — click-through install/configuration guide for site builders.
