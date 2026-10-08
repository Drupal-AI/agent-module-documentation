# Commerce Braintree — transaction data event

One event lets you add data/metadata to the Braintree **sale** request before it is sent.

## Event

- Constant: `\Drupal\commerce_braintree\Event\BraintreeEvents::TRANSACTION_DATA`
  = `'commerce_braintree.transaction_data'`.
- Object: `\Drupal\commerce_braintree\Event\TransactionDataEvent`
  — `getTransactionData()` / `setTransactionData(array)` and `getPayment()`.
- Dispatched in `HostedFields::createPayment()` just before `$this->api->transaction()->sale($data)`,
  after the module has assembled `channel`, `merchantAccountId`, `orderId`, `amount`, `options`, and
  (if present) `paymentMethodToken`/`paymentMethodNonce` and shipping address.

## Subscriber example

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\commerce_braintree\Event\BraintreeEvents;
use Drupal\commerce_braintree\Event\TransactionDataEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class BraintreeTransactionSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [BraintreeEvents::TRANSACTION_DATA => 'onTransactionData'];
  }

  public function onTransactionData(TransactionDataEvent $event): void {
    $data = $event->getTransactionData();
    $payment = $event->getPayment();
    // e.g. attach custom fields / descriptor / line items understood by Braintree:
    $data['customFields']['drupal_order'] = $payment->getOrderId();
    $event->setTransactionData($data);
  }
}
```

Register it as a tagged `event_subscriber` service. The array shape must follow Braintree's
`transaction()->sale()` request format (see the Braintree PHP SDK docs referenced in `BraintreeEvents`).
