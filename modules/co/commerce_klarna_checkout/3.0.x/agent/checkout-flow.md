<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkout lifecycle: offsite form, callbacks, confirmation

## 1. Payment step — embed the Klarna snippet

`PluginForm\OffsiteRedirect\KlarnaCheckoutForm::buildConfigurationForm()` runs at the offsite
payment step. It assembles `merchant_urls`:

- `checkout` = `$form['#cancel_url']`
- `confirmation` = `$form['#return_url']`
- `push` = decoded `getNotifyUrl()` (contains `?klarna_order_id={checkout.order.id}`)
- `validation` (only if `enable_order_validation`) = `getValidationUrl()` plus a
  `?klarna_validation_destination=<current>` param.

If the order already has `data.klarna_order_id`, it calls `KlarnaManager::updateOrder()`; otherwise
`createOrder()`, storing the returned Klarna id in `$order->setData('klarna_order_id', …)` with
`REFRESH_SKIP`. The Klarna **`html_snippet`** is rendered raw via `Markup::create()` — this snippet
is the payload of the authenticated API fetch (trusted, TLS). A pending validation-failure flag
(key-value `commerce_klarna_checkout.order_validation`) surfaces a generic
"Payment failed…" message and is then cleared.

## 2. Push callback (`onNotify`, default case)

Route: `commerce_payment.notify` (`/payment/notify/{gateway}`, public webhook). Klarna calls it
with `?klarna_order_id=<id>` (retried every 4h for 48h until acknowledged).

Flow: `onNotify()` → `acknowledgeOrder($klarna_order_id)` →
`KlarnaManager::acknowledgeKlarnaOrder()`:
1. **Re-fetch** the Klarna order over the authenticated connector — `loadOrder()` (Checkout
   endpoint), falling back to `loadCompletedOrder()` (Order Management endpoint).
2. Load the Commerce order from the re-fetched `merchant_reference2` (`loadForUpdate`).
3. Dispatch `ACKNOWLEDGE_ORDER` (address/profile sync), set the order email from Klarna's billing
   address, save with `REFRESH_SKIP`.
4. `acknowledgeOrder()` on the Klarna Order-Management API (marks it acknowledged on Klarna's side).
5. Back in the gateway, create the Commerce payment from Klarna's `order_amount`/`purchase_currency`
   and capture if configured.

Because the amount and order binding come from the authenticated re-fetch (and acknowledgement is
idempotent via `loadByRemoteId`), a forged/replayed push cannot mark an order paid.

## 3. Browser return (`onReturn`)

Reads `klarna_order_id` from `$order->getData()` (server-stored), then `acknowledgeOrder()` — the
same idempotent path, so whichever of push/return arrives first does the work and the other no-ops.

## 4. Validation callback (`?callback=validation`)

Only active when `enable_order_validation` is on (adds
`options.require_validate_callback_success = TRUE` to the Klarna order). Klarna POSTs the order
snapshot before completing. `CallbackHandler::processOrderValidation()` loads the order by
`merchant_reference2`, dispatches `ORDER_VALIDATION` (`KlarnaEventSubscriber::onValidate()` checks
the Klarna total equals the Commerce total), then locks the order and returns HTTP 200. On failure
it flags the order in key-value and returns a 303 redirect to `klarna_validation_destination`.

## 5. Confirmation pane

`Plugin/Commerce/CheckoutPane/KlarnaCheckoutConfirmation` (id
`commerce_klarna_checkout_confirmation`, default step `complete`) fetches the Klarna order
(`KlarnaManager::getOrder()`) and renders its `html_snippet` on the completion page. `isVisible()`
returns true only for orders whose payment gateway plugin is `klarna_checkout`.

## 6. Order cancellation

`EventSubscriber/OrderSubscriber` reacts to `commerce_order.cancel.post_transition`: for
Klarna-paid orders it calls the gateway's `cancelOrder()`, which cancels the Klarna order and voids
the Commerce payments.
