<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PayTR Virtual Pos iFrame API is a Drupal Commerce off-site payment gateway that takes card payments through PayTR's iFrame and confirms orders via an HMAC-verified callback.
---
The module provides a Commerce `RedirectCheckout` off-site payment gateway plugin: at checkout it builds a PayTR iFrame token (via `PaytrRequestHelper`/`PaytrHelper`, using the merchant id/key/salt) and redirects the shopper into PayTR's hosted iFrame. PayTR then POSTs a payment result to `/paytr-payment/callback`, handled by `CallbackController::callback`. Order completion is authenticated: the controller recomputes `base64_encode(hash_hmac('sha256', merchant_oid . merchant_salt . status . total_amount, merchant_key, true))` and only marks the Commerce payment and order `completed` when that hash equals the callback's `hash` **and** `status === 'success'`; otherwise the order is set `canceled`. A custom access check (`_paytr_payment_callback_access_check`) additionally requires that the order referenced by `merchant_oid` exists before the route runs. A settings form lets a store configure per-taxonomy-term (product collection) installment options.

Setup: enable the module with `commerce_payment` and `telephone`, add a **PayTR** payment gateway under Commerce (entering merchant id, key and salt on the gateway plugin), and configure installment display at the settings form. Security review: the callback is **sound** — authenticity (HMAC-SHA256 over merchant_oid+salt+status+total_amount, keyed with the merchant key) and the paid amount are both covered before fulfilment, so an unsigned/forged callback cannot complete an order. One access-control caveat to note: the **settings route `/admin/commerce/config/paytr-settings` is gated only by `_permission: 'access content'`** (a permission granted to anonymous users by default), and it is a `ConfigFormBase` that writes `paytr_payment.settings` — so an unauthenticated visitor can view and change the installment configuration. That form exposes only installment options (not the merchant key/salt, which live on the admin-gated Commerce gateway plugin), so impact is limited to tampering with installment display, but the route should be gated by an administrative permission.
---
- Enable the module with `commerce_payment` and `telephone`.
- Add a PayTR payment gateway in Commerce (Off-site redirect).
- Enter the PayTR merchant id, merchant key and merchant salt on the gateway.
- Offer PayTR card payment inside a hosted iFrame at checkout.
- Redirect shoppers into PayTR and back via the `RedirectCheckout` plugin.
- Receive asynchronous results at `/paytr-payment/callback` (POST only).
- Auto-complete the Commerce order/payment on an HMAC-verified `success` callback.
- Cancel the order automatically when the callback status is not success.
- Rely on the access check that the order for `merchant_oid` must exist.
- Configure per-product-collection installment options at the settings form.
- Restrict installment counts (single payment up to 12 installments) per taxonomy term.
- Localise the UI via the module's interface-translation server pattern.
- Log payment transactions by PayTR `merchant_oid` reference.
- Harden the deployment by re-gating the settings route to an admin permission.
- Present installment choices to shoppers based on product collection.
- Verify callback authenticity and amount via HMAC before fulfilment.
- Store the PayTR transaction reference on the Commerce payment.
