# Events (integration surface)

To take payment from your own module: create a `mollie_payment` with your module's machine name as
`context` and your entity id as `context_id` (see [api/payments.md](../api/payments.md)), send the
customer to the checkout URL, then subscribe to these events and filter on `getContext()`. Each
event carries the `context` / `context_id` you set; the transaction events also carry the
API-loaded `mollie_payment` entity.

| Event constant (`EVENT_NAME`) | Class | Dispatched when |
|---|---|---|
| `mollie.redirect_event` | `MollieRedirectEvent` | Customer returns via the `mollie.redirect` route after paying. |
| `mollie.transaction_event.status_change` | `MollieTransactionStatusChangeEvent` | Status webhook fires (`mollie.webhook.status_change`). |
| `mollie.transaction_event.refund` | `MollieTransactionRefundEvent` | Aftercare webhook detects a new refund (experimental). |
| `mollie.transaction_event.chargeback` | `MollieTransactionChargebackEvent` | Aftercare webhook detects a new chargeback (experimental). |
| `mollie.notification_event` | `MollieNotificationEvent` | **Deprecated** (2.1.0), removed in 3.0.0 — use the status-change/refund/chargeback events. |

## Event API

- `MollieEventBase`: `getContext()`, `getContextId()`.
- `MollieRedirectEvent` (extends base): `setRedirectUrl(\Drupal\Core\Url $url)`,
  `getRedirectUrl()` — set where the customer lands after payment; default is the payments
  collection.
- `MollieTransactionEventBase` (base for the three transaction events): `getTransaction()` returns
  the `mollie_payment` `TransactionInterface` (use `getStatus()` — compare to
  `Mollie\Api\Types\PaymentStatus` constants — `getAmount()`, `getCurrency()`, etc., all read from
  the Mollie API), `setHttpStatusCode(int)` / `getHttpStatusCode()` — the code returned to Mollie
  (set `200` on success; a non-200 tells Mollie to retry).

## Example subscriber

```yaml
# my_module.services.yml
services:
  my_module.mollie_subscriber:
    class: Drupal\my_module\EventSubscriber\MyMollieSubscriber
    tags:
      - { name: event_subscriber }
```

```php
use Drupal\mollie\Events\MollieTransactionStatusChangeEvent;
use Mollie\Api\Types\PaymentStatus;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyMollieSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [MollieTransactionStatusChangeEvent::EVENT_NAME => 'onStatusChange'];
  }

  public function onStatusChange(MollieTransactionStatusChangeEvent $event): void {
    if ($event->getContext() !== 'my_module') {
      return; // Not our payment.
    }
    $transaction = $event->getTransaction();
    if ($transaction->getStatus() === PaymentStatus::STATUS_PAID) {
      // Fulfil order $event->getContextId(); amount/status come from Mollie.
    }
    $event->setHttpStatusCode(200);
  }

}
```

`mollie_commerce` and `mollie_webform` are reference implementations: `mollie_commerce` subscribes
to the status-change event with context `mollie_commerce` and forwards to Commerce's
`commerce_payment.notify`; `mollie_webform` uses context `mollie_webform`.
