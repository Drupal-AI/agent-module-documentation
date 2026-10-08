<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Revolut provides Commerce integration for Revolut.

---

Commerce Revolut **provides Revolut payment gateways** for Drupal Commerce. It
ships **three** gateway plugins: `revolut_checkout` (onsite credit-card fields
rendered by the Revolut Checkout widget), `revolut_pay` (an onsite Revolut Pay
button), and `revolut_payment_link` (an offsite redirect to a hosted Revolut
checkout URL). The onsite gateways support authorize/capture, void, refund and
reusable stored payment methods; the offsite one redirects the shopper to pay and
records the result on return. It depends on Commerce Payment and Commerce Order,
and card data is entered in Revolut's hosted widget rather than posted to Drupal.

All gateways use Revolut's Merchant Orders REST API, authenticated server-side with
the secret key. The Revolut order id is stored against the local order (in
key-value storage keyed by the order id), and every state decision comes from a
server-side API fetch of **that** order — for the offsite gateway, `onReturn()`
re-fetches the Revolut order and sets the payment state from the **API's** `state`
(`completed` → completed, otherwise pending; `pending`/`processing` raise a payment
failure), rather than from anything in the browser redirect. The webhook
`onNotify()` is currently a no-op, so fulfilment relies on the verified `onReturn`
fetch. Capture, void and refund are driven from the order management interface for
the onsite gateways. A `revolut_order_payload` event lets other modules alter the
order payload before it is sent. Security essentials: store the Revolut public/secret
keys as secrets (env var / Key entity), serve checkout over HTTPS, and select Test
mode while integrating (Live only after a confirmed test payment). It defines no
permissions of its own. Configure the Revolut API credentials on the gateway.

---

- Provide three Revolut payment gateways (onsite checkout, onsite Revolut Pay, offsite payment link).
- Render onsite card fields / Revolut Pay button with Revolut's hosted widget (card data never posted to Drupal).
- Redirect the customer to a hosted Revolut checkout URL (payment link gateway).
- Support authorize/capture, void and refund from the order management interface.
- Support reusable (stored) payment methods.
- Depend on Commerce Payment + Commerce Order.
- Call Revolut's Merchant Orders REST API authenticated with the secret key.
- Store the Revolut order id against the local order (key-value keyed by order id).
- Re-fetch the Revolut order from the API on return and set state from the API's state (not request params).
- Raise a failure for pending/processing states on return.
- Treat onNotify() as a no-op (fulfilment via verified onReturn).
- Fire a revolut_order_payload event to alter the outbound order payload.
- Switch between production and sandbox hosts based on the gateway mode.
- Store the Revolut public/secret keys as secrets (env/Key), HTTPS.
- Configure the Revolut API credentials.
- Handle Revolut payments.
- Accept payments.
- Configure the gateway.
- Record payments.
- Secure the credentials.
