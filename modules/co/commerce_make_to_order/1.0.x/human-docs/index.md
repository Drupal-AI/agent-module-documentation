# Commerce Make-to-Order — manual setup guide

**Commerce Make-to-Order** (`commerce_make_to_order`) adds a **production
workflow** to Drupal Commerce for stores that manufacture, craft, or assemble
products *after* the customer buys them — custom furniture, handmade goods,
fashion ateliers, print-on-demand, and the like. Instead of shipping from stock,
each order item becomes a **production order** that your team tracks from queue to
quality check to completion, and the parent Commerce order follows along
automatically.

At its heart is a dedicated **MTO order entity** with a configurable
[State Machine](https://www.drupal.org/project/state_machine) production workflow
(Draft, Queued, Waiting for Materials, In Production, Quality Check, Rework,
Completed, Canceled). When a Commerce order reaches a state you choose, the module
automatically creates one production order per order item, numbers it via a
Commerce Number Pattern (for example `MTO-2026-00001`), and lets your team assign
it to people, set priorities and due dates, add internal/transition/team notes
(optionally emailing them), and watch an activity-log timeline with full state
history. A production analytics area reports on bottlenecks, team performance,
materials wait time, QC metrics, on-time delivery, and throughput.

This module **needs configuration before it does anything useful** — you set up at
least one MTO order type that ties the production workflow, number pattern,
trigger state, and completion behaviour together. It depends on core **User**,
Drupal Commerce (**Order**, **Number Pattern**, and **Log**), and the **State
Machine** module. Optionally, **Commerce Shipping** unlocks a second integration
mode where production orders link to the checkout shipment. Note that this module
is **not covered by Drupal's security advisory policy**, so treat it accordingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — set up MTO order types and grant the
   right permissions to your production team.

## Where it lives in the admin menu

Once enabled and configured, Commerce Make-to-Order lives entirely under the
Commerce section:

- **MTO order types** (settings): **Commerce → Configuration → MTO order types**
  (`/admin/commerce/config/mto-order-types`).
- **Production orders** (the working listing your team uses):
  **Commerce → MTO orders** (`/admin/commerce/mto-orders`), with exposed filters
  and a dashboard widget.
- **Analytics**: `/admin/commerce/mto-orders/analytics`.
