<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Altering API requests/responses via `ModelEvent`

The module provides **no Drupal hooks**. Instead, every Paytrail SDK request/response model is
passed through a single event so you can alter it.

## The event

`Drupal\commerce_paytrail\Event\ModelEvent` (extends `Component\EventDispatcher\Event`):

```php
final class ModelEvent extends Event {
  public function __construct(
    public mixed $model,               // the SDK request or response object
    public ?OrderInterface $order = NULL,
    public ?string $event = NULL,      // one of the constants below
  ) {}
}
```

Subscribe to `ModelEvent::class` and branch on `$event->event`. Mutate `$event->model` in place
(it is the live SDK request/response). Example (from README):

```php
public function processEvent(\Drupal\commerce_paytrail\Event\ModelEvent $event): void {
  if ($event->event === PaymentRequestBuilderInterface::PAYMENT_CREATE_EVENT) {
    // $event->model is the PaymentRequest; adjust it.
  }
}
public static function getSubscribedEvents(): array {
  return [\Drupal\commerce_paytrail\Event\ModelEvent::class => ['processEvent']];
}
```

> Note: the reference (`order->id()`) is set on the payment request **after** the create event
> dispatches, so subscribers cannot change which order a payment binds to.

## Event name constants

Payment (`RequestBuilder\PaymentRequestBuilderInterface`):
- `PAYMENT_CREATE_EVENT` = `payment_create` — before creating a payment.
- `PAYMENT_CREATE_RESPONSE_EVENT` = `payment_create_response`.
- `PAYMENT_GET_RESPONSE_EVENT` = `payment_get_response` — after fetching payment status.

Refund (`RequestBuilder\RefundRequestBuilderInterface`):
- `REFUND_CREATE` / `REFUND_CREATE_RESPONSE`.

Token (`RequestBuilder\TokenRequestBuilderInterface`):
- `TOKEN_ADD_CARD_FORM_EVENT` = `token_payment_add_card_form`
- `TOKEN_GET_CARD_EVENT` / `TOKEN_GET_CARD_RESPONSE_EVENT`
- `TOKEN_COMMIT_EVENT` / `TOKEN_COMMIT_RESPONSE_EVENT`
- `TOKEN_MIT_AUTHORIZE_EVENT` / `TOKEN_MIT_AUTHORIZE_RESPONSE_EVENT`
- `TOKEN_MIT_CHARGE_EVENT` / `TOKEN_MIT_CHARGE_RESPONSE_EVENT`
- `TOKEN_REVERT_RESPONSE_EVENT`

## Built-in subscribers (for reference)

- `BillingInformationCollector` — adds billing name + invoicing address when
  `collect_billing_information` is on.
- `ShippingEventSubscriber` — adds shipment line items; registered only when `commerce_shipping`
  is installed.

Both extend `PaymentRequestSubscriberBase`, whose `isValid()` guards that the model is a
`PaymentRequestInterface` and the order resolves to a Paytrail gateway.
