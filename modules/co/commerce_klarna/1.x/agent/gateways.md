<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateways, config, and payment lifecycle

Files: `src/Plugin/Commerce/PaymentGateway/KlarnaPaymentsBase.php` (abstract base),
`KlarnaPayments.php`, `KlarnaMerchantCard.php`, `KlarnaPaymentsInterface.php`,
`KlarnaMerchantCardInterface.php`; method types in `src/Plugin/Commerce/PaymentMethodType/`.

Both gateways extend `KlarnaPaymentsBase extends OnsitePaymentGatewayBase` and implement
`KlarnaPaymentsInterface` (which extends Commerce `OnsitePaymentGatewayInterface`,
`SupportsAuthorizations`, `SupportsRefunds`, `SupportsNotifications`). Annotation for both:
`requires_billing_information = FALSE`, `js_library = "commerce_klarna/payments"`,
`forms."add-payment-method" = PaymentMethodAddForm`.

## Plugins

| Plugin id | Class | Method type | Purpose |
|---|---|---|---|
| `klarna_payments` | `KlarnaPayments` | `klarna` | Standard Klarna Payments. |
| `klarna_merchant_card` | `KlarnaMerchantCard` | `klarna_merchant_card` | Merchant Card Service (virtual cards). |

## Configuration (defaultConfiguration + buildConfigurationForm on the base)

Stored in plugin config (no `config/schema` shipped). Keys and defaults:

| Key | Default | Notes |
|---|---|---|
| `mode` | `test` | Inherited enum test/live (from `PaymentGatewayBase`). Selects the API host + Klarna environment. |
| `username` | `''` | Klarna API username. Required field. |
| `password` | `''` | Klarna API key — used verbatim as the HTTP Basic credential (`Basic <password>`) in `KlarnaManager::apiRequest()`. Required. |
| `client_token` | `''` | Klarna client identifier; passed to the JS SDK and on-site messaging. Required. |
| `store_id` | `''` | Used only to build the Klarna portal `getExternalUrl()`. Required. |
| `region` | `eu` | `eu` / `na` / `oc`. Selects the API base URL (see api.md `KLARNA_REGIONS`). Required. |
| `express_checkout.enabled` | `FALSE` | Show the Klarna express button on the cart page. |
| `express_checkout.shipping` | `FALSE` | Collect shipping address via Klarna (needs the `commerce_klarna_shipping` submodule). |
| `style.theme` | `default` | Button theme: default / light / outlined. |
| `style.shape` | `default` | Button shape: default / rect / pill. |
| `onsite_messaging.add_to_cart` | `FALSE` | Messaging on add-to-cart forms. |
| `onsite_messaging.cart` | `FALSE` | Messaging on the cart page. |
| `onsite_messaging.checkout` | `FALSE` | Messaging during checkout when Klarna is selected. |
| `image_field` | `NULL` | Machine name of a product-variation image field to send as `image_url` on order lines. |
| `log_requests` | `FALSE` | Log Klarna API response bodies to the `commerce_klarna` dblog channel. |

`KlarnaMerchantCard` adds an `mcs` fieldset: `mcs.enabled`, `mcs.private_key` (RSA private key,
textarea), `mcs.key_id`, and `mcs.acquirer` (`_none` or the id of another enabled gateway whose plugin
exposes a `credit_card` method type — the external card processor used for real captures).

There is **no dedicated settings route** (`configure` is null); gateways are added/edited at
`/admin/commerce/config/payment-gateways`.

## KlarnaPayments lifecycle (`KlarnaPayments.php`)

- `createPayment($payment, $capture = TRUE)` — asserts state `new`; reads `authorization_token` from
  the payment method's `remote_id`; calls `KlarnaManager::createOrder()` → sets payment state
  `authorization`, `remote_id = response['order_id']`, and stores
  `authorized_payment_method.type` on the method (`klarna_payment_type`). Amount/currency are rebuilt
  server-side by the manager; Klarna binds them to the authorization.
- `capturePayment($payment, $amount = NULL)` — asserts `authorization`; captures (full amount if
  unset) via `KlarnaManager::captureOrder()`; state → `completed`.
- `refundPayment(...)` — asserts `completed`/`partially_refunded`; `refundOrder()`; state →
  `partially_refunded` or `refunded`.
- `voidPayment(...)` — `cancelOrder()`; state → `authorization_voided`.
- `onNotify(Request)` — **no-op** (defined on the base). Completion never depends on an inbound push.

## KlarnaMerchantCard lifecycle (`KlarnaMerchantCard.php`)

- `createPayment()` — creates the Klarna order (`createOrder`), then a card **promise**
  (`createCardPromise`) and **settlement** (`createCardSettlement`), storing `klarna_promise_id`,
  `klarna_settlement_id`, `klarna_cards`, expiry on the method; marks a **zero-amount** placeholder
  payment `completed` (the real charge is expected via the external acquirer). If a promise already
  exists it is re-fetched instead.
- `capturePayment()` / `refundPayment()` — delegate to the configured external acquirer gateway
  (`getCardAcquirer()`) when the payment amount is non-zero; otherwise no-op.
- `voidPayment()` — external acquirer void for non-zero amounts, else `cancelMerchantCardOrder()`.
- `decryptCard($card_values)` — helper (`KlarnaMerchantCardInterface`) that RSA-decrypts the AES key
  (`openssl_private_decrypt`, PKCS#1 v1.5) then AES-128-CTR-decrypts `pci_data`, per Klarna's MCS spec.
  Not called elsewhere in the module — a base helper for a custom MCS implementation.

## Method types

`Klarna` and `KlarnaMerchantCard` (`PaymentMethodType/*`) add bundle fields: `klarna_payment_type`
(list_string keyed by `KlarnaManagerInterface::KLARNA_PAYMENT_METHODS` → labels *Pay now / Pay later /
Pay over time*), `klarna_installments`, `klarna_days`; MCS also adds `klarna_promise_id`,
`klarna_settlement_id`, `klarna_cards`. `buildLabel()` renders e.g. "Klarna Pay later".

`PaymentMethodAddForm` (`src/PluginForm/Klarna/`) injects the Klarna widget container + a hidden
`session` field, attaches the JS library and `drupalSettings.commerceKlarna`, and on submit stashes the
decoded session JSON into the order's `klarna_payment_session` data key.

## Other base helpers

- `getApiUrl()` = `KLARNA_REGIONS[region][mode]`.
- `getExternalUrl($payment)` — deep link to the Klarna portal order (`portal` vs `portal.playground`).
- `createBillingProfile($payment)` — fetches the Klarna order (`getOrder`) and builds a `customer`
  profile from its `billing_address` (fails silently on `KlarnaException`).
