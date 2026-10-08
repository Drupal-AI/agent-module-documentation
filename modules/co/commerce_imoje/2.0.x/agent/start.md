<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Imoje (commerce_imoje) — agent index

A **Drupal Commerce payment gateway for imoje** — the Polish payment service from ING
(`imoje.ing.pl`). It adds two Commerce payment gateway plugins: **`imoje_redirect`**
(off-site paywall redirect) and **`imoje_blik`** (on-site BLIK code entry, driven by AJAX).
Both share one payment type/workflow and support refunds issued from the Drupal admin.
Package `Commerce (contrib)`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Installed as
**2.0.2** (version dir `2.0.x`).

## Dependencies

- Drupal module: **`commerce:commerce_payment`** (required, from `.info.yml`).
- Composer: **`drupal/commerce` `^3`** (`composer.json`). No third-party PHP libraries; the
  imoje REST API is called directly with the core `http_client` (Guzzle).

## What it provides (from source)

- **Two payment gateway plugins** (both extend `ImojeOffsitePaymentGatewayBase`, which
  extends Commerce `OffsitePaymentGatewayBase` and implements `SupportsRefundsInterface`):
  - `imoje_redirect` — `Plugin/Commerce/PaymentGateway/ImojeRedirect`. Offsite form
    `PluginForm/ImojeRedirect/ImojePaymentForm` POSTs the shopper to imoje's paywall
    (`paywall.imoje.pl` / `sandbox.paywall.imoje.pl`). Adds a `payment_methods` multiselect
    (card, pbl, blik, imoje_paylater, lease, wt) that maps to imoje's `visibleMethod`.
  - `imoje_blik` — `Plugin/Commerce/PaymentGateway/ImojeBlik`. On-site: the shopper types a
    6-digit BLIK code; JS calls back to the site to create the transaction and polls for the
    result. Offsite form `PluginForm/ImojeBlik/ImojeBlikForm` is a fallback when checkout has
    no `review` step.
- **One payment type** `imoje_checkout` (`Plugin/Commerce/PaymentType/ImojeCheckout`, no
  fields) bound to workflow **`payment_imoje_checkout`** (`commerce_imoje.workflows.yml`):
  states new/pending/completed/partially_refunded/refunded/cancelled/rejected.
- **IPN handler** service `commerce_imoje.ipn_handler` (`IPNHandler`) — processes imoje's
  asynchronous payment notifications posted to Commerce's `commerce_payment.notify` route.
- **imoje API client** service `commerce_imoje.payment_gateway` (`ImojeGateway`) — wraps the
  imoje REST v1 API: create BLIK transaction, get transaction status, refund.
- **BLIK AJAX controller** `Controller/BlikController` + two routes
  (`commerce_imoje.routing.yml`), a form builder service
  (`commerce_imoje.blik_payment_form_builder` / `BlikPaymentFormBuilder`), and the
  `blik_payment_form` JS/CSS library (`commerce_imoje.libraries.yml`).
- **Event** `ImojePaymentEvent` (`Event/`) — dispatched on
  `commerce_imoje.imoje_payment.received` (new payment) and
  `.updated` (existing payment state change), carrying the payment + raw IPN data.
- A `hook_form_commerce_checkout_flow_alter` (`commerce_imoje.module`) that injects the BLIK
  input into the checkout **review** step for `imoje_blik` orders.
- No `.install`, no `.permissions.yml` of its own (uses Commerce's
  `administer commerce_payment_gateway` etc.), no templates. Config schema is provided by the
  Commerce payment-gateway base plus this module's plugin config keys.

## Payment confirmation posture

The order is confirmed by imoje's **asynchronous IPN**, not the browser return. When imoje
POSTs a notification to `/payment/notify/{payment_gateway_id}`, `IPNHandler::process()`
**first verifies imoje's `X-Imoje-Signature`** — a keyed hash of the raw request body with
the gateway's configured **service key** — and rejects the request (throws
`BadRequestHttpException`) if the signature is absent or does not match, before creating or
updating any `commerce_payment`. Outbound requests to imoje use the core Guzzle client
(certificate verification on) against fixed imoje API hosts selected by the gateway `mode`
(sandbox vs production); the amount sent to imoje is computed server-side from the
order/payment. The BLIK status endpoint only redirects the shopper onward once
`$order->isPaid()` is true. See [payment/flow.md](payment/flow.md).

## Solution docs

- **Gateway config form, credentials, modes, payment-method selection, workflow, refunds** →
  [config/gateway-settings.md](config/gateway-settings.md)
- **Offsite redirect flow, BLIK AJAX flow, IPN signature verification, events, API client** →
  [payment/flow.md](payment/flow.md)
