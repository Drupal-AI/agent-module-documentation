<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Recurring Log (commerce_recurring_log) — agent index

Records **subscription lifecycle events** as **Commerce Log** entries on the
`commerce_subscription` entity, and surfaces them on the subscription's admin display.
Zero configuration: enable it and logging starts for all subscriptions.

Depends on `commerce_recurring` and `commerce:commerce_log`. Version 1.0.7.
Core `^9.2 || ^10 || ^11 || ^12`. No routes, no permissions, no Drush commands, no
settings form.

## How it works

- Three **event subscribers** (`commerce_recurring_log.services.yml`) listen to
  Commerce Recurring / state_machine events and call the `commerce_log` log storage
  (`$entity_type.manager->getStorage('commerce_log')->generate(...)->save()`) to write
  a log entry against the subscription (or, for dunning, against the recurring order).
- Log **templates** and their **category** are declared in
  `commerce_recurring_log.commerce_log_categories.yml` (category `commerce_subscription`,
  entity type `commerce_subscription`) and
  `commerce_recurring_log.commerce_log_templates.yml`. Templates are Twig strings
  rendered (autoescaped) by Commerce Log.
- `hook_preprocess_commerce_subscription()` in `commerce_recurring_log.module` embeds
  the Commerce Log **`commerce_activity`** view (display `default`, arguments
  `[subscription id, 'commerce_subscription']`) into a "Subscription activity" fieldset
  in the rendered subscription's orders section.
- Ships its own view `commerce_recurring_activity` ("Subscriptions activity",
  base table `commerce_log`, default + block display) in
  `config/install/views.view.commerce_recurring_activity.yml`. This view is available for
  placement/reference; the module's preprocess embed uses Commerce Log's own
  `commerce_activity` view rather than this one.

## Events logged → template

- **State transition** — `SubscriptionSubscriber::onPostTransition` on
  `commerce_subscription.post_transition` → template `subscription_state_updated`
  (from/to state, transition label, acting user). Sets the log `uid` to the current user.
- **Payment declined (dunning)** — `DunningSubscriber::onPaymentDeclined` on
  `RecurringEvents::PAYMENT_DECLINED` → template `subscription_payment_declined`
  (logs retry_days / num_retries / max_retries / exception message as params; the
  template renders only a generic "payment was declined" message). Logged against the
  **order**.
- **Unit price change** — `SubscriptionLoggerSubscriber::onSubscriptionUpdate` on
  `RecurringEvents::SUBSCRIPTION_UPDATE` → template `subscription_amount_changed`
  (old/new amount + currency via `commerce_price.currency_formatter`, acting user).
- **Reactivation with immediate payment** —
  `SubscriptionLoggerSubscriber::onReactivateWithImmediatePayment` on the module's own
  `ReactivateWithImmediatePaymentEvent::REACTIVATE_WITH_IMMEDIATE_PAYMENT` →
  template `subscription_reactivate_with_immediate_payment`. This event is **defined but
  not dispatched by this module** (`src/Event/ReactivateWithImmediatePaymentEvent.php`);
  another module/patch must dispatch it for the log to be written.

For the full event/subscriber/template reference see
[api/events.md](api/events.md).

## Key facts

- `user_name` param resolves to the current user's **email** when authenticated, else the
  display name; on the first (`pending`) transition by an anonymous actor it falls back to
  the initial order's email. So log entries can contain customer email addresses (PII),
  shown to anyone who can view the subscription.
- Each subscriber wraps the save in try/catch and logs an `EntityStorageException` to the
  `commerce_recurring_log` logger channel rather than failing the transaction.
- `commerce_recurring_log.install` provides `hook_update_10001()` to install the shipped
  view config on existing sites.
- Activity log entries follow Commerce Log's access model, viewed in the subscription's
  admin display context.
