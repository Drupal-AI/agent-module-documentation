<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayTR — gateway, callback & settings

## Payment gateway (where the secrets live)
Add a Commerce payment gateway of type **PayTR** (`RedirectCheckout`, off-site redirect). Merchant **id / key / salt** are entered on the gateway plugin config (admin-gated via Commerce). `PluginForm/RedirectCheckoutForm` + `PaytrRequestHelper` build the PayTR iFrame token and redirect the shopper.

## Callback — `/paytr-payment/callback`
Route `paytr_payment.callback`, `_method: POST`, access check `_paytr_payment_callback_access_check` (the order resolved from `merchant_oid` must exist). `CallbackController::callback`:
1. `json_decode` the POST body; load `commerce_payment` by remote id.
2. `state = (status === 'success' && makeHash(request,payment) === request.hash) ? 'completed' : 'canceled'`.
3. `makeHash = base64_encode(hash_hmac('sha256', merchant_oid . merchantSalt . status . total_amount, merchantKey, true))`.
4. On `canceled`, set order state and return; otherwise set payment+order `completed`.

`merchant_oid` is decoded to an order id by stripping `SP` and splitting on `DR`. Authenticity and amount are both in the HMAC → forged callbacks cannot complete an order.

## Settings form — `/admin/commerce/config/paytr-settings`
`PaytrPaymentSettingsForm` (`ConfigFormBase`, config `paytr_payment.settings`) sets an installment option (0 = all, 1 = single, 2–12 = up to N) per `product_collections` taxonomy term.

**Hardening note:** this route is declared `_permission: 'access content'` — anonymous-effective. It writes config, so re-gate it to an administrative permission (e.g. `administer commerce_payment_gateway`). It does **not** expose the merchant key/salt (those are on the gateway plugin).
