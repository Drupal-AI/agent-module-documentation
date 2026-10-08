<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway plugin — EnzonaRedirectCheckout

`src/Plugin/Commerce/PaymentGateway/EnzonaRedirectCheckout.php`. Plugin id
`enzona_redirect_checkout`, label "Enzona Redirect Checkout", display label
"Enzona". Extends `OffsitePaymentGatewayBase`. Declares
`payment_method_types = {"credit_card"}`, credit-card types mastercard / visa /
american_express, and one form: `offsite-payment` =>
`EnzonaRedirectCheckoutForm`.

## Configuration (`defaultConfiguration` / `buildConfigurationForm`)

| Key | Type | Default | Notes |
|-----|------|---------|-------|
| `consumer_key` | textfield, required | `''` | EnZona API Consumer Key |
| `consumer_secret` | textfield, required | `''` | EnZona API Consumer Secret |
| `merchant_id` | textfield, required | `''` | numeric merchant id |
| `merchant_uuid` | textfield, optional | `''` | merchant UUID |
| `grant_type` | select, required | `client_credentials` | `client_credentials` or `password` |
| `username` | textfield | `''` | shown/required only when `grant_type = password` |
| `password` | password | `''` | shown/required only when `grant_type = password` |
| `api_base_url` | textfield, required | `https://api.enzona.net/payment/v1.0.0` | sandbox: `https://sandbox.enzona.net/payment/v1.0.0` |
| `test_mode` | checkbox | `TRUE` | |
| `terminal_id` | number, required | `12121` | |

Credentials are stored directly in the payment-gateway config entity (no Key
module integration). `submitConfigurationForm()` copies each value into
`$this->configuration`.

## EnZona REST API methods

All build an ad-hoc `GuzzleHttp\Client` with `timeout => 30` and
`verify => !$this->configuration['test_mode']`.

- **`authenticate(): ?string`** — OAuth2 token. Token URL is `api_base_url` with
  `/payment/v1.0.0` stripped + `/token`. Sends `Authorization: Basic
  base64(consumer_key:consumer_secret)`, `form_params` `grant_type` +
  `scope=enzona_business_payment`. Returns `access_token` from the JSON body.
- **`createPayment(OrderInterface $order, $return_url): ?array`** — authenticates,
  then `POST {api_base_url}/payments` with a JSON body built from the order:
  `amount.total` (order total, 2-dp string via `formatEnzonaAmount()`), per-item
  `items[]` (quantity/price/name/description/tax), `currency`
  (`$order->getTotalPrice()->getCurrencyCode()`, e.g. CUP), `merchant_uuid`
  (dropped if empty), `merchant_op_id` = `(int) merchant_id`, `invoice_number` =
  order id, `return_url` and `cancel_url` (both set to the passed `$return_url`),
  `terminal_id`. On success returns
  `['uuid' => …, 'transaction_uuid' => …, 'checkout_url' => …]`; the checkout URL
  is taken from the response `links[]` entry with `rel === 'confirm'`, else built
  as `{api_base_url}/payments/checkout/{uuid}`.
- **`getPaymentDetails($transaction_uuid): ?array`** — `GET
  {api_base_url}/payments/{uuid}` with the bearer token; returns the decoded JSON
  (includes `status_code` / `status_denom`).
- **`completePayment($transaction_uuid): array`** — `POST
  {api_base_url}/payments/{uuid}/complete` with an empty JSON object. Treats HTTP
  409 / "already completed" as success.
- **`cancelPayment($transaction_uuid): bool`** — `DELETE
  {api_base_url}/payments/{uuid}/cancel` with a `Merchant-Id` header.
- **`formatEnzonaAmount($amount): string`** — `number_format($amount, 2, '.', '')`.

EnZona status vocabulary used by the code: `1116`/`Confirmada`,
`1111`/`Aceptada`, `2222`/`Completada`|`Completado`, `1113`/`Pendiente`.

## `onReturn(OrderInterface $order, Request $request)`

Called from the return controller (not directly by Commerce, since the return
route is custom). Steps:

1. Read the transaction id from the query string: `transaction_uuid`, else `uuid`,
   else `payment_id`. If none, add an error message and return.
2. `getPaymentDetails($transaction_uuid)` — re-fetch the transaction from EnZona
   server-side. If it fails, error out.
3. If status is `Confirmada` (1116), call `completePayment()` then re-fetch details.
4. If status is `Aceptada`/`Completada` (1111/2222): resolve the gateway id, create
   a `commerce_payment` (`type => payment_default`, `remote_id => transaction_uuid`,
   `remote_state => status_denom`, `amount => $order->getTotalPrice()`,
   `state => completed`) and, if the order is not already completed, apply the
   `place` transition and save.
5. If `Pendiente` (1113): warning message, no state change. Otherwise: unknown-status
   error message.

The recorded payment `amount` is the order's own total (`$order->getTotalPrice()`),
not the amount read back from the EnZona transaction.

## Offsite redirect form (`PluginForm/EnzonaRedirectCheckoutForm`)

`buildConfigurationForm()` builds the return URL (`commerce_enzona.return`) and
cancel URL (`commerce_enzona.cancel`) as absolute URLs, calls
`$gateway->createPayment($order, $return_url)`, and on success saves
`transaction_uuid` onto the payment as its `remote_id`. It then calls
`buildRedirectForm(..., $checkout_url, ['transaction_uuid' => …, 'order_id' => …],
'Redirecting to Enzona…')` to POST-redirect the browser to EnZona, attaching the
`commerce_enzona/payment_form` library. On failure it renders an inline error and
does not redirect.
