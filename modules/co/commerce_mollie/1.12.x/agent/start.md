# Commerce Mollie — agent index

A Drupal Commerce off-site redirect payment gateway for Mollie, using the `mollie/mollie-api-php`
SDK. Depends on `commerce` + `commerce_payment`. One payment gateway plugin (`mollie`); config lives
on the payment-gateway entity (no module `configure` route). No permissions, no Drush.

- **The `mollie` gateway plugin: config keys, offsite flow, return controller, and the `onNotify` webhook (status re-fetch)** → [configure/gateway.md](configure/gateway.md)

Key facts:
- Gateway config: `api_key_test`, `api_key_live`, `mode` (test|live), `callback_domain` (optional; used to build the webhook URL). Schema `commerce_payment.commerce_payment_gateway.plugin.mollie`.
- Webhook `Mollie::onNotify()` (route `commerce_payment.notify`) re-fetches status from Mollie's API (`payments->get($id)`) — it does NOT trust the request body status; forged "paid" webhooks cannot capture an order.
- Return route `commerce_mollie.checkout.mollie_return/{commerce_order}` is access-guarded by `commerce_checkout` `CheckoutController::checkAccess`; it only redirects to cancel/return steps.
- Service `commerce_mollie.mollie.api` = `\Mollie\Api\MollieApiClient`.
