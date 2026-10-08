<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events (`Drupal\commerce_stripe\Event\StripeEvents`)

Subscribe with a tagged `event_subscriber` service.

| Constant | Event name | Event class | Use |
|---|---|---|---|
| `StripeEvents::PAYMENT_INTENT_CREATE` | `commerce_stripe.payment_intent.create` | `PaymentIntentCreateEvent` | Add/modify PaymentIntent **attributes and metadata** before the intent is created. |
| `StripeEvents::PAYMENT_INTENT_UPDATE` | `commerce_stripe.payment_intent.update` | `PaymentIntentUpdateEvent` | Modify PaymentIntent **metadata only** before update. |
| `StripeEvents::EXPRESS_CHECKOUT_SHIPPING_PROFILE_ALTER` | `commerce_stripe.express_checkout_shipping_profile_alter` | `ExpressCheckoutShippingProfileAlterEvent` | Alter the shipping profile created during express checkout. |

There is also a `PaymentMethodEvent` used internally when a payment method is created.

```php
use Drupal\commerce_stripe\Event\StripeEvents;
use Drupal\commerce_stripe\Event\PaymentIntentCreateEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyStripeSubscriber implements EventSubscriberInterface {
  public function onCreate(PaymentIntentCreateEvent $event): void {
    $intent = $event->getIntentAttributes();
    $intent['metadata']['my_ref'] = '123';
    $event->setIntentAttributes($intent);
  }
  public static function getSubscribedEvents(): array {
    return [StripeEvents::PAYMENT_INTENT_CREATE => ['onCreate']];
  }
}
```
