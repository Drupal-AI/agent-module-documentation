# Commerce Zero-Out Tax Promotion — manual setup guide

**Commerce Zero-Out Tax Promotion** (`commerce_zero_out_tax`) adds a Drupal
Commerce **promotion offer** that resets an order's tax to zero by removing its
tax adjustments. Rather than a settings page, it plugs into Commerce's promotions
system: you create a promotion of the "Zero out tax" type, and whenever that
promotion applies to an order, the offer strips the tax adjustments back out.

The problem it solves: some stores need to zero tax for particular customers or
scenarios — for example legitimately tax‑exempt buyers, or a specific
promotional campaign — without disabling tax globally. This module gives you a
targeted, condition/coupon‑driven way to do that.

> **Compliance caution.** Zeroing tax has real compliance implications. Apply
> this offer only where tax exemption is genuinely warranted, and scope it tightly
> with the promotion's conditions and/or coupons.

Because it is a promotion offer plugin, there is **no dedicated configuration
page** — all setup happens on the Commerce promotion itself (see *How to use it*
below). It works with Drupal Commerce's promotions and has no access‑control role
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no separate configuration page** — you configure the behavior entirely
on a Commerce promotion, as described next.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Commerce →
Promotions** (`/promotion` / `/admin/commerce/promotions`), where "Zero out tax"
becomes available as a promotion **offer** type.

## How to use it

1. Enable the module.
2. Go to **Commerce → Promotions** and click **Add promotion**.
3. For the promotion's **offer**, choose the **Zero out tax** type.
4. Add any **conditions** (for example customer role, store, or order criteria)
   and/or **coupons** so the offer only applies where you intend.
5. Save. When the promotion applies to an order, its tax adjustments are removed
   and the order's tax total becomes zero.
