<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates the LiqPay (liqpay.ua) payment gateway: renders a LiqPay checkout form, receives LiqPay's server-to-server payment callback (with signature verification), and tracks payments in a `payments_liqpay` table. Designed to plug into the `basket` commerce module but also usable standalone.

---

LiqPay API 3.0 (v2) wires a Drupal site to LiqPay. Admins enter public/private keys (separate sandbox and live pairs), currency, order description, and success text at `/admin/config/development/liqpay` (`liqpay.settings`, permission `access liqpay settings`, which is `restrict access: true`). A payment row is created in the custom `payments_liqpay` table (`LiqPay::load()`); `/liqpay/pay?pay_id=N` renders `PaymentForm`, which builds LiqPay's `data`+`signature` fields via `LiqPayApi::cnbForm()`/`formAlter()` and auto-posts the buyer to `https://www.liqpay.ua/api/3/checkout`. LiqPay then POSTs its result to the `server_url` callback `/liqpay/api`; the controller (`LiqpayPages::pages('api')`) decodes the base64 `data`, recomputes `base64(sha1(private_key + data + private_key))` and only updates the order status when the computed signature equals the posted `signature`, marking success for statuses `success|sandbox|subscribed|unsubscribed|hold_wait` and calling `basket->paymentFinish()`. `/liqpay/payment_result` shows the outcome, polling `LiqPayApi::api('request', {action:status})` if the callback has not yet landed. Four `hook_*_alter`/invoke hooks (`liqpay.api.php`) let other modules change payment params, resolve the order id, and react pre/post callback. The `basket` payment plugin `BasketLiqpay` exposes it inside Basket's checkout. Interface translations (uk/ru) and an `errors.yml` map LiqPay error codes to messages.

---

- Accept online card payments through LiqPay on a Ukrainian/UAH storefront.
- Add LiqPay as a payment method inside the `basket` commerce module's checkout.
- Take one-off payments via a standalone `/liqpay/pay?pay_id=N` payment form.
- Run in sandbox mode with separate sandbox keys before going live.
- Receive LiqPay's server-to-server callback and update order status automatically.
- Verify the LiqPay signature on the callback so only genuine LiqPay results mark an order paid.
- Support LiqPay subscription statuses (`subscribed` / `unsubscribed`).
- Support hold/authorise flow (`hold_wait` treated as success).
- Configure the payment currency (UAH/USD/EUR) globally or per payment.
- Set a localized order description and success message (per language: en/uk/ru).
- Show a branded success or error result page after payment.
- Map LiqPay error codes to human-readable messages via `errors.yml`.
- Poll LiqPay for payment status on the result page when the callback is delayed.
- List and inspect recorded payments at `/admin/config/development/liqpay/payments`.
- Send RRO (fiscalization) goods data to LiqPay when the Basket order has line items.
- Alter the outgoing LiqPay payment params with `hook_liqpay_payment_params_alter()`.
- Resolve your own order id scheme with `hook_liqpay_get_order_id_by_data_alter()`.
- React to the incoming callback with `hook_liqpay_payment_api_pre_run()` / `hook_liqpay_api_alter()`.
- Store per-payment metadata in the serialized `data` column of `payments_liqpay`.
- Localize the checkout UI language (en/uk/ru) to match the current interface language.
- Restrict who can configure keys via the `access liqpay settings` permission.
- Query recorded payments by node id, session id, user id, or status.
- Integrate LiqPay into a custom checkout by calling the `LiqPay` service directly.
