<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nexi gateway — configure

Add at *Commerce → Configuration → Payment gateways* → plugin **Nexi**. Provide the Nexi
merchant **alias** and **MAC secret** and select test vs live mode (see the gateway plugin's
configuration form).

Round-trip:
- Checkout builds a signed hosted-page request (`QueryHelper` + `CryptographicService` MAC) and
  redirects to Nexi.
- Nexi returns the browser to `/nexi-checkout/{commerce_order}/return` (or `/cancel`). These
  routes are `_access: 'TRUE'` (session may be absent); `NexiCheckoutController` only forwards
  to the Commerce return/cancel step.
- `NexiGateway::onReturn()` re-fetches the payment from Nexi's API (`getRemotePayment`) and
  validates it server-side before creating/updating the `commerce_payment`. A `NexiValidNotify`
  event is dispatched for verified notifications.

Back office: `RemotePaymentStatusUpdateForm` refreshes a payment's remote status. The
`CheckoutFormEventSubscriber` adjusts the checkout pane; `PaymentMethodAddForm` (inline widget)
collects card details.
