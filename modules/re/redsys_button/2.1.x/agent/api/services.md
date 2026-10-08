<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: services, entities, events, routes

## Services (`redsys_button.services.yml`)

- `redsys_button.operation_manager` (`OperationManager`) — orchestrator.
  - `create(array $values): RedsysPaymentInterface` — creates a pending `redsys_payment`. Required keys:
    `amount` (int, minor units, 1…999999999999), `method` (`C` card, `z` Bizum, `P` PayPal, `xpay`),
    `origin_type` (`standalone`|`webform`|`payment_request`); optional `email`, `description`,
    `origin_id`, `origin_metadata`. Currency/terminal/merchant/key/signature_version come from
    `redsys_button.settings`. Generates `order_number` and a 32-byte `return_token`.
  - `buildRedirectResponse(RedsysPaymentInterface): Response` — auto-submitting HTML form POSTing the
    signed `Ds_SignatureVersion`/`Ds_MerchantParameters`/`Ds_Signature` to the Redsys endpoint.
  - `processCallback(Request): RedsysPaymentInterface` — validates a notification/return and applies the
    status. **Verifies signature + immutable fields before completing** (see Security). Lock-guarded and
    idempotent; runs completion side effects (email once, `payment_completed` event once).
  - `cancel(RedsysPaymentInterface)` — marks a still-pending operation canceled.
- `redsys_button.credentials` (`CredentialProvider`) — `getSecret(?string $key_id)` reads the merchant
  secret from the Key repository; throws if missing/empty.
- `redsys_button.signature` (`SignatureManager`) — `encodeParameters`, `decodeParameters`,
  `sign($encoded,$order,$secret,$version)`, `verify(...)` (timing-safe `hash_equals`). V1 = 3DES-derived
  HMAC-SHA256 (std Base64); V2 = AES-128-CBC-derived HMAC-SHA512 (URL-safe Base64).
- `redsys_button.request_factory` (`PaymentRequestFactory`) — builds signed requests; `decodeCallback`,
  `validateCallback`, `parameter` for callbacks. Endpoints: test `sis-t.redsys.es:25443/sis/realizarPago`,
  live `sis.redsys.es/sis/realizarPago`.
- `redsys_button.payment_request_manager` (`PaymentRequestManager`) — payment-request lifecycle;
  `expireDueRequests()` is called from `hook_cron`.
- Others: `redsys_button.order_number` (`OrderNumberGenerator`, collision-resistant refs),
  `redsys_button.amount_converter` (`AmountConverter::toMinorUnits`), `redsys_button.response_classifier`
  (`ResponseClassifier::classify`), `redsys_button.payment_display`, `redsys_button.redsys` (`lib\redsys\RedSys`).

## Content entities

- `redsys_payment` (`RedsysPayment`) — one audit record per attempt. Fields incl. `order_number`,
  `status` (`STATUS_PENDING`/`STATUS_COMPLETED`/`STATUS_FAILED`/`STATUS_CANCELED` on
  `RedsysPaymentInterface`), `amount`, `currency`, `method`, `merchant_code`, `terminal`, `key_id`,
  `signature_version`, `response_code`, `authorization_code`, `provider_status`, `completed_at`,
  `return_token`, `mail_sent`, `completion_dispatched`, `origin_type`/`origin_id`/`origin_metadata`.
- `redsys_payment_request` (`RedsysPaymentRequest`) — fixed-amount token-protected payment link
  (immutable amount + concept, allowed methods, optional payer email + expiry). One active attempt at a
  time; signed success closes it permanently, rejection/cancel reopens it.

## Events (dispatch to react in your own EventSubscriber)

- `RedsysPaymentCompletedEvent::NAME` = `redsys_button.payment_completed` — after a completed operation
  (fired once via `completion_dispatched`). Property: `$event->payment`.
- `RedsysPaymentStatusEvent::NAME` = `redsys_button.payment_status` — on any status observation.
  Properties: `$event->payment`, `$event->previousStatus`.

## Routes

- `POST /redsys/notify` — server notification (`_access: TRUE`, signature-verified).
- `/redsys/return/{redsys_payment}/{token}` — customer receipt (token-gated; a signed return may update).
- `/redsys/cancel/{redsys_payment}/{token}` — customer cancel (token-gated, pending only).
- `/redsys/payment-request/{redsys_payment_request}/{token}` — pay a payment request (token-gated form).
- Admin: `/admin/content/redsys-payments`, `/admin/content/redsys-payment-requests` (+ add/duplicate/cancel).

No Drush commands. Provides config schema. No custom plugin *types* (defines a Block plugin, a Webform
handler and Commerce gateway plugins in submodules, but no plugin managers of its own).
