<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events

The module dispatches one Symfony event so other modules can alter the order
payload before it is sent to Revolut.

## `revolut_order_payload` — RevolutEvents::REVOLUT_ORDER_PAYLOAD

- Constant: `Drupal\commerce_revolut\Event\RevolutEvents::REVOLUT_ORDER_PAYLOAD`
  (value `'revolut_order_payload'`).
- Event object: `Drupal\commerce_revolut\Event\RevolutOrderEvent`.
- Dispatched at the end of `RevolutTrait::buildOrderPayload()`, i.e. immediately
  before the payload is POSTed (`createRevolutOrder`) or PATCHed
  (`updateRevolutOrder`) to `/orders`. The dispatcher uses the returned payload
  (`$event->getPayload()`), so a subscriber can fully rewrite it.

### RevolutOrderEvent API

- `getOrder(): OrderInterface` — the Commerce order being sent.
- `getPayload(): array` — the current Revolut order payload (amount, currency,
  `line_items`, `merchant_order_data.reference`, customer, `capture_mode`, …).
- `setPayload(array $payload): self` — replace it.

### Example subscriber

```php
use Drupal\commerce_revolut\Event\RevolutEvents;
use Drupal\commerce_revolut\Event\RevolutOrderEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyRevolutSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [RevolutEvents::REVOLUT_ORDER_PAYLOAD => 'onPayload'];
  }

  public function onPayload(RevolutOrderEvent $event): void {
    $payload = $event->getPayload();
    // e.g. add shipping / metadata expected by your Revolut account.
    $payload['merchant_order_data']['reference'] = 'store-' . $event->getOrder()->id();
    $event->setPayload($payload);
  }

}
```

No `*.api.php` file ships with the module; this event is the module's extension
point.
