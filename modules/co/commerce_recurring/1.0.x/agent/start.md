<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Recurring — agent index

Adds **subscriptions** and **recurring billing** to Drupal Commerce. Two entities drive it:
a **billing schedule** config entity (`commerce_billing_schedule`) that describes the cadence,
and a **subscription** content entity (`commerce_subscription`) whose bundle is a subscription
type plugin. Recurring orders are generated and renewed by cron + an Advanced Queue.

Depends on `commerce`, `commerce_order`, `commerce_price`, `commerce_payment`, `state_machine`,
`advancedqueue`. Configure hub: `/admin/commerce/config/subscriptions`
(route `commerce_recurring.configuration`). Billing schedules:
`/admin/commerce/config/billing-schedules`.

- **Create/configure billing schedules (fixed vs rolling, interval, trial, prorater, dunning retry, billing type)** →
  [configure/billing-schedules.md](configure/billing-schedules.md)
- **The three plugin types and how to implement one (billing schedule / subscription type / prorater)** →
  [plugins/plugin-types.md](plugins/plugin-types.md)
- **Subscription entity + lifecycle: RecurringOrderManager, workflow states, cron, queue jobs, events** →
  [api/subscriptions.md](api/subscriptions.md)
- **Permissions the module defines** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Billing schedule plugins: `fixed` (calendar-aligned; adds `start_month`/`start_day`) and
  `rolling` (counted from subscription start). Both take `interval` and optional `trial_interval`
  (`number` + `unit` ∈ day/week/month/year).
- Prorater plugins: `proportional` and `full_price`. Subscription type plugins:
  `product_variation` and `standalone`.
- Billing types: `prepaid` (default) / `postpaid`. Dunning `retrySchedule` default `[1,3,5]`;
  `unpaidSubscriptionState` default `canceled`.
- Subscription workflow `subscription_default`: `pending → trial → active → expired/canceled`.
  Recurring order workflow `order_recurring`: `draft → needs_payment → completed/failed/canceled`.
- No Drush commands. Renewals run through `commerce_recurring_cron()` → `commerce_recurring`
  Advanced Queue (jobs `recurring_order_close`, `recurring_order_renew`, `subscription_activate`).
