<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Saferpay integrates the Saferpay hosted payment page (Six Payment Services) as a Drupal Commerce payment gateway.

---

Commerce Saferpay provides a Drupal Commerce payment gateway plugin for Saferpay, the hosted
payment platform from Six Payment Services / Worldline. It uses Saferpay's API-based flow: the module
initialises a payment against Saferpay's API, redirects the customer to Saferpay's hosted payment
page, and on return (`onReturn`) and asynchronous notification (`onNotify`) it **asserts the
transaction by calling Saferpay's API** rather than trusting the redirect parameters. `onReturn`
throws a `PaymentGatewayException` on any processing error and redirects to the cancel URL when the
customer aborts.

This API-assertion model is the correct security shape for a redirect gateway: because the final
payment status is fetched server-to-server from Saferpay (not read from browser-supplied query
parameters), a customer cannot forge a "paid" result by tampering with the return URL. When adopting
it, configure the Saferpay API credentials (customer ID, terminal ID, API user/password) as secrets,
and confirm the gateway is set to the correct live/test mode. Standard Commerce concepts apply:
the gateway creates payments against orders, supports capture, and integrates with the Commerce
checkout flow.

---

- Accept payments via Saferpay in Drupal Commerce.
- Redirect customers to Saferpay's hosted payment page.
- Assert the transaction via Saferpay's API on return.
- Verify payment server-to-server, not from return params.
- Handle asynchronous Saferpay notifications (onNotify).
- Throw on processing errors during onReturn.
- Redirect to the cancel URL when the customer aborts.
- Configure Saferpay customer/terminal/API credentials.
- Store gateway API credentials as secrets, not in code.
- Switch between Saferpay test and live modes.
- Capture authorized Saferpay payments.
- Create Commerce payments against orders.
- Integrate Saferpay into the Commerce checkout flow.
- Rely on API assertion to reject forged 'paid' returns.
- Use with commerce_payment as the gateway plugin.
- Map Saferpay transaction status to Commerce payment state.
- Support Saferpay-hosted card entry (card data off-site).
- Confirm live/test mode before going to production.
- Reconcile Saferpay transactions with Commerce orders.
- Understand it depends on commerce_payment.
