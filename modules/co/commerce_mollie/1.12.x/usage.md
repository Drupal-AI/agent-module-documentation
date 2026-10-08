Commerce Mollie integrates the Mollie payment provider with Drupal Commerce as an off-site redirect payment gateway, using the official `mollie/mollie-api-php` SDK. Customers are redirected to Mollie to pay; Mollie then calls back a webhook that re-fetches the authoritative payment status and transitions the Commerce payment/order.

---

The module provides a single Commerce payment gateway plugin, `mollie` (`OffsitePaymentGatewayBase`), with an off-site redirect flow. On the payment step, `MolliePaymentOffsiteForm` calls `createRemotePayment()` which builds a Mollie payment (amount, description, `redirectUrl`, `webhookUrl`, `metadata.order_id`) via the SDK and redirects the browser to Mollie's `checkoutUrl`. When the shopper returns, the `commerce_mollie.checkout.mollie_return` route (`MollieReturnController`, guarded by `CheckoutController::checkAccess`) inspects the last Mollie payment's remote state and forwards to the Commerce checkout cancel or return step, showing a reload message while the payment is still open. The authoritative status update happens in `Mollie::onNotify()` (bound to the standard `commerce_payment.notify` webhook route): it reads the Mollie payment `id` from the request, loads the local payment by remote id, then **re-fetches the payment from Mollie's API (`payments->get($id)`)** and applies the matching Commerce workflow transition (paid→authorize_capture, canceled→void, open→authorize, failed→void, expired→expire) — the request body's claimed status is never trusted, so a forged webhook cannot mark an order paid. Gateway config is `api_key_test`, `api_key_live`, `mode` (test/live) and an optional `callback_domain` used to build the webhook URL (useful behind tunnels/local dev). The gateway warns admins if the order-type workflow lacks a validation step. `ErrorHelper` maps Mollie SDK exceptions to Commerce payment exceptions. Locale is mapped from the site's current language to Mollie's supported locales.

---

- Accept Mollie-hosted payments (iDEAL, cards, etc.) in a Drupal Commerce store.
- Add Mollie as an off-site redirect payment gateway on a store.
- Run in test mode with a `test_` API key before going live.
- Switch to live mode with a `live_` API key.
- Automatically capture payment when Mollie reports the payment as paid (via webhook).
- Void a Commerce payment when the shopper cancels at Mollie.
- Mark a payment expired when the Mollie payment expires.
- Void/fail a Commerce payment when Mollie reports failure.
- Return shoppers to the correct checkout step (complete vs cancel) after paying.
- Show a "please reload" holding page while a payment is still being processed at Mollie.
- Configure a fixed callback domain so Mollie can reach the webhook (e.g. behind a tunnel in dev).
- Use a localtunnel domain during local development so webhooks hit your machine.
- Localize the Mollie checkout to the customer's interface language.
- Attach the Commerce order id to the Mollie payment metadata for reconciliation.
- Rely on server-to-server webhook status re-fetch rather than trusting the browser return.
- Surface a recommendation to add a Validation step to the order-type workflow.
- Translate Mollie API/authentication errors into Commerce payment exceptions.
- Support both Commerce 2.x and 3.x via `drupal/commerce ^2.40 || ^3.0`.
- Build payment instructions text shown to the customer after redirect.
- Handle multiple Mollie payments per order and act on the latest one on return.
