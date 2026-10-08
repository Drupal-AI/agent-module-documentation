<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Arch Payment Saferpay integrates the Saferpay (Worldline/SIX) hosted Payment Page into the Arch suite, letting customers pay by card: the shopper is redirected to Saferpay, and on return the module asserts and captures the transaction against the Saferpay JSON API.

---

`arch_payment_saferpay` is a configurable gateway submodule of `arch_payment`. It registers a
`saferpay` `PaymentMethod` plugin (`Plugin\PaymentMethod\Saferpay`, label "Credit card") whose
`callback_route` is `arch_payment_saferpay.redirect`. The `SaferpayHandler` service
(`arch_payment_saferpay_handler`) talks to the Saferpay JSON API over HTTPS with HTTP basic auth
(Guzzle `http_client`): `callInitialize()` (`/Payment/v1/PaymentPage/Initialize`) creates a payment
and stores the returned `Token` on the order, `callAssert()` (`/Payment/v1/PaymentPage/Assert`)
fetches the transaction after the shopper returns, and `callCapture()`
(`/Payment/v1/Transaction/Capture`) captures it. The controller
(`SaferpayPaymentController`) provides `redirectPage()` (initializes and redirects the shopper to
Saferpay's `RedirectUrl` via a `TrustedRedirectResponse`), `paymentSuccess()` (asserts, captures if
not already captured, then redirects to `arch_checkout.complete`), and `paymentError()` /
`paymentCancel()` (message + back to checkout). Amounts are derived from the order's
`grandtotal_gross` and the currency's rounding step. Configuration
(`arch_payment_saferpay.settings`, schema `arch_payment_saferpay.config`) holds `customer_id`,
`terminal_id`, `username`, `password`, `spec_version` and `force_sca`, edited on the payment
method's configure form, which also exposes a **Test mode** toggle (stored in state
`arch_payment_saferpay_test`) selecting the `test.saferpay.com` vs `www.saferpay.com` endpoint.
Depends on `arch` and `arch_payment`.

---

- Accept credit/debit card payments through Saferpay's hosted Payment Page.
- Redirect the shopper to Saferpay to enter card details off-site.
- Initialize a Saferpay payment for the order's grand total and currency.
- Assert and capture the transaction when the shopper returns.
- Store the Saferpay token, transaction and capture data on the order.
- Toggle between Saferpay test and live environments.
- Force PSD2 Strong Customer Authentication (3-D Secure challenge) via `force_sca`.
- Configure Saferpay customer id, terminal id, API username and password.
- Set the Saferpay API `SpecVersion`.
- Enable or disable the card method from the payment-methods admin.
- Restrict card payment to certain orders via `hook_payment_method_access()`.
- Handle Saferpay cancel and error returns with a message back to checkout.
- Provide an off-site card-payment option alongside COD and bank transfer.
- Round the charged amount to the currency's rounding step.
- Log Saferpay API errors to the Drupal log.
