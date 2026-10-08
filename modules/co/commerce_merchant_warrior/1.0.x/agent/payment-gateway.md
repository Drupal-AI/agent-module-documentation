<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payframe gateway plugin & add-payment form

Plugin `merchant_warrior_payframe` — `src/Plugin/Commerce/PaymentGateway/Payframe.php`
(extends `OnsitePaymentGatewayBase`; interface `PayframeInterface` extends
`OnsitePaymentGatewayInterface`, `SupportsAuthorizationsInterface`,
`SupportsRefundsInterface`). Injects the `commerce_merchant_warrior.api_client`, messenger,
`commerce_price.rounder`, and `current_route_match`.

Plugin annotation: `payment_method_types = {"credit_card"}`; `credit_card_types` amex,
dinersclub, discover, mastercard, visa; `requires_billing_information = TRUE`; form
`add-payment-method = PayframePaymentForm`.

## Configuration form (`buildConfigurationForm` / `defaultConfiguration`)

Three settings on top of the base gateway config (`mode`, `display_label`, transaction
type/allowed statuses):

- `merchant_uuid` — Merchant Warrior merchant identifier (`#required`).
- `api_key` — Merchant Warrior API key (`#required`).
- `api_passphrase` — passphrase used to sign requests (`#required`).

`submitConfigurationForm()` writes the three values back. These are read at runtime by the
API client from `commerce_payment.commerce_payment_gateway.merchant_warrior_payframe`
config (`configuration.*`). Store them as secrets (env/Key) and serve HTTPS.

## Payment operations

- **`createPayment($payment, $capture = TRUE)`** — asserts state `new`, asserts the payment
  method. Amount from `$payment->getAmount()` (rounded). Builds a transaction array from the
  order + billing profile (`transactionAmount`, `transactionCurrency`, `transactionProduct`
  = "Order ID: {id}", customer email/name/address, `cardID` = payment method remote id).
  - `$capture === TRUE` → adds `captureAmount` and calls **`processTokenCard()`** (auth +
    capture), next state `completed`.
  - `$capture === FALSE` → calls **`processTokenAuthorization()`**, next state
    `authorization`, sets expiry to now + 29 days.
  - Stores MW `transactionID` as the payment remote id. Guzzle `RequestException` →
    `HardDeclineException`.
- **`capturePayment($payment, $amount = NULL)`** — asserts `authorization`; amount defaults
  to the payment amount (rounded); calls **`processCapture()`** with the auth
  `transactionID`; sets state `completed`, updates remote id.
- **`voidPayment($payment)`** — asserts `authorization`; requires a remote id; calls
  **`processVoid()`**; sets state `authorization_voided`.
- **`refundPayment($payment, $amount = NULL)`** — asserts `completed` /
  `partially_refunded`; **refuses refunds older than 180 days**
  (`InvalidRequestException`); `assertRefundAmount()`; calls **`refundCard()`**; sets
  `partially_refunded` or `refunded` and records the refunded amount.
- **`createPaymentMethod($payment_method, $payment_details)`** — requires
  `merchant_warrior_access_token`, `merchant_warrior_payframe_token`,
  `merchant_warrior_payframe_key`, `currency_code` (throws `InvalidArgumentException`
  otherwise). Gets the order from the current route + billing profile, calls
  **`verifyCard()`** (`addCard => 1`) to register the card token with MW, then
  **`cardInfo()`** for BIN/last-4/expiry. Detects card type via `CreditCard::detectType()`;
  stores **only** card type, last 4 (`cardNumberLast`), and expiry; remote id = MW `cardID`;
  sets expiry timestamp. Guzzle failure → `HardDeclineException`.
- **`deletePaymentMethod($payment_method)`** — deletes the local entity only (no remote
  delete call).

All amounts are taken from the Commerce `Payment`/`Order` objects, never from request input.

## Add-payment-method form — `src/PluginForm/Onsite/PayframePaymentForm.php`

Extends `PaymentMethodAddForm`. `buildCreditCardForm()`:

- Adds markup containers `#cardData` (Payframe mount) and `#payment-errors`.
- If no access token yet in form state, calls `apiClient->getAccessToken()` server-side.
- Adds hidden fields `merchant_warrior_access_token`, `merchant_warrior_payframe_token`,
  `merchant_warrior_payframe_key`, and a `currency_code` value (store default currency).
- Attaches `drupalSettings.commerceMerchantWarriorPayframe` (`submitUrl`, `accessToken`,
  `src`, chosen by `mode`), the MW payframe library, and the module's `payframe_form` JS.

`validateCreditCardForm()` / `submitCreditCardForm()` are intentionally empty — the JS does
Payframe validation and the gateway plugin processes the details.

### JS — `js/commerce_merchant_warrior_payframe.form.js`

Library `commerce_merchant_warrior/payframe_form` (deps: jQuery, drupal, once). Instantiates
MW's global `payframe` with the access token + submit/src URLs, method `getPayframeToken`.
On the form submit it calls `mwPayframe.submitPayframe()`; the `mwCallback` fires with
`tokenStatus`. On `HAS_TOKEN` it writes the access token / Payframe token / Payframe key into
the hidden fields and submits the real form; otherwise it renders an error message. Card
data itself stays inside the MW iframe — only the tokens cross into the Drupal form.
