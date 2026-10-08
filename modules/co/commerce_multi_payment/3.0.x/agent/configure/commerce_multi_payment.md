<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Multiple Payments

## Concept
An order can accumulate several `commerce_staged_multi_payment` entities, each an amount staged against the order. The order processor `MultiplePaymentOrderProcessor` (priority 1) turns them into order **adjustments**, so the order total's remaining balance reflects credit already applied; the customer then pays the remainder with a normal gateway.

## Setup
1. Enable `commerce_multi_payment` (pulls in commerce_payment/checkout/order).
2. Enable at least one multi-payment-capable payment gateway. For a working reference enable `commerce_multi_payment_example`, which registers **Gift Card** and **Store Credit** gateway plugins with inline checkout forms.
3. Staged payments are added during checkout via the gateway inline forms, or from the order admin at `/admin/commerce/orders/{commerce_order}/staged-payments`.

## Access & permissions
- The staged-payments collection route uses the custom check `_staged_payment_access` (`StagedPaymentAccessCheck`): requires order **update** access AND a non-empty `staged_multi_payment` field. The literal `'TRUE'` in routing.yml is the check's applies-to value, not `_access: TRUE`.
- Entity permissions: `add`, `administer` (restrict access), `delete`, `edit`, `access ... overview`, `view published`, `view unpublished` staged payment entities.

## Building a custom multi-payment gateway
Model it on the example submodule: implement a payment gateway plugin plus an inline form under `src/Plugin/Commerce/{PaymentGateway,InlineForm}` that stages a `commerce_staged_multi_payment` amount against the order; the order processor handles balance adjustment. Register a template if the inline form needs custom markup.
