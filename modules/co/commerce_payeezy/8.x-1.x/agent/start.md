<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Payeezy — agent index

Drupal Commerce payment gateway plugins for **Payeezy (First Data / Global Gateway e4)**. Ships two
`commerce_payment_gateway` plugins — a **hosted/off-site** gateway and an **on-site** gateway — each a
config entity holding credentials + Commerce `mode`. No custom routes, no permissions, no Drush, no
services. Depends on `commerce`, `commerce_payment`, `commerce_order`. Version **8.x-1.2**, core
`^8||^9||^10||^11`. Live charges need a real Payeezy account, so ground work in the **gateway config
entity**, not live transactions.

## The two gateways

- **`commerce_payeezy_hosted_gateway`** — `src/Plugin/Commerce/PaymentGateway/HostedGateway.php`,
  extends `OffsitePaymentGatewayBase`. Redirects the shopper to Payeezy's hosted pay page and handles
  the POST return. Config keys: `x_login`, `transaction_key`, `x_response_key`, `transaction_url`,
  `hmac_calculation` (`md5`|`sha1`). Its off-site form
  (`src/PluginForm/HostedGateway/PaymentMethodAddForm.php`) builds a signed POST redirect: it computes
  `x_fp_hash = hash_hmac(algo, x_login^x_fp_sequence^x_fp_timestamp^x_amount^x_currency_code, transaction_key)`
  where `x_amount` is the server-side `payment->getAmount()`, and posts to `transaction_url`.
- **`commerce_payeezy_onsite_gateway`** — `src/Plugin/Commerce/PaymentGateway/PayeezyOnsiteGateway.php`,
  extends `OnsitePaymentGatewayBase`, implements `PayeezyGatewayInterface`
  (`OnsitePaymentGatewayInterface` + `SupportsAuthorizationsInterface` + `SupportsRefundsInterface`).
  Card data is tokenized against Payeezy (TransArmor) — only a token + `last4`/type/expiry are stored.
  Config keys: `api_key`, `api_secret_key`, `merchant_token`, `transaction_url`, `ta_token`
  (`NOIW` for sandbox), `token_type` (`FDtoken`), `security_token_url`.

## Key facts

- Both plugins declare `payment_method_types = {"credit_card"}` and the full `credit_card_types` set
  (amex, dinersclub, discover, jcb, maestro, mastercard, visa).
- **Amounts are always server-side.** On-site sends `payment->getAmount()->multiply(100)` (cents) to
  Payeezy; hosted records `$order->getTotalPrice()` and signs `x_amount` from `payment->getAmount()`.
- **On-site payment lifecycle** (`PayeezyOnsiteGateway`): `createPaymentMethod()` →
  `doCreatePaymentMethod()` POSTs card + `apikey`/`ta_token` to `security_token_url`, stores the returned
  token as the payment method `remote_id` (only `last4`/type/exp kept locally); `createPayment()` posts a
  `purchase` transaction (`method: token`); `capturePayment()`/`voidPayment()`/`refundPayment()` reuse the
  stored `remote_id` (`ID: <transaction_id>, Tag:<transaction_tag>`). All go through `payeezyPost()`.
- **Payeezy API auth** (`getHmacAuthorizationToken()`): builds `hash_hmac('sha256', apikey.nonce.timestamp.merchant_token.payload, api_secret_key)`, base64-encoded, sent as the `Authorization` header with `nonce`/`timestamp`. Requests go over `\Drupal::httpClient()` (default TLS verification).
- **Hosted return** (`HostedGateway::onReturn()`): checks `x_response_code == 1`, recomputes
  `hash(md5|sha1, x_response_key . x_login . x_trans_id . x_amount)`, compares it to the posted
  `x_MD5_Hash`/`x_SHA1_Hash`, and on a match records an `authorization`-state payment for the
  server-side `$order->getTotalPrice()` with `remote_id = x_trans_id`.
- Config schema: `config/schema/commerce_payeezy.schema.yml`. No `*.routing.yml`, `*.services.yml`,
  `*.permissions.yml`, `.install`, `.module`, templates, JS, or `.api.php`.

## Setup

Add a gateway at `/admin/commerce/config/payment-gateways`, pick a Payeezy plugin, enter the
credentials + `transaction_url` (sandbox e.g. `https://api-cert.payeezy.com/v1/transactions`, hosted
`https://demo.globalgatewaye4.firstdata.com/pay`), set Commerce **mode** to `test` or `live`, then
attach it to the checkout flow. Credentials come from a Payeezy developer account
(https://developer.payeezy.com/). All configuration/state lives in the `commerce_payment_gateway`
config entity — treat the credentials (`transaction_key`, `x_response_key`, `api_secret_key`,
`merchant_token`) as secrets and keep them out of committed config exports.
