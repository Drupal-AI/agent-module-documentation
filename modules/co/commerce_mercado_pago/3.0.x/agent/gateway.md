<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_mercado_pago — gateway plugin

`CheckoutPro` (`src/Plugin/Commerce/PaymentGateway/CheckoutPro.php`), plugin id
`mercado_pago_checkout_pro`. Extends `OffsitePaymentGatewayBase`, implements
`SupportsRefundsInterface`. Offsite-only: `createPaymentMethod()` throws; payment methods are created
during `onReturn()`/`onNotify()`.

Annotation: `payment_method_types = {"mercado_pago_checkout_pro"}`,
`credit_card_types = {amex, mastercard, visa}`, form `offsite-payment = RedirectCheckoutForm`,
modes `test` / `stage` / `live`. A hard-coded `INTEGRATOR_ID` is sent on every SDK call
(`MercadoPagoConfig::setIntegratorId()`).

## Config entity keys
Config id: `commerce_payment.commerce_payment_gateway.plugin.mercado_pago_checkout_pro`
(schema `commerce_payment_gateway_configuration`). Keys (all in `defaultConfiguration()`):

| Key | Type | Notes |
|---|---|---|
| `mode` | string | `test` / `stage` / `live` (from base). Selects which credential pair is used. |
| `public_key_test` / `access_token_test` | string | Sandbox credentials. |
| `public_key_stage` / `access_token_stage` | string | Production account + test credentials. |
| `public_key_prod` / `access_token_prod` | string | Production credentials. |
| `client_id` / `client_secret` | string | MP application client id/secret. |
| `redirect_mode` | string | `redirect` (same window) or `external_redirect` (popup via intermediate return page). |
| `country` | string | One of AR, BR, CL, CO, MX, PE, UY. Required. Filters available types/methods. |
| `payment_types` | array | Enabled MP payment types (per country). |
| `payment_method` | array | Enabled methods, keyed per type (card types share a "card brands" block). |
| `max_installments` | int | 1–12 (default 12), clamped on save. |
| `autofee` | bool | Acquirer fee flag (default FALSE; passed through, largely a stub). |
| `debug_logging` | bool | When on, logs full preference request + IPN/payment payloads. Default FALSE. |

Credential + country + max_installments are validated in `validateConfigurationForm()`
(mode-specific access token/public key required; country required; installments 1–12).

Access token for the current mode is resolved by `getAccessToken()` and set on the SDK in the
constructor and `__wakeup()`.

## Country / payment-method map
`MercadoPagoPaymentMethodsMap` is a static map: `$methodsByCountryAndType[country][type_id][method_id] => label`.
Payment types: `account_money`, `atm`, `bank_transfer`, `credit_card`, `debit_card`, `prepaid_card`,
`ticket`, `digital_currency`. `account_money` and `digital_currency` are **always enabled** (never shown
in the form, never excluded). The admin form (AJAX by country) lets you choose which of the remaining
types/methods to accept; Credit/Debit/Prepaid are merged into one "Card brands" checkbox block.

The gateway sends only **exclusions** to the Checkout Preference:
`getExcludedPaymentTypesForPreference()` and `getExcludedPaymentMethodsForPreference()` compute the
types/methods NOT selected (Checkout Pro's exclusion API is global — a method disabled in any card type
is excluded everywhere). Built in `RedirectCheckoutForm` into
`payment_methods.excluded_payment_methods` / `excluded_payment_types`, plus
`installments = max_installments`, `default_installments = 1`.

## Preference request (RedirectCheckoutForm)
Builds `items` (title, quantity, unit_price, currency, sku id, description, picture_url from
variation/product image fields), `payer` (name/surname/email/address from the billing profile — billing
profile with an address is **required**), `shipments` (sums non-included `shipping` adjustments),
`external_reference = order id`, `binary_mode => TRUE`, `auto_return = 'approved'`,
`notification_url = commerce_payment.notify?source_news=ipn`, `back_urls` (success/pending/failure).
Creates the preference via `PreferenceClient::create()`, stores `preference_id` in
`order->setData('commerce_mercado_pago_checkout', ...)`, sets `#action = preference->init_point`.

- **Redirect mode**: standard Commerce `buildRedirectForm()` POST to `init_point`.
- **External redirect mode**: attaches `checkout_popup` JS; the customer clicks a button, JS
  `window.open()`s `init_point`; MP returns to `commerce_mercado_pago.checkout_popup_return` which
  closes the popup and redirects the opener to the Commerce return URL (same-origin-only, escaped).

## Callbacks
### onNotify(Request) — IPN webhook (`commerce_payment.notify`)
Reads `topic` + `id` from the query, sets the SDK access token, then:
- `topic=payment`: `PaymentClient::get((int) id)`; resolves merchant order id from the payment's
  `order` field and `MerchantOrderClient::get()`. Loads the Commerce order via
  `merchant_order->external_reference`. Idempotent (skips if a payment with same order_id+remote_id
  exists). Creates a payment method + payment (amount = MP `transaction_details.total_paid_amount`,
  currency = MP `currency_id`) and sets it `completed`. Handles `status == 'refunded'` by updating an
  existing payment to `refunded`/`partially_refunded`.
- `topic=merchant_order`: `MerchantOrderClient::get()`, loads order by `external_reference`, logs
  paid-vs-total (informational; does not itself create a payment).

Payment status/amount come from the **re-fetched MP API objects**, not the request body.

### onReturn(OrderInterface, Request) — browser return
Requires a stored `preference_id`. Reads `payment_id`, `merchant_order_id`, `status` from the query
(errors if missing). **Re-fetches** the payment via `PaymentClient::get()` and requires the API
`status === 'approved'` (strict). Fetches the merchant order and requires
`external_reference === order id` to bind the payment to this order. Idempotent vs. an
IPN-created payment. Records a `completed` payment (amount = `order->getBalance()`).

### onCancel(OrderInterface, Request)
Adds a "you canceled checkout" message; no state change.

### refundPayment(Payment, Price|null)
Asserts state `completed`/`partially_refunded`; `PaymentRefundClient::refundTotal()` (full) or
`refund($id, $amount)` (partial); sets `refunded`/`partially_refunded` and remote state.

## Notes for agents
- Debug messages go to logger channel `Mercado Pago debug`; callbacks log to `Mercado Pago
  Notifications` / `Mercado Pago OnReturn` / `Mercado Pago Refund`. The access token is not logged.
- The legacy `js/mercado_pago.checkoutpro.js` (Wallet Brick) is not wired into the current flow.
- Store `access_token_*` / `client_secret` as secrets (env var → drupal/key) rather than committing
  them; they are gateway config and are included in config export. Serve checkout over HTTPS.
