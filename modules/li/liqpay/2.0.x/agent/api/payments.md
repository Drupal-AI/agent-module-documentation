<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LiqPay service, payments table & callback flow

## Services

- `LiqPay` (service id **`LiqPay`**, class `Drupal\liqpay\LiqPay`) — payment records + config helper.
- `Drupal\liqpay\API\LiqPayApi` — thin LiqPay HTTP client (constructed with public+private key).
- `Drupal\liqpay\Hook\LiqpayHooks` — hook implementations (theme, basket alters).

## `payments_liqpay` table (`liqpay.install`)

Columns: `id` (serial PK), `nid`, `sid`, `uid`, `created`, `paytime`, `amount` (varchar),
`currency`, `status` (varchar), `data` (big text — PHP-`serialize`d payment metadata).

## `LiqPay` service methods

- `load(array $params)` — SELECT from `payments_liqpay` by `id`/`nid`/`sid`; if none found and
  `amount` given, INSERTs a new row with status `liqpay_new` (`LIQPAY_INSERT_STATUS`) and returns it.
  `create_new` forces a new row.
- `update(object $payment)` — UPDATE the row by `id`.
- `getConfig()` — returns `liqpay.settings` `config`; substitutes sandbox keys when `sandbox` set.
- `getStatus(int $orderId)` — calls LiqPay `request`/`status` API for that order.
- `getPayIdByData(array $data)` — resolves the internal payment id from LiqPay's `order_id`
  (`"{$id}-{$rand}"`), overridable via `hook_liqpay_get_order_id_by_data_alter()`.
- Constants: `LIQPAY_SUCCESS_STATUS = 'success|sandbox|subscribed|unsubscribed|hold_wait'`,
  `LIQPAY_ACTION = 'pay'`, `LIQPAY_VERSION = '3'`.

## Checkout (outgoing) — `PaymentForm` + `LiqPayApi::cnbForm()/formAlter()`

`/liqpay/pay?pay_id=N` loads the payment (404 unless its status is not already a success) and renders
`PaymentForm`. `basketPaymentFormAlter()` builds `#params` (`action=pay`, `amount`, `currency`,
`description`, `order_id = "{$payment->id}-".time().rand(0,999)`, `version=3`, `server_url` =
`/liqpay/api`, `result_url` = `/liqpay/payment_result`, `language`) and, if Basket + `rro`, RRO goods.
`LiqPayApi::formAlter()` sets `#action` to `https://www.liqpay.ua/api/3/checkout` and adds hidden
`data` = `base64(json(params))` and `signature` = `base64(sha1(private_key + data + private_key,1))`.
The payment id is stashed in the session (`liqpay_last_pay`).

## Callback (incoming) — `LiqpayPages::pages('api')`

LiqPay POSTs `data` + `signature` to `/liqpay/api`. The controller:
1. Decodes `data` (`json_decode(base64_decode($data))`) and loads the payment by resolved order id.
2. Recomputes `signature = base64_encode(sha1($private_key . $rawData . $private_key, 1))` and
   proceeds **only if** `$signature == $requestData['signature']` (and a relevance/anti-replay
   check `$isCheck` that ignores a later `failure/error` whose `payment_id` differs from a prior
   successful one).
3. On match, sets `paytime`, stores `data`, sets `status` to LiqPay's `status`, and — for a success
   status — calls `basket->paymentFinish($nid)` and fires the `change_liqpay_status` Basket notify.

## Result page — `LiqpayPages::pages('payment_result')`

Reads `liqpay_last_pay` from the session. If the payment is already a success, renders the
`liqpay_success_page` theme with the configured `success` text; otherwise calls `LiqPay::getStatus()`
to poll LiqPay, and on failure maps `err_code` through `errors.yml` to a message plus a "Repeat" link.

## `LiqPayApi`

`api($path, $params)` POSTs `data`+`signature` to `https://www.liqpay.ua/api/{path}` via cURL and
`json_decode`s the reply. `cnbForm()/formAlter()/cnbSignature()` build the checkout form/signature;
`cnbParams()` validates required `version`/`amount`/`currency`(supported)/`description`.
