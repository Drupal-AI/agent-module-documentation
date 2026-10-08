<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events, subscribers & log templates

All logging is driven by three event subscribers registered in
`commerce_recurring_log.services.yml`, each injected with `@entity_type.manager` (and the
price-change one also `@commerce_price.currency_formatter`). Each subscriber obtains
`getStorage('commerce_log')` and writes entries with
`->generate($source_entity, $template_id, $params)->save()`.

## Log category & templates

`commerce_recurring_log.commerce_log_categories.yml`:

```yaml
commerce_subscription:
  label: Subscription
  entity_type: commerce_subscription
```

`commerce_recurring_log.commerce_log_templates.yml` (Twig strings, autoescaped by
Commerce Log; no `|raw`):

| Template id | Category | Params referenced in template |
| --- | --- | --- |
| `subscription_state_updated` | commerce_subscription | `from_state`, `to_state`, `transition_label`, `user_name` |
| `subscription_payment_declined` | commerce_subscription | *(none rendered — generic message)* |
| `subscription_amount_changed` | commerce_subscription | `old_amount`, `old_currency_code`, `new_amount`, `new_currency_code`, `user_name` |
| `subscription_reactivate_with_immediate_payment` | commerce_subscription | `user_name` |

## Subscribers

### SubscriptionSubscriber
`src/EventSubscriber/SubscriptionSubscriber.php`. Listens to
`commerce_subscription.post_transition` (a `state_machine` `WorkflowTransitionEvent`,
priority 100).

`onPostTransition()` reads the transition, the entity, and the workflow's original state.
It resolves `user_name` to the current user's email (authenticated) or display name;
if the actor is anonymous **and** the original state is `pending`, it uses the initial
order's email (the customer who placed the order). It generates a
`subscription_state_updated` log against the subscription, explicitly sets the log `uid`
to the current user id, and saves.

### DunningSubscriber
`src/EventSubscriber/DunningSubscriber.php`. Listens to
`RecurringEvents::PAYMENT_DECLINED` (`commerce_recurring.payment_declined`, priority 100).

`onPaymentDeclined()` logs `subscription_payment_declined` against the **order**
(`$event->getOrder()`) with params `retry_days`, `num_retries`, `max_retries`, and the
exception message (or NULL) from the `PaymentDeclinedEvent`. Only a generic message is
rendered; the numeric/exception params are stored but not displayed.

### SubscriptionLoggerSubscriber
`src/EventSubscriber/SubscriptionLoggerSubscriber.php`. Two handlers (priority 100):

- `RecurringEvents::SUBSCRIPTION_UPDATE` (`commerce_recurring.commerce_subscription.update`)
  → `onSubscriptionUpdate()`. Compares `$subscription->original` unit price to the new one;
  when the number or currency differs, logs `subscription_amount_changed` with both amounts
  formatted via the currency formatter (`currency_display => none`), their currency codes,
  and `user_name`. Returns early if `$subscription->original` is not set.
- `ReactivateWithImmediatePaymentEvent::REACTIVATE_WITH_IMMEDIATE_PAYMENT`
  (`commerce_recurring_log.reactivate_with_immediate_payment`) →
  `onReactivateWithImmediatePayment()`. Logs
  `subscription_reactivate_with_immediate_payment` with `user_name`.

## The custom event (not dispatched here)

`src/Event/ReactivateWithImmediatePaymentEvent.php` defines the event class and its
constant `REACTIVATE_WITH_IMMEDIATE_PAYMENT`, carrying the subscription
(`getSubscription()`). This module only **subscribes** to it — nothing in
`commerce_recurring_log` dispatches it. To have reactivation-with-immediate-payment logged,
another module or a `commerce_recurring` patch (see the origin issue
[#3281646](https://www.drupal.org/project/commerce_recurring/issues/3281646)) must
dispatch this event.

## Display

`commerce_recurring_log.module` `hook_preprocess_commerce_subscription()` appends a
"Subscription activity" fieldset containing an embedded Commerce Log `commerce_activity`
view (arguments: subscription id, `commerce_subscription`) to the rendered subscription's
orders section, so the activity trail appears on the subscription's admin display.
