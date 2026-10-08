<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CM.com Payment (cm_commerce) — agent index

A **Drupal Commerce off-site payment gateway** for the **CM.com** payment provider
(the CM Payments platform, whose API is served from `docdatapayments.com`). At
checkout the shopper is redirected to CM.com's hosted "menu", picks a payment method
(credit card, iDEAL, PayPal, …) and pays; on return the module reconciles the order
by querying CM's API server-side. Package `Commerce`. Core `^10.3 || ^11`. License
GPL-2.0-or-later. Installed as **2.0.0-beta1** (version dir `2.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (`.info.yml`) — pulls in Drupal
  Commerce.
- Composer: **`drupal/commerce` `^3`** (`composer.json`). No third-party PHP
  libraries; uses core's `http_client` (Guzzle).

## What it provides (from source)

Two PHP classes only — no routing.yml, no permissions.yml, no `.module` hooks, no
install/update hooks. Everything hangs off Commerce's payment-gateway plugin system.

- **Payment gateway plugin** `cm` — `Plugin/Commerce/PaymentGateway/Cm.php`, extends
  `OffsitePaymentGatewayBase`. Annotation: label "CM (Redirect to CM)",
  `payment_method_types = {"credit_card"}`, `credit_card_types = {mastercard, visa}`,
  offsite form = `RedirectCheckoutForm`.
  - `buildConfigurationForm()` — admin settings: **merchant_name**, **password**,
    **merchant_key** (all required) and a **debug** checkbox. (The config schema also
    declares `payment_method` / `accepted_cards`, but the form does not expose them.)
  - `onReturn()` / `onNotify()` — call `updatePaymentInfo()` to reconcile; `onCancel()`
    shows a resume-checkout message.
  - `updatePaymentInfo()` — decodes the `order_reference`/`order_ref` request value to a
    **local `commerce_payment` entity id**, then calls `processFeedback()` using the
    payment's own stored `remote_id`.
  - `processFeedback()` — server-to-server **`GET merchants/{merchant_key}/orders/{order_key}`**
    (HTTP Basic auth = merchant_name/password) and only sets the payment `completed`
    when CM's response reports `considered_safe.level == 'SAFE'`; otherwise leaves it
    `new`. Optionally writes `field_cm_order_id` / `field_cm_payment_id` on the order
    if those fields exist.
  - `getApiUrl()` — hardcoded HTTPS base: `secure.docdatapayments.com` (live) /
    `testsecure.docdatapayments.com` (test), chosen by the gateway `mode`.
- **Offsite checkout form** `RedirectCheckoutForm` — `PluginForm/RedirectCheckoutForm.php`,
  extends `PaymentOffsiteForm`. On build it saves the payment, **`pushShopper()`**
  (POST `…/shoppers` with billing name/address/email → gets an `address_key`), then
  **`pushOrder()`** (POST `…/orders` with amount, currency, description, return URLs,
  a base64 `order_reference` encoding `paymentId%orderId%merchantKey.mode`) → gets an
  order `url`, and redirects the browser there via `REDIRECT_GET`.
- **Service** `logger.channel.cm_commerce` (`.services.yml`).
- **Config schema** `commerce_payment.commerce_payment_gateway.plugin.cm`
  (`config/schema/cm_commerce.schema.yml`): merchant_name, password, merchant_key,
  payment_method, accepted_cards, debug_info.

## Notes for integrators

- No standalone config page: configure it at **Commerce → Configuration → Payment
  gateways** by adding a gateway of type **CM.com**. There are **no module-defined
  permissions** — access is governed by Commerce's own gateway-admin permissions.
- Return/cancel/notify use core Commerce off-site routes
  (`commerce_payment.checkout.return|cancel`, `commerce_payment.notify.cm`); the
  notify route is public by design (PSP callback) and the module reconciles by
  re-querying CM's authoritative API rather than trusting request status.
- `debug_info` (off by default) logs CM request/response bodies and the shopper
  billing address to the Drupal log; leave it off in production.

## Solution docs

Small surface — this index is the whole agent reference; no further subdocs.
For human click-through setup see the sibling [`human-docs/`](../human-docs/index.md).
