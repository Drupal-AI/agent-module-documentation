<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayTR Virtual Pos iFrame API (paytr_payment) — agent index

**A Drupal Commerce off-site (iFrame) payment gateway for PayTR, with an HMAC-SHA256-verified callback.**

- **Version:** 11.0.x  •  core: `^8.9 || ^9 || ^10 || ^11`  •  depends on `commerce:commerce_payment`, `telephone`  •  package: Commerce (contrib)
- **Gateway plugin:** `RedirectCheckout` (off-site redirect; `PluginForm/RedirectCheckoutForm`) using `PaytrHelper`/`PaytrRequestHelper` (merchant id/key/salt).
- **Callback route:** `paytr_payment.callback` `/paytr-payment/callback` (`_method: POST`, custom access check `_paytr_payment_callback_access_check` → order for `merchant_oid` must exist).
- **Settings route:** `paytr_payment.settings` `/admin/commerce/config/paytr-settings` (`_permission: access content`) → `PaytrPaymentSettingsForm` (installment options per product-collection term).

**Security:** callback is **sound** — `CallbackController::callback` marks the order/payment `completed` only when `status==='success'` AND `makeHash()===request.hash`, where `makeHash = base64(hash_hmac('sha256', merchant_oid.salt.status.total_amount, merchant_key))` (`src/Controller/CallbackController.php:38,66`) — authenticity + amount both verified; otherwise `canceled`. **Finding:** the settings route uses `_permission: 'access content'` (effectively anonymous) on a `ConfigFormBase` that writes `paytr_payment.settings` (`paytr_payment.routing.yml`) → an unauthenticated user can view/modify installment config. Impact limited (no merchant key/salt exposed there — those live on the admin-gated gateway plugin), but it should require an admin permission.

See [configure/gateway.md](configure/gateway.md)
