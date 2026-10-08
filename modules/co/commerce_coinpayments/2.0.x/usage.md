<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a redirect (off-site) Commerce payment gateway that takes customers to CoinPayments to pay in cryptocurrency and confirms payment through an IPN callback.

---

The gateway plugin `CoinPaymentsRedirect` builds a form that posts the order to CoinPayments' hosted checkout; the customer pays there and CoinPayments notifies the store asynchronously via an Instant Payment Notification (IPN) to `/commerce_coinpayments/ipn` (route `commerce_coinpayments.processipn`, `CoinPaymentsController::processIPN`). The IPN is processed by `IPNCPHandler`, which validates the notification before transitioning the payment/order.

Security-relevant: the IPN handler verifies the CoinPayments HMAC signature — it computes an HMAC-SHA512 of the raw POST body using the configured IPN secret and compares it to the `HMAC` request header before acting (IPNCPHandler.php:215-244), and checks the merchant id, currency and amount. This closes the common "forged IPN completes an order for free" hole. The IPN route is gated by the `access commerce coinpayments ipn` permission (grant it to anonymous so CoinPayments can reach it — the signature check, not the permission, is the security control). Configure the gateway with your CoinPayments merchant id, public/private keys and IPN secret in the payment-gateway config form.

---
- Accept cryptocurrency payments in a Commerce store
- Redirect customers to CoinPayments hosted checkout
- Confirm crypto payments asynchronously via signed IPN
- Verify the HMAC-SHA512 IPN signature before completing orders
- Configure merchant id and API public/private keys
- Set the IPN secret used to validate callbacks
- Add CoinPayments as a checkout payment method
- Handle multiple cryptocurrencies supported by CoinPayments
- Map IPN statuses to Commerce payment states
- Grant the IPN access permission so callbacks are received
- Reconcile pending vs completed crypto payments
- Test the gateway in sandbox before going live
- Log IPN notifications for auditing
- Support order fulfilment triggered by confirmed crypto payment
- Combine with Commerce order workflow transitions
- Refund/track crypto orders within Commerce
- Provide a redirect payment flow that keeps card data off-site
- Localize the payment label shown at checkout
