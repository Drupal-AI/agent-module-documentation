<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Invoice Payment — flow & plugins

## Making invoices payable
`commerce_invoice_payment.module` → `hook_entity_type_build()` swaps the `commerce_invoice` entity class for `Drupal\commerce_invoice_payment\Entity\Invoice`, making invoices usable as purchasable entities / order items.

## "Pay invoice" VBO action (`Plugin/Action/PayInvoiceAction`)
- `@Action(id = "commerce_invoice_payment_pay_invoice_action", type = "commerce_invoice", confirm = TRUE)`.
- `execute()` creates (or reuses) an `invoice_payment` order for the acting user, adds each selected invoice as an order item (`createFromPurchasableEntity`), saves, and stores an entry URL/title on the order data.
- `executeMultiple()` redirects to `commerce_checkout.form` at the `review` step so payment happens through the normal gateway.
- **Access:** `access()` = `$invoice->access('update', $account) && $account->hasPermission('use pay invoice action')`. The permission is `restrict access: true`.

## Marking paid (`EventSubscriber/OrderPaidSubscriber`)
- Subscribes to `OrderEvents::ORDER_PAID` (fired by Commerce **after** real payment).
- For each purchased entity that is an `InvoiceInterface`: if state is `draft` apply `confirm`, then apply `pay`, then save.
- No route/webhook does this — it is strictly event-driven off a verified payment, so an invoice cannot be flipped to paid by an unverified request.

## Checkout-complete pane
`Plugin/Commerce/CheckoutPane/InvoicePaymentOrderCompletePane` lists the paid invoices (when `$order->isPaid()`) and renders a return link from the stored `entry_url`.

## Setup
1. Enable the module (+ optional `commerce_invoice_payment_example`).
2. Add the "Pay invoice" action to a `commerce_invoice` View (VBO).
3. Grant `use pay invoice action` to the intended role; ensure those users have `update` access to the invoices.
4. Configure a Commerce checkout flow + payment gateway for the `invoice_payment` order type.
