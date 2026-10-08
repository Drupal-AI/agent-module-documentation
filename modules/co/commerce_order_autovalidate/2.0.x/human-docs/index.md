# Commerce Order Auto-validation — manual setup guide

**Commerce Order Auto-validation** (`commerce_order_autovalidate`) automatically
moves Drupal Commerce orders that are **paid in full** from the `validation` state
to `validated`, so staff don't have to click through that transition by hand. It
depends on the Commerce **Order** (`commerce_order`) and Commerce **Payment**
(`commerce_payment`) submodules.

The problem it solves is the manual step of validating orders once payment has
cleared. On each cron run the module finds orders sitting in the `validation` state
that have a completed payment and applies the `validate` transition — but only after
confirming the order is genuinely paid. It is **correctly guarded**: before
transitioning, it checks Drupal Commerce's own `isPaid()` method (which verifies the
total paid actually covers the order total), so an unpaid or partially-paid order is
never auto-validated.

This module has **no configuration screen** — it works purely from the order
workflow and cron. For it to do anything, two things must be true: your order type's
workflow must include a **`validation` state and a `validate` transition** (this
module only makes sense with such a workflow), and **cron must run regularly**, since
validation happens on cron.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has **no settings form**. Its behaviour depends only on your order
workflow and on cron running, described below.

## How it works

- On every cron run, the module looks for orders in the **`validation`** state that
  have a **completed payment**.
- For each one, it checks `$order->isPaid()` — Commerce's real paid-in-full check.
- If the order is genuinely paid in full, it applies the **`validate`** transition,
  moving the order to `validated`. Unpaid orders are left untouched.

## What you need for it to work

- **An order workflow with a `validation` state and a `validate` transition.** This
  module is only meaningful with such a workflow — it doesn't create the state or
  transition for you. Set the workflow on your order type at **Commerce →
  Configuration → Order types**.
- **Regular cron.** Validation only happens during cron, so make sure cron runs
  frequently enough for your needs (via Drupal's built-in scheduler or an external
  cron job).
