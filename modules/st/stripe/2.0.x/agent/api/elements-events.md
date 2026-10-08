# Form elements, webhook, events

## Form API render elements

Both extend `StripeBase`, which creates a Stripe **PaymentIntent** server-side and drives
client-side confirmation with Stripe.js.

- **`stripe`** (class `Element\CC`) — a card input element.
- **`stripe_paymentrequest`** (class `Element\PaymentRequest`) — a Payment Request button
  (Apple Pay / Google Pay / browser-saved cards).

Use in a form like any element:

```php
$form['card'] = [
  '#type' => 'stripe',            // or 'stripe_paymentrequest'
  '#title' => $this->t('Payment'),
  // StripeBase handles the PaymentIntent + client secret; the confirmed
  // payment_intent id arrives in the submitted value.
];
```

The element stores the PaymentIntent id in form state (`stripe_paymentintent`) and exposes the
confirmed `payment_intent` in `$element['#value']`. See the `stripe_examples` submodule's
`SimpleCheckoutForm` for a complete working example.

## Webhook endpoint

- Route `stripe_api.webhook` → **`POST /stripe/webhook`** (controller
  `StripeWebhookController::handle`, `no_cache`, `_access: TRUE`).
- It sets the API key from `stripe.settings`, then:
  - if a webhook signing secret is configured, verifies the signature with
    `\Stripe\Webhook::constructEvent($payload, $sig, $secret)`;
  - otherwise reconstructs the event (live: `Event::retrieve($id)`; test:
    `Event::constructFrom($data)`).
- On success it dispatches a `StripeWebhookEvent` under `StripeEvents::WEBHOOK`.

## Events (`StripeEvents`)

| Constant | Name | Payload | Use |
|---|---|---|---|
| `StripeEvents::WEBHOOK` | `stripe.webhook` | `StripeWebhookEvent` (carries the Stripe `Event`) | react to incoming webhooks (fulfil orders, update roles) |
| `StripeEvents::PAYMENT` | `stripe.payment` | `StripePaymentEvent` (`getForm()`, `setTotal($amount, $label)`) | adjust amount/metadata before a payment is confirmed |

Subscribe to these to add behaviour — see
[../extend/event-subscriber.md](../extend/event-subscriber.md).
