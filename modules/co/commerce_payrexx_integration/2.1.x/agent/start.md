<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Payrexx integration (commerce_payrexx_integration) — agent index

Drupal Commerce **off-site (redirect) payment gateway** for **Payrexx** (a Swiss
payment service provider). The customer is redirected to a Payrexx-hosted payment
page; the result is confirmed both on the browser **return/cancel** and via an
asynchronous server-to-server **webhook**. In every case the module **re-fetches
the transaction from Payrexx's authenticated API** (keyed with the instance name +
secret) rather than trusting the request payload. Version **2.1.1**. Core
`^10 || ^11`. License GPL-2.0-or-later. Package `Commerce (contrib)`.

## Dependencies

- Drupal module: **`commerce:commerce_payment`** — the only dependency (`.info.yml`).
- Composer (`composer.json`): **`php ^8.1`**, **`payrexx/payrexx ^1.7`** (the
  official Payrexx PHP SDK — all remote calls go through it), **`drupal/commerce ^3.0`**.

## What it provides (from source)

- **Payment gateway plugin** `payrexx_redirect_checkout`
  (`src/Plugin/Commerce/PaymentGateway/PayrexxRedirectCheckout`, extends
  `OffsitePaymentGatewayBase`). Label "Payrexx (Redirect to Payrexx)", display label
  "Payrexx". Payment method type `credit_card`; declared card types `mastercard`,
  `visa`. Off-site form = `RedirectCheckoutForm`.
- **Off-site redirect form** `src/PluginForm/RedirectCheckoutForm` (extends
  `PaymentOffsiteForm`) — builds a Payrexx `Gateway` request and redirects the
  browser (`REDIRECT_POST`) to the Payrexx-hosted checkout link.
- **Webhook controller** `src/Controller/WebhookController::transactionHandler` —
  route `commerce_payrexx_integration.webhook` → `/commerce/payrexx/webhook`. Handles
  the asynchronous server-to-server notification from Payrexx.
- **Transaction handler service** `src/TransactionHandlerService`
  (`commerce_payrexx_integration.transaction_handler_service`) — the shared logic
  that fetches the authoritative transaction from Payrexx and writes the Commerce
  payment. Reused by both the gateway plugin (return/cancel) and the webhook.
- **Checkout pane** `commerce_payrexx_integration_commerce_pane_payment_method_selection`
  (`src/Plugin/Commerce/CheckoutPane/PaymentMethodSelectionPane`, step
  `order_information`) — optional radios that let the shopper pre-select a payment
  method (or "I'll choose later"). Options are fetched live from the Payrexx
  instance's active payment methods.
- **Event** `commerce_payrexx_integration.payment_response`
  (`PayrexxEvents::PAYMENT_RESPONSE`), dispatched with `PaymentResponseEvent`
  (`getOrder()`, `getTransaction()`) after every processed response regardless of
  status — subscribers must check the status themselves.
- **Alter hook** `hook_commerce_payrexx_integration_gateway_alter(Gateway $gateway,
  Order $order, RedirectCheckoutForm $form)` — invoked by `RedirectCheckoutForm`
  before the gateway request is sent to Payrexx, so other modules can mutate the
  outgoing request.
- **`.module`**: one helper `commerce_payrexx_integration_process_payment_radios()`
  (an `#after_build` that wraps each payment-method radio in a CSS class).
- **Config schema** for the gateway plugin settings
  (`config/schema/…payrexx_redirect_checkout.yml`). No `.install`, no permissions of
  its own, no Drush commands, no templates, no JS.
- Trait `GatewayPluginInstanceGetterTrait` — resolves the `PayrexxRedirectCheckout`
  plugin from an order's `payment_gateway` reference (returns null if the order's
  gateway is not this plugin).

## Configuration (gateway plugin settings)

From `PayrexxRedirectCheckout::buildConfigurationForm()` / `defaultConfiguration()`:

- **Instance name** (`instance_name`, required) — the Payrexx instance (the
  `instancename` in `https://instancename.payrexx.com/`).
- **Secret** (`secret`, required) — the Payrexx API secret; keys every authenticated
  SDK call.
- **VAT** (`vat`, required) — VAT percentage passed to Payrexx (`setVatRate`).
- **Fee** (`fee`, required) — fee percentage; added to the amount before charging
  (`amount + amount * fee / 100`).
- **Send "basket"** (`send_basket`, default TRUE) — when on, sends the order's line
  items + non-included, non-zero adjustments to Payrexx as a basket (Payrexx then
  recalculates and overrides the amount from the basket).

`validateConfigurationForm()` verifies the entered credentials at save time by
constructing a Payrexx SDK client and issuing an authenticated `SignatureCheck`
call; if it throws, the form errors out ("API credentials are incorrect."). The
gateway also inherits the standard Commerce **mode** (test/live) and display
settings from `OffsitePaymentGatewayBase`.

## Payment flow (from source)

- **Checkout** — `RedirectCheckoutForm::buildConfigurationForm()` builds a Payrexx
  `Gateway` with the server-side amount (payment amount + fee, in minor units),
  currency, VAT, success/cancel/failed redirect URLs (Commerce's own return/cancel
  URLs), the pre-selected payment method (if any), `preAuthorization=false`,
  `reservation=false`, and `referenceId = order id` (zero-padded to ≥ 4 chars). It
  fires the `_gateway_alter` hook, calls `$payrexx->create($gateway)`, stores the
  returned Payrexx gateway id on the order as `payrexx_gateway_id`, saves the order,
  and redirects the browser (POST) to `$response->getLink()`.
- **Return / cancel** — `PayrexxRedirectCheckout::onReturn()` and `onCancel()` both
  construct a Payrexx SDK client from the gateway config and call
  `TransactionHandlerService::processOrder($order, $payrexx)`.
- **Webhook** — `WebhookController::transactionHandler()` decodes the posted body to
  read only the **reference id** (= order id), loads that order (via
  `loadUnchanged`), resolves this order's Payrexx gateway plugin, builds a Payrexx
  SDK client from the gateway config, and calls the same
  `processOrder($order, $payrexx)`. The controller comments that the posted
  transaction is untrusted and reloads it from the remote server. If the reference
  id is empty it logs and throws; if the order can't be loaded it throws
  `NotFoundHttpException`.
- **`processOrder()`** (the authoritative step) — reads the order's stored
  `payrexx_gateway_id`, calls the authenticated `$payrexx->getOne(Gateway)` to fetch
  that gateway's invoices/transactions, then `$payrexx->getOne(Transaction)` to fetch
  the transaction by its Payrexx id. The **status and amount used come from this
  re-fetched, API-authenticated transaction**, never from the incoming request. If
  no transaction exists yet, it treats it as an early cancellation (warning message,
  no payment). Payrexx SDK errors are logged and re-thrown as `PaymentGatewayException`.
- **Status mapping** (`handleResponse()`, strict `in_array(..., TRUE)`): `confirmed`
  → completed payment; `authorized`/`reserved` → authorization; `initiated`/`waiting`
  → pending; `cancelled`/`expired` → cancelled (+ resume-checkout warning);
  `declined`/`error`/`insecure`/`uncaptured` → failed (+ error message); refund
  statuses and anything else are logged only.
- **`saveCommercePayment()`** — loads any existing payment by remote id (Payrexx
  transaction id) or creates one bound to this order + gateway, sets the state, the
  `remote_state` (Payrexx status), and the amount from the re-fetched transaction
  (`amount / 100`, currency from the invoice). The `PaymentResponseEvent` is
  dispatched for success/partial/pending/cancelled/error branches.

## Transport & trust model

All remote communication goes through the `payrexx/payrexx` SDK, which signs each
request with the API secret (an HMAC API signature) over HTTPS to the Payrexx REST
API. The module itself sets no HTTP client options. The webhook and browser-return
paths both derive the final payment status **only** from a transaction re-fetched
through that authenticated API, bound to the order's own stored gateway id — the
request body is used only to locate the order. Amounts charged are computed
server-side from the Commerce order/payment.

The surface is a single gateway plugin plus its webhook controller, transaction
service, and one optional checkout pane, so everything is documented here — no
separate subdocs are warranted.
