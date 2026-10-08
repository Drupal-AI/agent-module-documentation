<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Recurring adds subscriptions and recurring billing to Drupal Commerce: you define reusable billing schedules (fixed or rolling intervals, with optional trials and proration), and the module creates and renews recurring orders for each subscription automatically via cron and a queue.

---

The module introduces two core concepts. A **billing schedule** is a `commerce_billing_schedule` config entity that describes when and how a subscription is billed: a billing type (`prepaid` or `postpaid`), a schedule plugin (`fixed` — aligned calendar intervals with a start month/day, or `rolling` — intervals counted from the subscription's start), an interval (number + unit of day/week/month/year), an optional trial interval, a **prorater** plugin (`proportional` or `full_price`) for partial periods, a dunning **retry schedule** (default `[1, 3, 5]` days) and the **unpaid subscription state** to fall back to (default `canceled`), plus a `combineSubscriptions` flag. A **subscription** is a `commerce_subscription` content entity whose bundle is a **subscription type** plugin (`product_variation` for subscriptions tied to a purchasable product variation, or `standalone`); it references a store, customer, payment method, billing schedule, unit price, and moves through a `state_machine` workflow (`pending → trial → active → expired/canceled`). Purchasing is wired via a `recurring` order type and `recurring_product_variation` / `recurring_standalone` order-item types, and an `InitialOrderProcessor` on the cart. The `RecurringOrderManager` service starts trials, opens recurring orders, refreshes, closes and renews them; `commerce_recurring_cron()` queues closing/renewal work into the `commerce_recurring` Advanced Queue, whose jobs (`recurring_order_close`, `recurring_order_renew`, `subscription_activate`) run on cron. Failed payments raise a `PaymentDeclined` event and dunning email, then apply the retry schedule before canceling/expiring. The module defines three plugin types (billing schedule, subscription type, prorater) so all of this is extensible.

---

- Sell a monthly or yearly subscription tied to a product variation (SaaS plan, membership).
- Offer a free trial period before the first charge using a billing schedule's trial interval.
- Bill on a fixed calendar cycle (e.g. always on the 1st of the month) with the `fixed` schedule plugin.
- Bill on a rolling cycle counted from each customer's signup date with the `rolling` plugin.
- Charge subscriptions in advance (`prepaid`) or after the period (`postpaid`).
- Prorate the first/last partial period proportionally, or always charge full price.
- Automatically create and place recurring orders for due subscriptions via cron.
- Retry declined subscription payments on a dunning schedule (e.g. days 1, 3, 5) before canceling.
- Send an automated "payment declined" dunning email to customers on a failed renewal.
- Cancel or expire a subscription automatically after all payment retries are exhausted.
- Let customers view and manage their subscriptions and recurring orders from their account.
- Combine multiple subscriptions on the same schedule into a single recurring order.
- Model standalone subscriptions not backed by a catalog product (`standalone` type).
- Programmatically start a trial or begin recurring billing with the `RecurringOrderManager` service.
- Schedule a change to a subscription (e.g. plan switch) applied at the next billing period.
- Set a subscription's next renewal date and drive renewals from it.
- Provide site builders a Subscriptions admin UI and billing-schedule configuration screens.
- Grant staff granular permissions to administer billing schedules, subscriptions, and subscription types.
- Build a custom billing schedule plugin for an unusual cadence (e.g. quarterly with a grace period).
- Build a custom prorater plugin implementing bespoke proportional pricing rules.
- Build a custom subscription type plugin to add fields or behavior to subscriptions.
- Track a subscription's initial (non-recurring) order that started it.
- Expose subscription orders and lifecycle via the shipped Views (customer + admin listings).
- React to subscription lifecycle events (create/insert/update/delete, payment declined) with an event subscriber.
- Process recurring order close/renew and subscription activation asynchronously through Advanced Queue jobs.
- Show billing period and scheduled-change information with the module's field formatters.
- Sell memberships that automatically renew until the customer cancels.
- Offer paid access that lapses to a defined unpaid state when billing fails.
