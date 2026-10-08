<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment endpoints (create / capture / void)

Three `@RestResource` plugins for handling payment on an already-created order. All require the
gateway plugin to be an **on-site** gateway (`OnsitePaymentGatewayInterface`). Payment amount is
always the server-side `$order->getTotalPrice()`.

## 1. Payment create — `POST /commerce/payment/create/{order_id}`
`src/Plugin/rest/resource/PaymentCreateResource.php` — id `commerce_decoupled_checkout_payment_create`.
Services: `entity_type.manager`, `module_handler`, logger. Returns the created payment (201).

Payload:
```jsonc
{ "gateway": "paypal_test", "type": "paypal_ec", "details": {}, "capture": false }
```
Flow: `hook_payment_create_prepare_alter()` (with `order_id` merged in) → load order (must exist and
be in **draft** state) → load gateway (must exist, must be on-site) → create a `commerce_payment_method`
(uid = order customer, billing profile from order) and `createPaymentMethod($pm, details)` → create a
`commerce_payment` with `amount => $order->getTotalPrice()`. If `capture` is falsy it calls
`createPayment($payment, FALSE)` (initialize only); otherwise `createPayment($payment)` (create +
capture). If the resulting payment state is `completed`, applies the order `place` transition and sets
`total_paid`. Saves the order. Errors → `BadRequestHttpException`.

## 2. Payment capture — `POST /commerce/payment/capture/{order_id}/{payment_id}`
`src/Plugin/rest/resource/PaymentCaptureResource.php` — id `commerce_decoupled_checkout_payment_execute`.
No request body. Services: `entity_type.manager`, `lock`, logger.

Flow: load order (must exist) and payment (must exist); verify `payment->getOrderId() == order_id`;
acquire a lock keyed `commerce_decoupled_checkout_payment_processing_{payment_id}` (60s; on contention
`wait(10)` then retry). After the lock it **resets cache and reloads** the payment; if already
`completed` → `ConflictHttpException` (409); if the lock could not be acquired → `LockedHttpException`
(423). Order must be in **draft** state. Calls the gateway plugin's `capturePayment($payment)`; on a
resulting `completed` state it applies the order `place` transition, sets `total_paid`, saves, and
returns `'OK'`. The lock is released in `finally` (only by the initiating request). Payment declines →
`DeclineException` mapped to `BadRequestHttpException`. If capture did not complete → 400.

## 3. Payment void — `POST /commerce/payment/void/{order_id}/{payment_id}`
`src/Plugin/rest/resource/PaymentVoidResource.php` — id `commerce_decoupled_checkout_payment_void`.
No request body. Services: `entity_type.manager`, logger.

Flow: load order + payment (both must exist); verify `payment->getOrderId() == order_id`; reject if
the payment state is `voided`, `authorization_voided`, or `completed` (cannot be voided). Calls the
gateway plugin's `voidPayment($payment)`; returns `'OK'`. Errors → `BadRequestHttpException`.

## Enabling
Each of these is a core REST resource — enable the resource, choose auth provider(s), and grant the
corresponding `restful post …` permission (`… _payment_create`, `… _payment_execute`,
`… _payment_void`) before use. Serve over HTTPS.
