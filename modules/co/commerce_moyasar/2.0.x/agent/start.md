<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Moyasar — agent index

Off-site **Drupal Commerce** payment gateway for **Moyasar** (moyasar.com), a
Saudi Arabian PSP. The shopper pays through Moyasar's embedded payment form
(credit card / Apple Pay / STC Pay) and returns with a payment `id`; the order is
completed after a **server-side, authenticated re-fetch** of that payment from
Moyasar's API. This **2.0.x** branch adds reusing saved payment methods
(tokenized cards).

- **Version** `2.0.0-beta3` (beta). **Package** `Commerce (contrib)`.
- **Core** `^9.3 || ^10 || ^11` (from `commerce_moyasar.info.yml`).
- **PHP** `>=8.0` (composer.json).
- **Dependencies** `commerce:commerce_payment`; composer requires
  `drupal/commerce ^3.1`.
- **License** GPL-2.0-or-later. Covered by Drupal's security-advisory policy;
  project created 2017-12.

## What ships

- `src/Plugin/Commerce/PaymentGateway/Moyasar.php` — the
  `@CommercePaymentGateway(id = "moyasar_payment")` plugin, extends
  `OffsitePaymentGatewayBase`, implements `MoyasarInterface` and
  `SupportsStoredPaymentMethodsInterface`. `payment_method_types = {"credit_card"}`;
  credit-card types amex/mastercard/visa/mada; `requires_billing_information = FALSE`.
  Holds the config form, `onReturn()`, tokenized-card operations, and the shared
  `sendRequest()` HTTP helper.
- `src/Plugin/Commerce/PaymentGateway/MoyasarInterface.php` — marker interface
  extending `OffsitePaymentGatewayInterface`, `SupportsRefundsInterface`,
  `SupportsAuthorizationsInterface`.
- `src/PluginForm/MoyasarForm.php` — the `offsite-payment` plugin form
  (`PaymentOffsiteForm`). Builds `drupalSettings.commerce_moyasar` and attaches
  the `commerce_moyasar/init` library so Moyasar's JS renders the form inline.
- `commerce_moyasar.module` — `hook_commerce_payment_credit_card_types_alter()`
  registering the **Mada** card type.
- `commerce_moyasar.libraries.yml` — `init` library: Moyasar's hosted
  `moyasar-payment-form@2.0.14` UMD JS + CSS (external, from unpkg) plus
  `js/moyasar.form.js`.
- `config/schema/commerce_moyasar.schema.yml` — typed config for the gateway
  settings.

No routing.yml, services.yml, permissions.yml, or `.install`. There is no custom
route/controller; the module has no admin page of its own.

## Configuration (gateway plugin settings)

Set on the Commerce payment-gateway entity
(`/admin/commerce/config/payment-gateways`). Keys/defaults from
`defaultConfiguration()` (Moyasar.php:90-98):

| Key | Type | Notes |
| --- | --- | --- |
| `publishable_api_key` | textfield (required) | Moyasar publishable key; sent to the browser payment form. |
| `secret_api_key` | textfield (required) | Moyasar secret key; used server-side as HTTP Basic-auth username to re-fetch/verify payments and drive capture/void/refund. Keep confidential; prefer an env/Key-backed override. |
| `methods` | checkboxes (required) | Allowed methods: `creditcard`, `applepay`, `stcpay`. |
| `supported_networks` | checkboxes | `visa`, `mastercard`, `amex`, `mada`; shown only when `creditcard` is enabled; at least one required when credit card is on (`validateConfigurationForm`). |
| `reuse_payment_method` | checkbox (default TRUE) | Offer saving/reusing tokenized cards. |

Plus the standard Commerce gateway `mode` (test/live) and `display_label`.

## Payment flow

1. **Checkout (pay).** `MoyasarForm::buildConfigurationForm()` passes the order
   total (`toMinorUnits`), currency, description (`Order ID <id>`),
   `publishable_api_key`, the checkout return URL as `callback_url`, selected
   methods/networks, `metadata.order_id`, and `manual` (= not capture) into
   `drupalSettings`; `js/moyasar.form.js` calls `Moyasar.init(...)` to render the
   embedded form. A **Cancel** link points at the checkout cancel URL.
2. **Return (completion).** `Moyasar::onReturn()` (Moyasar.php:304-342) reads the
   payment `id` from the return query and **re-fetches it server-side** with
   `sendRequest("payments/$id", 'GET')` (HTTP Basic auth using `secret_api_key`).
   It records a `commerce_payment` and completes the order only when Moyasar's API
   reports status `paid`/`captured` (→ `completed`) or `authorized`
   (→ `authorization`) — so completion truth comes from Moyasar's authenticated
   API, not the returning request. When `reuse_payment_method` is on and the source
   is a credit card, a reusable `commerce_payment_method` is created from the
   returned card token.
3. **Terminal operations** (admin, via `sendRequest`):
   - `createPayment()` — server-side charge of a saved token; body uses the order
     total (`toMinorUnits`), currency, `metadata.order_id`, `given_id` (UUID).
   - `capturePayment()` / `voidPayment()` — `payments/{id}/capture` | `/void`.
   - `refundPayment()` — `payments/{id}/refund`; tracks partial vs. full refund.
   - `createPaymentMethod()` / `deletePaymentMethod()` — token lifecycle
     (`tokens/{token}` DELETE).

## `sendRequest($resource_path, $method, $params)`

Shared Guzzle helper (Moyasar.php:382-426). Base URL is hardcoded
`https://api.moyasar.com/v1/`; JSON `Content-Type`; `auth => [secret_api_key, '']`
(Basic). POST sends a JSON body; GET appends a query string. Returns
`['status' => bool, 'data' => decodedJson]` (true on 200/201/204). TLS
verification is left at Guzzle's secure default. Errors raise
`InvalidResponseException`.

## Security posture (positive)

Order completion is anchored to Moyasar's authenticated API: `onReturn()`
re-fetches `GET /v1/payments/{id}` server-side with the secret key (Basic auth)
and completes on the API-reported status. The API host is hardcoded (no free-text endpoint, no
SSRF), and TLS certificate verification uses Guzzle's secure default. Store the
Moyasar secret key in an environment variable / settings override and never commit
it to VCS.

## See also

- `../usage.md` — task-oriented summary.
- `../human-docs/` — UI setup guide for site builders.
