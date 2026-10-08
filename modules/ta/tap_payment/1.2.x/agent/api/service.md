<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tap Payment — public service API

Inject `Drupal\tap_payment\TapPaymentInterface` (service id `tap_payment.payment`). Everything below is `@api`, stable within the major version. Unchanged in 1.2.x — this release touched only Drupal 12 compatibility and status-report severity mapping.

## createPayment(PaymentRequest $request, string $gatewayId = 'tap'): PaymentSession
Creates a Tap charge, records it, returns where to send the payer. Idempotent for a given key (second call returns the first payment). Throws `InvalidPaymentRequestException` (incl. off-site return URL), `ConfigurationException`, `ApiException`.

```php
use Drupal\tap_payment\Dto\{Customer, Money, PaymentRequest};
$session = \Drupal::service('tap_payment.payment')->createPayment(new PaymentRequest(
  money: new Money('10.500', 'KWD'),
  customer: new Customer(firstName: 'Ada', email: 'ada@example.com'),
  returnUrl: '/thank-you',
  contextModule: 'my_module',
  contextId: (string) $order_id,
));
$url = $session->redirectUrl();   // redirect payer here
```

## verifyPayment(TapTransactionInterface $tx): TapTransactionInterface
Re-reads the charge from Tap and updates the ledger (contacts Tap every call). Throws `ApiException` if Tap is unreachable, `ConfigurationException` if no usable key is configured.

## loadByChargeId / loadByIdempotencyKey / loadByContext
Find ledger rows by Tap charge id, idempotency key, or `(contextModule, contextId)`.

## Value objects (final, immutable, validate on construction)
`Money` (decimal **string** + ISO 4217), `Customer`, `PaymentRequest`, `Payment`, `PaymentSession` (`redirectUrl()`). No card/token/PII carried.

## Enums
`PaymentState` (`isSuccessful()` true only for Captured; `fromStatus()` returns null for undocumented), `Environment` (Sandbox/Production).

## Events (names on `Event\TapPaymentEvents`)
`PAYMENT_CREATED`, `PAYMENT_CAPTURED` (only success signal, fires once), `PAYMENT_FAILED`, `PAYMENT_CANCELLED`, `WEBHOOK_RECEIVED` (unauthenticated — monitoring only), `WEBHOOK_VERIFIED`. Subscribe to fulfil orders without patching this module.

## Extending
Add a payment gateway via a `PaymentGateway` plugin; add a Tap API version via a class tagged `tap_payment_api_adapter` plus the `tap_payment.api_version` parameter.
