# The example checkout flow

All of this is demonstration code for the parent `stripe` module — copy the patterns into your
own module.

## Form

- `SimpleCheckoutForm`, form id `stripe_examples_simple_checkout`, route
  `stripe_examples.stripe_examples_simple_checkout` → **`/stripe_examples/form/simple_checkout`**
  (`_access: TRUE`).
- It embeds a Stripe payment element (`#type => 'stripe'`) and relies on `StripeBase` to create
  a PaymentIntent and confirm it client-side via Stripe.js.
- Rendered through the Twig template `stripe-examples-simple-checkout.html.twig`
  (theme hook `stripe-examples-simple-checkout`) with the module's own CSS/JS library.

## Block

- `SimpleCheckoutBlock`, block plugin id **`stripe_example_checkout`** — renders the checkout
  form so you can place it in any theme region via Block layout.

## Amount via the PAYMENT event

`StripeExamplesEventSubscriber` (service tagged `event_subscriber`):

```php
public static function getSubscribedEvents(): array {
  return [StripeEvents::PAYMENT => 'updatePayment'];
}
public function updatePayment(StripePaymentEvent $event) {
  $form = $event->getForm();
  if ($form['#form_id'] == 'stripe_examples_simple_checkout') {
    $event->setTotal(2500, 'StripeExamplesEventSubscriber');   // 2500 = smallest currency unit
  }
}
```

This shows the canonical way to control the charge amount server-side (see the parent module's
[extend/event-subscriber.md](../../../../2.0.x/agent/extend/event-subscriber.md)).

## Try it

1. Enable `stripe_examples` and set **test** keys in `stripe.settings`.
2. Visit `/stripe_examples/form/simple_checkout` (or place the `stripe_example_checkout` block).
3. Complete a test payment; watch the PaymentIntent get created and confirmed, and the
   `StripeEvents::WEBHOOK` event fire if you configure the webhook.
