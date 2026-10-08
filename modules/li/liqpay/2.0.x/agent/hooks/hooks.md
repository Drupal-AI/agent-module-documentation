<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LiqPay hooks (`liqpay.api.php`)

Implement in `mymodule.module`. Two are `_alter` hooks, one is invoked (`invokeAll`), one resolves ids.

| Hook | Signature | Fired | Use |
|---|---|---|---|
| `hook_liqpay_payment_params_alter` | `(array &$params, object $payment, array &$config)` | building the checkout form params (`PaymentForm`) **and** in the callback before status handling | Add/override LiqPay checkout params (e.g. `result_url`, RRO data, custom fields) or tweak the effective config. |
| `hook_liqpay_get_order_id_by_data_alter` | `(?string &$orderId, array $data)` | `LiqPay::getPayIdByData()` | Map LiqPay's `order_id` back to your internal payment id when you don't use the default `"{id}-{rand}"` scheme. |
| `hook_liqpay_payment_api_pre_run` | `(string $order_id, array $data)` | start of the `/liqpay/api` callback (via `invokeAll`), **before** the signature is verified | Logging / early bookkeeping. Do **not** treat the payment as valid here — the signature check happens after. |
| `hook_liqpay_api_alter` | `(object $payment, array $data)` | inside the callback **after** a signature-verified successful update | React to a confirmed payment (fulfilment, custom order updates). |

Order of the callback (`LiqpayPages::pages('api')`): decode data → load payment →
`liqpay_payment_params_alter` → `liqpay_payment_api_pre_run` (invokeAll) → **signature check** →
on success update payment + `liqpay_api_alter` + Basket `paymentFinish`/notify.

`LiqpayHooks` also implements `hook_theme` (`liqpay_success_page`) and, when Basket is present,
`hook_basket_translate_context_alter`, `hook_basket_noty_actions_alter`,
`hook_basket_noty_twig_tokens_alter`.
