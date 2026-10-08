<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Base API — `commerce_payment_extra`

API-only module (no routes, no hooks, no config of its own). Provides the payment-resolution service, its
override events, and the queue job types that perform captures/voids. Everything that reacts to orders lives
in the [`commerce_payment_extra_order` submodule](order.md).

## `PaymentManager` service

Service id `commerce_payment_extra.manager`, class `Drupal\commerce_payment_extra\PaymentManager`.
Constructor args: `@entity_type.manager`, `@logger.channel.commerce_payment_extra`, `@event_dispatcher`.

```php
$manager = \Drupal::service('commerce_payment_extra.manager');
$capturable = $manager->loadCapturablePaymentsByOrder($order); // PaymentInterface[]
$voidable   = $manager->loadVoidablePaymentsByOrder($order);   // PaymentInterface[]
```

Each method loads **all** of the order's payments via
`commerce_payment` storage `loadMultipleByOrder($order)`, wraps them in a filter event, dispatches it, and
returns `$event->getPayments()`. The manager does no capability check itself — that is entirely up to
subscribers (the default one below).

## Filter events

Constants on `Drupal\commerce_payment_extra\Event\PaymentExtraEvents`:

| Constant | Event name | Event object |
|----------|-----------|--------------|
| `FILTER_CAPTURABLE_PAYMENTS` | `commerce_payment_extra.filter_capturable_payments` | `FilterCapturablePaymentsEvent` |
| `FILTER_VOIDABLE_PAYMENTS` | `commerce_payment_extra.filter_voidable_payments` | `FilterVoidablePaymentsEvent` |

Both event classes are thin `final` subclasses of the abstract `FilterPaymentsEvent`, which exposes:

- `getPayments(): PaymentInterface[]`
- `setPayments(array $payments): $this`
- `getOrder(): OrderInterface`

Subscribe to either event to add, remove, or re-order the candidate payments (e.g. exclude a specific
gateway, or include a payment the default capability check rejected).

## Default filter subscriber

`FilterPaymentsSubscriber` (service `commerce_payment_extra.filter_payments_subscriber`, **priority -200** so
it runs after most custom subscribers) rebuilds the payment list to keep only:

- **Capturable:** payments whose `$payment->getPaymentGateway()->getPlugin()` implements
  `SupportsAuthorizationsInterface` **and** returns true from `canCapturePayment($payment)`.
- **Voidable:** payments whose gateway plugin implements `SupportsVoidsInterface` **and** returns true from
  `canVoidPayment($payment)`.

Anything else is dropped from the returned array.

## Advanced Queue job types

Under `src/Plugin/AdvancedQueue/JobType/`. Both have `max_retries: 10` and `retry_delay: 3600` (one hour),
and are only discovered when the `advancedqueue` module is installed. They load the payment fresh from
storage by `payment_id`, then delegate to the gateway plugin.

### `commerce_payment_extra_capture` (`CapturePayment`)

Payload: `payment_id`, optional `amount` (a `Price::toArray()` array). If `amount` is an array it is rebuilt
with `Price::fromArray()`; if absent/invalid it defaults to the payment's full amount. Fails (no retry) if
the gateway does not implement `SupportsAuthorizationsInterface`. Calls `$plugin->capturePayment($payment,
$amount)`. `HardDeclineException` and `PaymentGatewayException` → `JobResult::failure(..., 0)` (no retry);
any other `\Exception` → retriable failure.

### `commerce_payment_extra_void` (`VoidPayment`)

Payload: `payment_id`. Fails (no retry) if the gateway does not implement `SupportsVoidsInterface`. Calls
`$plugin->voidPayment($payment)`. Same exception handling as capture.

## Notes for integrators

- Amounts are always computed by the enqueuing code (the submodule caps captures at the order balance), never
  taken from an end-user request.
- To enqueue manually, create an `advancedqueue\Job` of the matching type and push it onto any queue you like;
  the submodule ships a dedicated `commerce_payment_extra_order` queue.
