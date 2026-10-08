<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Multiple Payments (commerce_multi_payment) — agent index

**Applies multiple partial/staged payments (gift card, store credit, etc.) to a single Commerce order at checkout.**

- **Version:** 3.0.x (installed dev-3.0.x; nearest tag 3.0.1)
- **Core:** ^9 || ^10 || ^11
- **Depends:** commerce_payment, commerce_checkout, commerce_order
- **Submodule:** `commerce_multi_payment_example` (Gift Card + Store Credit gateway/inline-form references)
- **Entity:** `commerce_staged_multi_payment` (own workflow group/workflows, adjustment type).
- **Services:** `commerce_multi_payment.manager`, `...multi_payment_order_processor` (commerce_order.order_processor, priority 1), `...staged_payment_access_check`.
- **Route:** `entity.commerce_staged_multi_payment.collection` → `/admin/commerce/orders/{commerce_order}/staged-payments`, guarded by `_staged_payment_access`.
- **Permissions:** add / administer / delete / edit / access overview / view (un)published staged payment entities.

**Security:** the `_staged_payment_access: 'TRUE'` route requirement is the *name* of a custom access check, **not** an anonymous bypass — `StagedPaymentAccessCheck::access()` requires the current user to have `update` access on the `commerce_order` and that the order has a non-empty `staged_multi_payment` field. Entity operations are gated by the module's permission set (`administer staged payment entities` marked restrict access). No disabled TLS, raw SQL, or unverified callback in module code.

See [configure/commerce_multi_payment.md](configure/commerce_multi_payment.md)
