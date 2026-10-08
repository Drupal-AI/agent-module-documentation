<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateway plugin `yookassa`

`src/Plugin/Commerce/PaymentGateway/YooKassa.php` — `@CommercePaymentGateway(id="yookassa")`,
extends `OffsitePaymentGatewayBase`. Label/display_label "YooMoney". `payment_method_types =
{"yookassa_epl"}`, `modes = {"n/a"}`. Forms: `offsite-payment` → `PaymentOffsiteForm`,
`test-action` → `PaymentMethodAddForm`. Const `YOOMONEY_MODULE_VERSION = '1.2.1'`.

The plugin instance is built per request: the constructor reads the current
`commerce_payment_gateway` route param, loads its stored config via
`getPaymentMethodConfig()` (`Drupal::config('commerce_payment.commerce_payment_gateway.<id>')
->getOriginal('configuration')`), and builds the SDK client through
`YooKassaClientFactory::getYooKassaClient($config)` (see api/oauth-and-notifications.md). It also
wires a `YooKassaLoggerHelper` (telemetry) and a `YooKassaNotificationHelper`.

## Checkout → redirect (`PaymentOffsiteForm::buildConfigurationForm`)

`src/PluginForm/YooKassa/PaymentOffsiteForm.php`. On the payment step it:
1. Runs `migrateTaxRates()` (tax-code remap 4→11, 6→12).
2. Builds a `CreatePaymentRequest` via the SDK builder: amount = `$order->getTotalPrice()`,
   `setCapture(true)`, description from `createDescription()`, confirmation
   `type=REDIRECT, returnUrl=$form['#return_url']`, metadata `{cms_name, module_version}`,
   `setTaxSystemCode($config['default_tax_rate'])`.
3. If `receipt_enabled === 1`, `factoryReceipt()` adds 54-FZ receipt items (email from
   `$order->get('mail')`, per-item VAT code from `yookassa_tax` map or `default_tax`, plus
   `default_payment_mode` / `default_payment_subject`), then `normalize()`s the receipt.
4. `$client->createPayment($paymentRequest)`; stores the returned id/status onto the Commerce
   payment (`setRemoteId`, `setRemoteState`).
5. `buildRedirectForm(... $response->confirmation->confirmationUrl ...)` sends the customer to the
   YooKassa hosted page.

`createDescription()` fills the `description_template` (default "Payment for order No.
%order_id%") by scanning order fields into `%field%` placeholders and truncating to
`PaymentInterface::MAX_LENGTH_DESCRIPTION` (128).

## Return handling (`YooKassa::onReturn`)

Loads the Commerce payment for the order, takes its `remoteId`, and **re-fetches the payment from
the YooKassa API**: `$apiClient->getPaymentInfo($paymentId)`. If status is
`WAITING_FOR_CAPTURE`, it captures for the API-returned amount
(`CreateCaptureRequest::builder()->setAmount($paymentInfoResponse->getAmount())`). Only if the
local payment is still in state `new` does it call
`YooKassaNotificationHelper::processReturn()`, which marks the payment `completed` when the API
status is `SUCCEEDED` (or `pending` when `PENDING && paid`); a `CANCELED`/other status returns
false → `NeedsRedirectException` to the Commerce checkout cancel URL (`buildCancelUrl`, route
`commerce_payment.checkout.cancel`).

## Notification handling (`YooKassa::onNotify`)

Bound to Commerce core route `commerce_payment.notify` (`/payment/notify/{gateway}`), the
notification URL surfaced in the settings form and registered as a YooKassa webhook. Flow:
1. Parse raw JSON body; 400 if not JSON. Build `NotificationFactory()->factory($data)`; ignore
   `RefundResponse` (200 OK).
2. Skip (200) if the notification metadata `cms_name` is set and does not match
   `YooKassa::getCmsName()` (`yoo_api_drupal10`/`11`).
3. Load the local Commerce payment by `remote_id = notification payment id`; 400 if none, 404 if
   no order, 200 if the order is already `completed`.
4. **Re-fetch the payment from the YooKassa API** by that id: `$apiClient->getPaymentInfo(...)`.
5. `YooKassaNotificationHelper::processNotification($notificationModel, $paymentInfo, $payment)`
   decides the outcome from **both** the notification event **and** the API-fetched status:
   - `payment.succeeded` + API `SUCCEEDED` → `handleSucceededPayment()` → payment `completed`.
   - `payment.waiting_for_capture` + API `WAITING_FOR_CAPTURE` → `handleWaitingForCapture()`
     captures for `$paymentInfo->getAmount()`, then sets `completed`/`canceled`.
   - `payment.canceled` + API `CANCELED` → telemetry only.
   - API `PENDING` → payment set `pending`.
   Returns 200 "OK" on success, else 400/500.

`tryToUpdatePaymentStatus()` (`YooKassaNotificationHelper`) does the actual
`setRemoteState()/setState()/save()`. The order state advances through the `yookassa_workflow`
(draft→waiting→paid→completed / canceled).

## Payment method type

`src/Plugin/Commerce/PaymentMethodType/YooKassaEPL.php` — id `yookassa_epl`, label "YooMoney
(bank cards, e-money, etc.)", extends abstract `YooKassaPaymentMethod` (extends
`PaymentMethodTypeBase`) which returns no bundle fields (`buildFieldDefinitions()` → `[]`).

## Gateway delete

Constructor calls `actionsBeforeDelete()`: when the delete confirm form
(`commerce_payment_gateway_delete_form`) is posted and an access token exists, it revokes the
OAuth token at YooMoney and clears `configuration.access_token`.
