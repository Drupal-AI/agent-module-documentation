<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Auto-validation — agent index

Automatically **validates Drupal Commerce orders that are paid in full**. Version **2.0.2**.
Core `^9.5 || ^10 || ^11`. Requires `drupal/commerce ^2.29 || ^3`.
Depends on the `commerce_order` and `commerce_payment` submodules.

## What it is

A single-purpose, config-free module. Its entire behaviour is one `hook_cron()`
implementation in `commerce_order_autovalidate.module` — there are no routes, forms,
services, permissions, plugins, config schema, or entities. It only makes sense with an
order workflow that defines a `validation` state and a `validate` transition.

## Mechanism (`commerce_order_autovalidate_cron()`)

On every cron run:

1. **DB query** — selects `commerce_order` rows where `state = 'validation'`, left-joined
   to `commerce_payment`, keeping orders where **either** `total_price__number = 0`
   **or** a joined payment has `state = 'completed'`.
2. **Load** the matching orders via the `commerce_order` storage.
3. **Per-order guard** — gets the workflow's `validate` transition and, only if the
   transition exists **and** `$order->isPaid()` returns TRUE, applies the transition,
   saves the order, and logs `Automatically validated order @id` to the
   `commerce_order_autovalidate` channel.

`$order->isPaid()` is Commerce's authoritative paid-in-full check (total paid ≥ order
total, and TRUE for zero-total orders). It is the real gate: the SQL clause only
pre-filters candidates, and a partially-paid order (one completed payment below the
total) is loaded but **not** transitioned because `isPaid()` returns FALSE.

## Security / workflow-integrity posture

- **Cron-only.** No route, controller, form, or request path can trigger validation;
  there is no request-supplied input and nothing a customer can do to select which
  orders are validated beyond the normal payment flow.
- **Payment-gated.** The transition is applied only when `$order->isPaid()` is TRUE, so
  an unpaid or partially-paid order is never auto-validated. Zero-total orders (which are
  paid-in-full by definition) do validate — this is intended.
- No secrets, no external I/O, no user input, no injection surface (fixed query with a
  literal state and bound conditions).

## Requirements to have any effect

- An order type whose workflow includes a `validation` state and a `validate`
  transition (the module does not create them).
- Cron running regularly (validation happens only on cron).

## Related docs

- [`usage.md`](../usage.md) — task-oriented summary.
- [`human-docs/index.md`](../human-docs/index.md) — human setup guide.
