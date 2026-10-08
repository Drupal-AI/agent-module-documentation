<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Synpay payment flow (checkout → PSP → notify/return)

## Binding a Commerce gateway to a provider

`SynpayPaymentGateway` (id `synpay`) extends `OffsitePaymentGatewayBase`. Its
`buildConfigurationForm()` adds one field, `gateway` (radios), listing every Synpay PSP whose
`"{id}_active"` flag is on in `synpay.settings` (label from the plugin definition `title`). The
selected id is stored in the Commerce gateway plugin configuration as `configuration['gateway']`;
`mode` (test/live) is the standard Commerce off-site gateway setting. A store can add several
"Synpay Gateway" instances, each bound to a different PSP.

## Checkout (off-site) — the main flow

1. At the *review* step the shopper submits; Commerce builds the off-site form
   `OffsitePaymentForm` (`src/PluginForm/OffsiteRedirect/OffsitePaymentForm.php`).
2. `buildConfigurationForm()` saves the payment (to get an id), reads the bound gateway config via
   `getPluginConfig()` (`gateway`, `mode`, order-id prefix/suffix), and calls
   `GatewayService::init($mode, $config)` which instantiates the selected provider plugin.
3. It builds the request `$params` from the **order's own items and adjustments** (server-side
   amounts via `getAdjustedUnitPrice()`/`getAdjustedTotalPrice()`, normalized to the provider's
   `PRECISION` with `normalizePrice()` → `bcmul(...,'100')` for minor-unit providers), the order
   email, and the Commerce `#return_url` / `#cancel_url`. `order_id` sent to the PSP is
   `"{prefix}{order}/{payment}{suffix}"` (Commerce payment id is embedded for a monotonic API id).
4. `GatewayService::registerOrder()` → the provider's `registerOrder()` calls the PSP API and
   returns `['orderId' => <remote id>, 'formUrl' => <url>]` (or Robokassa's `['url','data','orderId']`).
5. On success the payment is set to state `authorization`, its `remote_id` is set to the PSP order
   id, and `buildRedirectForm()` redirects the browser to the PSP — `REDIRECT_POST` for Robokassa,
   `REDIRECT_GET` otherwise. On failure the payment is set to `authorization_voided` and logged to
   the `synpay` channel.
6. **CloudPayments** is the exception: its `registerOrder()` returns a `formUrl` pointing at
   `"/synpay/onsite/{gateway_id}/{payment_id}"`; `PayController::onsite()` →
   `SynpayCloudPayments::onsite()` renders the CloudPayments JS widget (public id, amount, currency,
   order email) using the `synpay/cloudpayments` library instead of redirecting off-site.

## Return and notification routes

Route handlers live in `PayController` (`src/Controller/PayController.php`); each looks the
provider up via `SynpayGatewayManager::createInstance()` and calls a method if it exists.

- **`synpay.return_direct`** `/synpay/return_direct/{plugin_name}` → `returnDirect()` →
  provider `callback(Request)`. Used as the PSP `SuccessURL`/`returnUrl` for Tinkoff, Sber, Sgb,
  Alfa, YooKassa direct-pay; shows a "completed / not completed" message.
- **`synpay.return`** `/synpay/return/{plugin_name}` → `return()` → provider `return(Request)`;
  Robokassa's customer *SuccessURL*. Redirects to `/checkout/{order}/complete` or `/review`.
- **`synpay.callback`** `/synpay/callback/{plugin_name}` → `callback()` → provider
  `callback(Request)`; the PSP result/IPN endpoint for **Robokassa** (its *ResultURL*) and
  **CloudPayments** (its pay notification).
- **Commerce notify** `/payment/notify/{commerce_payment_gateway}` (from
  `OffsitePaymentGatewayBase`) → `SynpayPaymentGateway::onNotify()` → `GatewayService::onNotify()`
  → provider `onNotify(Request)`. This is the IPN/webhook used by Tinkoff (`NotificationURL`),
  Tinkoff Credit/Dolyame, Alfa, Sber/Sgb, Yandex Pay and YooKassa.
- **Commerce return** → `SynpayPaymentGateway::onReturn()` → `GatewayService::onReturn()` →
  provider `onReturn(OrderInterface, Request)`, run when the shopper lands back on the Commerce
  return URL; throws `PaymentGatewayException` if the provider does not report `completed`.

## How payment/order state is set

Each provider's `onReturn()` / `onNotify()` / `callback()` resolves the Commerce payment (by
`remote_id`, by `order_id`, or by entity id depending on the provider), then:

- RBS-family providers (**Sber, Sber QR, Sgb, Sbercredit/installment**) re-query the acquiring API
  (`getOrderStatus()`) and map `OrderStatus::DEPOSITED` → payment `completed`, else
  `authorization_voided` (`updatePayment()`).
- **Tinkoff / Tinkoff QR** map notification/`GetState` status `CONFIRMED`/`AUTHORIZED` → `completed`.
  **Tinkoff Credit** maps `signed`/`approved`; **Tinkoff Dolyame** maps `wait_for_commit`/`committed`.
- **YooKassa** re-checks payment info via the SDK on return; on notify it reads the posted object.
- **Robokassa** completes based on its `SignatureValue` result parameters (password #1 for the
  success URL, password #2 for the result URL).
- **PayKeeper** processes its notification `key` parameter; **Yandex Pay** processes its signed
  notification payload against Yandex's JWKS.

On success providers that finalize the order dispatch `CheckoutEvents::COMPLETION`, run the order
`place` transition and save; `setCompletedTime(time())` is recorded on the payment. Order state
transitions are guarded (`getState()->getId() !== 'completed'` / `isTransitionAllowed('place')`),
and Sber/Tinkoff acquire a `payment-lock-name-{order}` lock while updating.

## Admin status & refund (per order)

- `PaymentsCheckForm` (`/admin/commerce/orders/{order}/payments_check`, perm
  `administer commerce_order`) lists the order's payments and, via AJAX, calls the provider's
  `checkOrderStatus()` (read-only) — plus an `updateOrderStatus()` button shown only to uid 1.
- `PaymentsRefundForm` (`/admin/commerce/orders/{order}/payments_refund`, perm
  `administer commerce_order`) builds a per-line refund, calls the provider's `requestRefund()`
  (implemented for Tinkoff; most others return "not implemented"), and updates the payment to
  `partially_refunded` / `refunded`.

## Direct-pay / test routes

`synpay.pay` (`/synpay/pay/{plugin_name}/{order}/{total}`) and `synpay.test`
(`/synpay/test/{plugin_name}/{orderId}`) are gated by the `access synpay pay` permission and drive a
provider's `pay()` / `onReturnTest()` for quick manual pay links and test harnessing outside the
normal Commerce checkout; `PayController::page()` renders `PayForm` for the given provider.
