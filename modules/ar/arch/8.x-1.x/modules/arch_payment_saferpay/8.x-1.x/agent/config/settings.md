<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arch Payment Saferpay: configuration & API flow

## Configuration

Edit via the payment-methods admin: `/admin/store/settings/payment-methods/saferpay`
(`PaymentMethodConfigureController` → `Saferpay::buildConfigurationForm()`), perm
`administer payment settings`. Values are saved to config object **`arch_payment_saferpay.settings`**
(schema `arch_payment_saferpay.config`):

| Key | Type | Meaning |
|---|---|---|
| `customer_id` | string | Saferpay customer id |
| `terminal_id` | string | Saferpay terminal id |
| `username` | string | Saferpay API (JSON) username |
| `password` | string | Saferpay API password |
| `spec_version` | string | JSON API `SpecVersion` (install default `1.20`) |
| `force_sca` | bool | Force a PSD2/3-D-Secure challenge (`Authentication.ThreeDsChallenge = FORCE`) |

The form also has a **Test mode** checkbox. This does **not** live in the config object — it is a
`state` value **`arch_payment_saferpay_test`** (submit handler `Saferpay::submitConfigurationForm()`),
and it defaults to **TRUE**.

## Endpoint selection — `SaferpayHandler::getSettings()`

- Test mode ON → endpoint `https://test.saferpay.com/api`.
- Test mode OFF → endpoint `https://www.saferpay.com/api`, using the saved
  `customer_id`/`terminal_id`/`username`/`password` from config.

## API flow

`SaferpayPaymentController` (routes all `_permission: access content`, `no_cache: TRUE`):

1. **redirect** (`callback_route`): `redirectPage()` — `setOrder(?order)`, `callInitialize()`
   (POST `/Payment/v1/PaymentPage/Initialize`), then `TrustedRedirectResponse` to the returned
   `RedirectUrl`. On error, message + redirect `arch_checkout.checkout`.
2. Shopper pays on Saferpay, returns to **success** `/payment/saferpay/success?order=<id>` —
   `paymentSuccess()` calls `callAssert()` (POST `/Payment/v1/PaymentPage/Assert`, by stored
   `saferpay_token`); if the returned `Transaction.Status` is not `captured`, `callCapture()`
   (POST `/Payment/v1/Transaction/Capture`). Then redirect `arch_checkout.complete`.
3. **error** / **cancel** — a message and redirect back to checkout.

`SaferpayHandler` builds the request in `processUrl()`: Guzzle `POST`, `headers` JSON,
`auth => [username, password]` (HTTP basic over TLS — Guzzle's default certificate verification is
**left on**), `timeout => 100`. The charge amount is `order.grandtotal_gross` rounded to the
currency's rounding step, ×100 (minor units). Token/transaction/capture bodies are persisted on the
order via `setDataKey()`.

## Operational notes

- Because **Test mode defaults to ON**, a freshly configured site will hit the Saferpay *test*
  environment until an operator explicitly unchecks it — real card charges only happen with test
  mode off and live credentials saved.
- `validateConfigurationForm()` is a `@todo` (no validation). `password` is a plain textfield and is
  stored in the `arch_payment_saferpay.settings` config object (no Key-entity indirection); treat
  the exported config as sensitive.
- `RequestId`s are `sha1(order_id . time())`; `ClientInfo.ShopInfo` is the site host.
