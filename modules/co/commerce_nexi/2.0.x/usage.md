<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Nexi integrates the Nexi (XPay) hosted payment page with Drupal Commerce.

---

The module provides a Nexi off-site payment gateway plus a Nexi credit-card payment-method
type. It builds a signed request to the Nexi hosted checkout (MAC computed by
`CryptographicService`, request assembled by `QueryHelper`) and redirects the shopper. Two
local routes handle the browser round-trip: `/nexi-checkout/{commerce_order}/return` and
`/nexi-checkout/{commerce_order}/cancel`. These routes are `_access: 'TRUE'` because the
shopper arrives without a session, but the controller is only a thin redirect layer — the
actual payment confirmation is performed by the gateway's `onReturn()`, which re-fetches the
payment from Nexi's API (`getRemotePayment`) and validates it server-side rather than trusting
the returned query string. A dispatched `NexiValidNotify` event lets other code react to a
verified notification.

Set up the gateway under *Commerce → Configuration → Payment gateways*: enter the Nexi
merchant alias and MAC secret and choose test/live. A checkout-form event subscriber and an
inline payment-method-add form wire it into the Commerce checkout flow; a remote
payment-status update form supports back-office status refreshes.

---

- Accept Nexi (XPay) card payments in Drupal Commerce.
- Add a `commerce_nexi` off-site payment gateway.
- Store the Nexi merchant alias and MAC secret in gateway config.
- Switch between Nexi test and live endpoints.
- Redirect shoppers to the Nexi hosted payment page.
- Sign outbound requests with a computed MAC.
- Return shoppers via `/nexi-checkout/{order}/return`.
- Handle cancellations via `/nexi-checkout/{order}/cancel`.
- Confirm payments by re-fetching them from Nexi's API on return.
- React to verified Nexi notifications via the `NexiValidNotify` event.
- Offer a Nexi credit-card payment method type at checkout.
- Refresh remote payment status from the back office.
- Combine Nexi with other Commerce payment gateways.
- Use the checkout-form event subscriber to adjust the pane.
- Test the MAC signing with the cryptographic service.
