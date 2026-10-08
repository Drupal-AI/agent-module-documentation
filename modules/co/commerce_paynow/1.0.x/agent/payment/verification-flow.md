<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Offsite authorization, webhook & return verification

Provider: **Paynow (mBank), Poland**, via `pay-now/paynow-php-sdk` ^3.0. **PLN only.** Plugin id
`paynow` (`src/Plugin/Commerce/PaymentGateway/Paynow.php`). The plugin is a thin integration point;
all domain logic lives in `src/Service/*` and `src/Repository/*`.

## 1. Redirect out — authorization (`PaynowForm`)

`src/PluginForm/PaynowForm::buildConfigurationForm()` orchestrates (services injected, no SDK
objects built inline):
1. `OrderNumber::setOrderNumber($order)` assigns the order number (number-pattern plugin, or order
   id fallback) and saves the order — this becomes the Paynow `externalId`.
2. `PaymentDataBuilder::build($payment, $order)` maps the order to the Paynow request array:
   - `amount` = order/payment total in **minor units (grosz)** via integer `round(number*100)`;
   - throws `PaymentGatewayException` if the currency is not `PLN`;
   - `currency`, `externalId` (order number), `description`, `buyer` (email + billing name/address
     when a billing profile exists), `orderItems` (per line item, category `physical`), and
     `continueUrl = Url::fromRoute('commerce_payment.checkout.return', …, absolute)`.
   All amounts are derived **server-side** from the order — never from request input.
3. The local `commerce_payment` is saved (state `new`) so it has an id.
4. `IdempotencyKeyGenerator::generate($payment)` = first 45 chars of
   `sha256(paymentId:orderId:gatewayId:amount:currency)` — deterministic, so a retry of the same
   payment reuses the same Paynow idempotency key (no duplicate remote payment).
5. `PaymentAuthorizer::authorize($client, $paymentData, $idempotencyKey)` calls
   `Paynow\Service\Payment::authorize()`; SDK errors become `PaymentGatewayException`.
6. The returned Paynow payment id is stored as the payment `remote_id`, and the shopper is
   redirected (`buildRedirectForm(..., 'get')`) to the Paynow `redirectUrl`.

## 2. Async webhook — `NotificationProcessor::process()`

Route `commerce_paynow.webhook` = `POST /commerce-paynow/webhook/{commerce_payment_gateway}`,
`_access: 'TRUE'` (unauthenticated by design — an external callback). `PaynowWebhookController`
checks the plugin is the `paynow` gateway and delegates to `onNotify()` →
`NotificationProcessor::process($request, $signatureKey, $gatewayId, $config)`:

1. **Signature verification first.** `new \Paynow\Notification($signatureKey, $payload, $headers)`
   recomputes `base64(HMAC-SHA256(payload, signatureKey))` and throws
   `SignatureVerificationException` when it does not equal the `Signature` header. Any exception →
   HTTP 400. Request headers are flattened (Symfony lowercases header keys; the SDK accepts
   `Signature`/`signature`).
2. JSON-decode the body; invalid JSON → 400. Require `paymentId`, `status`, `externalId` → else 400.
3. `PaynowStatusMap::isKnown($status)` allowlist (strict `in_array`); unknown → 400.
4. `applyNotification()` resolves the order by `order_number == externalId`
   (`loadByProperties`), then branches on the status class:
   - **CONFIRMED** → `handleConfirmed()`: acquires `\Drupal\Core\Lock`
     `commerce_paynow:{orderId}:{paymentId}` (30s) to serialise concurrent deliveries; loads
     existing payments for `(remote_id, order_id)`. If none, `PaymentRepository::createCompleted()`
     creates a `completed` payment with `amount = $order->getTotalPrice()` (**server-side total**),
     `remote_state = CONFIRMED`. If one exists and is still `new`, it is transitioned to
     `completed`; an already-processed (non-`new`) payment is skipped as a duplicate. Lock released
     in `finally`.
   - **FAILED** (`REJECTED`/`ERROR`/`EXPIRED`/`ABANDONED`) → `handleFailed()`: if a local payment
     exists it is set to `authorization_voided` with the remote state; a missing record is not an
     error (the failure may precede the return flow).
   - **NEW / PENDING** → acknowledged, no state change.
5. Success → `JsonResponse()` (200); any handled failure → `JsonResponse([], 400)`.

The processor logs only structured metadata — never the raw payload.

## 3. Browser return — `ReturnFlowProcessor::process()`

`Paynow::onReturn($order, $request)` reads `paymentId` + `paymentStatus` from the query string
(both required, else `PaymentGatewayException`) but **does not trust `paymentStatus`**. It delegates
to `ReturnFlowProcessor`:
1. `PaymentRepository::loadByRemoteId($paymentId, $order, $gatewayId)` — bound to `order_id` AND
   `payment_gateway` (documented "BOLA defense"); missing → `PaymentGatewayException`.
2. If the payment is already `completed` (the signed webhook may have landed first) → idempotent
   no-op return. A payment in any state other than `new`/`completed` → exception.
3. Otherwise `new \Paynow\Service\Payment($client); $paymentService->status($paymentId)` fetches the
   **authoritative remote status** from Paynow's authenticated API. On CONFIRMED → set `completed`,
   `remote_state`, authorized time, save. On a failed status → `PaymentGatewayException`. SDK errors
   are logged and surfaced as a generic verification error.

## 4. Status map — `ValueObject/PaynowStatusMap`

Single source of truth. `ALL` = allowlist (`NEW`, `PENDING`, `CONFIRMED`, `REJECTED`, `ERROR`,
`EXPIRED`, `ABANDONED`); `CONFIRMED` = success; `FAILED` = `[REJECTED, ERROR, EXPIRED, ABANDONED]`.
`isConfirmed()`/`isFailed()`/`isKnown()` use strict comparison. Both flows classify status through
this class so new Paynow statuses are handled consistently.

## 5. Config form (`Paynow::buildConfigurationForm`)

Fields on the `commerce_payment_gateway.<id>` entity: `api_key` and `signature_key`
(`#type => 'password'`, no `#default_value`, blank-to-keep on resubmit), `application_name`
(User-Agent), `environment` (`sandbox` → `https://api.sandbox.paynow.pl`, `production` →
`https://api.paynow.pl`), `enable_logging` (gates debug/info; warning/error always logged).
`PaynowClientFactory::createFromConfiguration()` builds the `Paynow\Client` from these values,
selecting the SDK `Environment` enum (HTTPS base URLs are fixed by the SDK).
