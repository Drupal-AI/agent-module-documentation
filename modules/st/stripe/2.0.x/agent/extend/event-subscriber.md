# Reacting to Stripe payments & webhooks

Stripe exposes two Symfony events (no hooks). Subscribe with a normal event subscriber service.

## Service registration (`my_module.services.yml`)

```yaml
services:
  my_module.stripe_subscriber:
    class: Drupal\my_module\EventSubscriber\MyStripeSubscriber
    tags:
      - { name: event_subscriber }
```

## Adjust the amount before confirmation (`StripeEvents::PAYMENT`)

```php
use Drupal\stripe\Event\StripeEvents;
use Drupal\stripe\Event\StripePaymentEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyStripeSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [StripeEvents::PAYMENT => 'updatePayment'];
  }
  public function updatePayment(StripePaymentEvent $event) {
    $form = $event->getForm();
    if ($form['#form_id'] === 'my_checkout_form') {
      $event->setTotal(2500, 'My order');   // amount in the smallest currency unit (e.g. cents)
    }
  }
}
```

(This mirrors `stripe_examples`' `StripeExamplesEventSubscriber`, which sets a fixed 2500 total
for its `stripe_examples_simple_checkout` form.)

## Handle a webhook (`StripeEvents::WEBHOOK`)

```php
use Drupal\stripe\Event\StripeEvents;
use Drupal\stripe\Event\StripeWebhookEvent;

// in getSubscribedEvents():
return [StripeEvents::WEBHOOK => 'onWebhook'];

public function onWebhook(StripeWebhookEvent $event) {
  $stripe_event = $event->getEvent();          // \Stripe\Event
  if ($stripe_event->type === 'payment_intent.succeeded') {
    $intent = $stripe_event->data->object;     // \Stripe\PaymentIntent
    // fulfil the order, grant a role, send a receipt, …
  }
}
```

The webhook is delivered to `POST /stripe/webhook`; configure that URL (and its signing
secret) in your Stripe dashboard and in `stripe.settings`.
