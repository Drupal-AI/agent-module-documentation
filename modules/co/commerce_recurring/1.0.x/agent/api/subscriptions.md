<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscriptions, lifecycle, cron & queue

## The subscription entity

`commerce_subscription` is a **content entity** (bundle = a subscription type plugin id, e.g.
`product_variation` or `standalone`). Load/create via the entity type manager; storage class is
`SubscriptionStorage`. Key base fields (see `Subscription::baseFieldDefinitions()`):

`store_id`, `billing_schedule` (→ `commerce_billing_schedule`), `uid` (customer),
`payment_method`, `purchased_entity` (for `product_variation`), `title`, `quantity`,
`unit_price` (`commerce_price`), `state` (`state` field, workflow `subscription_default`),
`initial_order` (the non-recurring order that started it), `orders` (recurring orders),
`next_renewal`, `renewed`, `trial_starts`, `trial_ends`, `starts`, `ends`, `scheduled_changes`.

`SubscriptionInterface` accessors include `getBillingSchedule()`, `getState()`, `setState()`,
`getCurrentOrder()`, `getOrders()`, `getNextRenewalTime()/Date()`, `getTrialStartTime()`,
`getInitialOrder()`, `getPurchasedEntity()`, `getType()` (the subscription type plugin).

## Workflows (state_machine)

- **Subscription** (`subscription_default`, group `commerce_subscription`): states
  `pending`, `trial`, `active`, `expired`, `canceled`; transitions `activate`
  (pending/trial → active), `expire` (active → expired), `cancel` (trial/active → canceled).
- **Recurring order** (`order_recurring`, group `commerce_order`): states `draft`,
  `needs_payment`, `failed`, `completed`, `canceled`; transitions `place`, `mark_paid`,
  `mark_failed`, `cancel`.

## RecurringOrderManager service

`commerce_recurring.order_manager` (`RecurringOrderManagerInterface`) is the programmatic entry
point for the billing cycle:

```php
$mgr = \Drupal::service('commerce_recurring.order_manager');
$mgr->startTrial($subscription);        // begin a trial period
$mgr->startRecurring($subscription);    // open the first recurring order
$mgr->refreshOrder($order);             // recollect charges onto a recurring order
$mgr->closeOrder($order);               // place + attempt payment at period end
$mgr->renewOrder($order);               // create the next period's order
$mgr->collectSubscriptions($order);     // subscriptions on a recurring order
```

## Cron and the Advanced Queue

`commerce_recurring_cron()` finds subscriptions/orders due and enqueues jobs into the
`commerce_recurring` Advanced Queue (database backend, `processor: cron`, `processing_time: 180`,
`locked: true`). Job type plugins (`Plugin/AdvancedQueue/JobType/`):

- `recurring_order_close` — close (place + charge) a recurring order whose period ended.
- `recurring_order_renew` — create the next recurring order.
- `subscription_activate` — activate a subscription (e.g. when a trial ends).

So renewals require **cron to run** (and the advancedqueue processor). There are no Drush commands.

## Order processors (cart/checkout)

- `commerce_recurring.initial_order_processor` (priority 40, adjustment_type `subscription`) —
  turns a subscribable product in the cart into the subscription's initial order.
- `commerce_recurring.recurring_order_processor` (priority 300) — keeps recurring orders in sync.

## Dunning & events

On a declined renewal payment the `DunningSubscriber` sends the `PaymentDeclinedMail` and the
billing schedule's `retrySchedule` (default `[1,3,5]` days) governs retries; once exhausted the
subscription moves to `unpaidSubscriptionState` (default `canceled`).

Events (`RecurringEvents` constants) you can subscribe to: `PAYMENT_DECLINED`
(`commerce_recurring.payment_declined`) and the subscription CRUD events
`SUBSCRIPTION_LOAD/CREATE/PRESAVE/INSERT/UPDATE/PREDELETE/DELETE`
(`commerce_recurring.commerce_subscription.<op>`). The `PaymentDeclinedEvent` and
`SubscriptionEvent` classes carry the relevant entity.
