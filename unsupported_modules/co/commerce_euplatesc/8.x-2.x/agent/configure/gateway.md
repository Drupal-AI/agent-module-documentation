<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_euplatesc — gateway configuration

## Add the gateway
Plugin **euplatesc_checkout**. Config keys:
- `merchant_id` — EuPlatesc merchant id.
- `secret_key` — hex-encoded merchant secret (a `password` field; leaving it blank on edit keeps the stored value).
- `redirect_method` — `post` (default) or `get`.

## Outbound request (`setEuPlatescCheckoutData`)
Signed fields: `amount` (rounded order/payment amount), `curr`, `invoice_id` = order id, `order_desc`, `merch_id`, `timestamp` (`gmdate('YmdHis')`), `nonce` (`bin2hex(random_bytes(16))`). `fp_hash` = `strtoupper(hashData($signed, secret))`. Customer name/country/city/email are added unsigned.

## Signature verification
`hashData($data, $key)`: length-prefixes each value (empty→`-`), then `hash_hmac('md5', $str, pack('H*', $key))`. `verifySignature()` recomputes over the received fields and compares with `hash_equals()`.

## Order-context assertion (`assertOrderContext`)
Throws unless: signed `invoice_id` == order id; `order.payment_gateway` == this gateway; and signed `curr`/`amount` equal the order total (`Calculator::compare`). Applied on both `onReturn` and `onNotify`, blocking replay.

## Outcomes
Success (`action === '0'`): payment captured, draft order advanced to `place`. Failure: order unlocked, `authorization_voided` payment recorded. Events `EuPlatescEvents::PAYMENT_SUCCESS` / `PAYMENT_FAILURE` are dispatched.
