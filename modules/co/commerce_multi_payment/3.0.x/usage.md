<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Multiple Payments lets an order be paid with several partial "staged" payments — for example a gift card plus store credit plus a card charge — instead of a single payment method at checkout.

---

It defines a `commerce_staged_multi_payment` entity representing an amount staged against an order, an order processor (`MultiplePaymentOrderProcessor`, priority 1) that applies staged payments as order adjustments so the remaining balance updates, and a `MultiplePaymentManager` service coordinating them. A staged-payment adjustment type is registered (`commerce_multi_payment.commerce_adjustment_types.yml`) and the entity has its own workflow group/workflows. Supported payment gateways implement the multi-payment inline forms; the bundled `multi_payment_example` submodule ships Gift Card and Store Credit gateway plugins with inline checkout forms as reference implementations. A staged-payments admin collection is exposed at `/admin/commerce/orders/{commerce_order}/staged-payments`.

The staged-payments collection route uses a custom access check (`_staged_payment_access`, `StagedPaymentAccessCheck`) that requires **order `update` access** for the current user and that the order actually has staged payments — so despite the `_staged_payment_access: 'TRUE'` shorthand in routing.yml, access is not anonymous. The module also defines a full permission set for creating/administering/viewing staged-payment entities. Setup involves enabling the module, enabling one or more multi-payment-capable gateways (or the example), and adding staged payments during checkout or from the order's staged-payments tab.
---
Pay one order with a gift card plus a card charge.
- Combine store credit and another gateway on a single order.
- Split a checkout total across multiple payment methods.
- Apply a partial payment and leave a remaining balance.
- Add staged payments from an order's admin tab.
- View all staged payments for an order.
- Register a gift-card payment as an order adjustment.
- Register store credit as an order adjustment.
- Use the example Gift Card gateway as a starting point.
- Use the example Store Credit gateway as a starting point.
- Build a custom multi-payment gateway with an inline form.
- Recalculate the order balance after each staged payment.
- Restrict staged-payment administration via permissions.
- Allow specific roles to create staged payment entities.
- Delete a staged payment before completing the order.
- Edit a staged payment amount.
- Move staged payments through their workflow states.
- Gate the staged-payments page to users with order update access.
- Offer redeem-credit-then-pay-rest checkout flows.
- Support partial refunds modeled as staged entries.
- Access the staged payment overview page by permission.
