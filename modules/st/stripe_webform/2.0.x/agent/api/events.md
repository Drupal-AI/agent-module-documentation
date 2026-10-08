# Events: payment feed + webhook dispatch

Source: `src/EventSubscriber/StripeWebformEventSubscriber.php` (subscribes to the base **`stripe`**
module's events), plus `src/Event/*` and `stripe_webform.rules.events.yml`.

## Subscribed to (from drupal/stripe)

| Event | Handler | What it does |
|---|---|---|
| `StripeEvents::PAYMENT` | `handleStripePayment` | When the form object is a `WebformSubmissionForm`, copies form values to the submission, resolves the Stripe element, and feeds `#stripe_amount`/`#stripe_label`/billing fields into the PaymentIntent via `$event->setTotal()`, `setBillingName()`, etc. |
| `StripeEvents::WEBHOOK` | `handleStripeWebhook` | Fires for every Stripe webhook the base module receives (after that module has **verified the Stripe signature**). |

## Webhook handling (`handleStripeWebhook`)

1. Reads the Stripe event object. Looks for `data.object.metadata.webform_submission_id`; if absent but a
   `customer` is present, retrieves the Customer and reads its metadata.
2. **Site guard:** proceeds only if `metadata.uuid` equals this site's `system.site` uuid — so one
   Stripe account serving multiple Drupal sites won't cross-fire.
3. Loads the referenced `webform_submission`; if found, dispatches a `StripeWebformWebhookEvent`
   (`stripe_webform.webhook`) carrying `type`, the `webform_submission`, and the raw Stripe event.

> Signature verification is NOT done here — it is the base `stripe` module's webhook controller that
> validates the Stripe-Signature header before firing `StripeEvents::WEBHOOK`. This module trusts that
> event and adds only the site-uuid + submission matching.

## The `stripe_webform.webhook` event

- Class `\Drupal\stripe_webform\Event\StripeWebformWebhookEvent` (const `EVENT_NAME =
  'stripe_webform.webhook'`), constructor `(string $type, WebformSubmissionInterface $webform_submission,
  StripeEvent $event)`.
- Also declared as a **Rules event** (`stripe_webform.rules.events.yml`) with context `type` (string) and
  `webform_submission` (entity) — so site builders can react in Rules (e.g. on `invoice.paid`).

### Subscribe from custom code

```php
// your_module.services.yml → tagged event_subscriber
public static function getSubscribedEvents(): array {
  return [\Drupal\stripe_webform\Event\StripeWebformWebhookEvent::EVENT_NAME => 'onWebhook'];
}
public function onWebhook(\Drupal\stripe_webform\Event\StripeWebformWebhookEvent $event): void {
  if ($event->type === 'invoice.paid') { /* $event->webform_submission ... */ }
}
```
