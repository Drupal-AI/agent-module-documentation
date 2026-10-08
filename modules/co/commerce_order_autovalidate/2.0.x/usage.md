<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Order Auto-validation automatically transitions Drupal Commerce orders to the validated state once they are paid in full, checked on cron.

---

Commerce Order Auto-validation automatically transitions Drupal Commerce orders in the `validation`
state to `validated` once they are **paid in full** — a cron job finds orders in validation state with a
completed payment and applies the `validate` transition, but only after confirming the order is actually
paid. It depends on the Commerce Order and Commerce Payment submodules.

This is correctly guarded: before applying the transition, it checks `$order->isPaid()` (Commerce's method
that verifies total paid covers the order total), so an order is only auto-validated when it is genuinely
paid in full — it does not validate unpaid orders. It depends on the Commerce Order and Commerce Payment
submodules. Use it to automate order validation on paid orders
(reducing manual validation). It is an e-commerce/order-workflow feature; the auto-validation is
payment-gated. Ensure your order workflow includes a `validation` state and `validate` transition.

---

- Auto-validate paid-in-full orders.
- Transition orders to validated on cron.
- Check isPaid before validating.
- Find orders in validation state.
- Require a completed payment.
- Depend on Commerce Order.
- Not validate unpaid orders.
- Confirm the order is genuinely paid.
- Reduce manual validation.
- Payment-gate the auto-validation.
- Automate order validation.
- Apply the validate transition.
- Run on cron.
- Validate only paid orders.
- Require a validation state/transition.
- Handle order workflow.
- Validate paid orders.
- Automate paid-order handling.
- Check payment before validating.
- Auto-process paid orders.
