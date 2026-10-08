# Events (`AuthorizeNetEvents`)

The module dispatches six events so you can alter the data sent to / returned from
Authorize.Net without subclassing a gateway. Subscribe with a normal
`EventSubscriberInterface` service tagged `event_subscriber`.

| Constant | Event name | Event class | Lets you alter |
|---|---|---|---|
| `CREATE_TRANSACTION_REQUEST` | `commerce_authnet.transaction_request.create` | `TransactionRequestEvent` | The charge/authorize request before it is sent |
| `REFUND_TRANSACTION_REQUEST` | `commerce_authnet.transaction_request.refund` | `TransactionRequestEvent` | The refund request |
| `VOID_TRANSACTION_REQUEST` | `commerce_authnet.transaction_request.void` | `TransactionRequestEvent` | The void request |
| `CREATE_PAYMENT_PROFILE` | `commerce_authnet.payment_profile.create` | `PaymentProfileEvent` | Customer payment profile on create |
| `UPDATE_PAYMENT_PROFILE` | `commerce_authnet.payment_profile.update` | `PaymentProfileEvent` | Customer payment profile on update |
| `HOSTED_PAYMENT_SETTINGS` | `commerce_authnet.hosted_payment_settings.create` | `HostedPaymentSettingsEvent` | Accept Hosted iframe/page settings |

Example subscriber skeleton:

```php
use Drupal\commerce_authnet\Event\AuthorizeNetEvents;
use Drupal\commerce_authnet\Event\TransactionRequestEvent;

class MySubscriber implements \Symfony\Component\EventDispatcher\EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [AuthorizeNetEvents::CREATE_TRANSACTION_REQUEST => 'onCreate'];
  }
  public function onCreate(TransactionRequestEvent $event): void {
    $transaction = $event->getTransaction(); // commerceguys/authnet request object
    // e.g. add a line item, PO number, duty/tax, or customer data.
  }
}
```

Other developer surfaces: the `commerce_authnet.echeck_transaction_verifier` service
(`EcheckTransactionVerifier`) polls eCheck settlement status; the
`commerce_authnet.iframe_communicator` route serves the Accept Hosted iframe communicator page.
Requests are built and sent through the `commerceguys/authnet` PHP library.
