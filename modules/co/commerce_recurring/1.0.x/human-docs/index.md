# Commerce Recurring — manual setup guide

**Commerce Recurring** (`commerce_recurring`) adds subscriptions and recurring
billing to Drupal Commerce. You define reusable **billing schedules** — the "when
and how" of billing, such as *monthly, prepaid, with a 14-day trial* — and the
module creates a **subscription** for each customer and automatically generates and
renews their recurring orders on a schedule, driven by cron and a background queue.
It's what you reach for to sell SaaS plans, memberships, or any product that should
renew until the customer cancels.

Two ideas sit at the center of it. A **billing schedule** is a configuration entity
describing the cadence: a billing type (**prepaid** — charge for the coming period,
or **postpaid** — charge for the elapsed one), a schedule style (**fixed** —
aligned to a calendar anchor like "always the 1st of the month", or **rolling** —
counted from each customer's own start date), an interval, an optional trial, a
proration rule for partial periods, and a dunning retry schedule for failed
payments. A **subscription** is a content entity for one customer's ongoing plan; it
moves through a lifecycle (`pending → trial → active → expired/canceled`) and can be
tied to a purchasable product variation or stand alone.

The heavy lifting happens automatically: cron finds subscriptions that are due and
queues jobs (via Advanced Queue) to close and renew their orders, retry declined
payments on your dunning schedule, and send a "payment declined" email before
finally moving an unpaid subscription to a defined state. Because billing
schedules, subscription types, and proraters are all plugins, developers can extend
every part of it. Note that renewals depend on **cron running** and the queue being
processed — there are no Drush commands for it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (several Commerce
   and queue dependencies) and enable it.
2. [Configuration](configuration/index.md) — create billing schedules, wire a
   product to subscriptions, permissions, and how the renewal cycle runs.

## Where it lives in the admin menu

The subscriptions hub is at **Commerce → Configuration → Subscriptions**
(`/admin/commerce/config/subscriptions`), and billing schedules are managed at
**Commerce → Configuration → Billing schedules**
(`/admin/commerce/config/billing-schedules`).

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Create at least one **billing schedule** (e.g. "Monthly", rolling, prepaid) —
   see [Configuration](configuration/index.md).
3. On a product variation type, enable subscriptions and pick a subscription type
   and billing schedule, so buying that product starts a subscription.
4. Make sure **cron runs regularly** and the Advanced Queue is processed — that's
   what actually closes and renews orders and drives dunning.
5. Customers can then view and manage their subscriptions from their account, and
   staff administer them through the Subscriptions UI.
