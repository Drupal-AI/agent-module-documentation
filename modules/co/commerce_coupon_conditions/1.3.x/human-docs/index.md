# Commerce Coupon Conditions — manual setup guide

**Commerce Coupon Conditions** (`commerce_coupon_conditions`) adds condition
plugins for Drupal Commerce **coupons**, so a discount code can be restricted by
rules the core promotion system does not express on the coupon itself.

Commerce models a promotion with conditions (order total, product, customer) and
a coupon as a code that unlocks it. Normally those conditions live on the
*promotion*. But it is often more useful — and less work for a store manager — to
attach **multiple coupons to one discount, each with its own restrictions**.
This module makes that possible: it contributes additional conditions into
Commerce's own condition system, so they show up alongside the built‑in ones and
combine with them in exactly the same way.

Typical uses the maintainers highlight include **time‑limited coupons** (a coupon
with its own expiration date), **geo‑distributed discounts** (one discount, a
different coupon code per country), and **employee discounts** (one discount with
many coupons, each restricted per employee). Instead of creating many nearly
identical promotions, you create one and vary the coupons.

It depends on **Commerce Promotion** (`commerce_promotion`) and supports Drupal
9, 10, and 11. This branch is covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
select the conditions when editing a coupon or promotion, described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. The conditions appear in the promotion
and coupon editors under **Commerce → Promotions** (`/promotion`).

## How to use it

1. Go to **Commerce → Promotions** and create (or edit) a discount promotion.
2. Add one or more **coupons** to that promotion.
3. On the coupon (or the promotion), open the **Conditions** section and choose
   the conditions this module provides — they sit alongside Commerce's built‑in
   conditions.
4. Save.

A couple of practical notes from the maintainers:

- **Do not select the same condition on both the coupon and its parent
  promotion.** Duplicating a condition on both sides causes confusing results.
- **When a coupon "doesn't work", check the condition logic first.** Commerce
  evaluates a promotion's conditions with a configurable **AND/OR operator**, so a
  coupon failing to apply is far more often an operator or per‑condition problem
  than a problem with the code itself. Test with a **real cart**, since conditions
  depend on order state (customer history, totals, item combinations) that is hard
  to reason about statically.
