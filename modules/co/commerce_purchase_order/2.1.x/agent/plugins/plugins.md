# Commerce plugins, workflow & payment lifecycle

The module provides four Commerce plugins (instances of Commerce's own plugin types — it does **not**
define new plugin types) plus one payment workflow.

## Plugins

| Kind | id | Class | Notes |
|---|---|---|---|
| `@CommercePaymentGateway` | `purchase_order_gateway` | `PurchaseOrderGateway` (extends `OnsitePaymentGatewayBase`) | label/display_label "Purchase Orders". Implements `HasPaymentInstructionsInterface`, `SupportsVoidsInterface`, `SupportsRefundsInterface`. Forms: `add-payment-method` → `PurchaseOrder\PaymentMethodAddForm`; `receive-payment` → core `PaymentReceiveForm`. `payment_method_types = {"purchase_order"}`, `payment_type = "payment_purchase_order"`. |
| `@CommercePaymentMethodType` | `purchase_order` | `PaymentMethodType\PurchaseOrder` | Adds fields `po_number` (string) and `po_file` (entity_reference → file). `buildLabel()` returns `t('Purchase Order# @label', …)` from the PO number (or filename). |
| `@CommercePaymentType` | `payment_purchase_order` | `PaymentType\PurchaseOrder` | Binds the `payment_purchase_order` workflow; no extra fields. |
| `@CommerceCondition` | `commerce_purchase_order_auth` | `Condition\PurchaseOrderCustomerApproved` | Category "Customer", display "Limit by field: Purchase Orders Authorized", `entity_type = commerce_order`. `evaluate()` returns the customer's `field_purchase_orders_authorized` boolean (FALSE if unset/empty). Add it on the gateway's Conditions to offer PO only to approved customers. |

## Payment workflow `payment_purchase_order`

`commerce_purchase_order.workflows.yml`, group `commerce_payment`:

- States: `new`, `authorized`, `completed`, `partially_refunded`, `refunded`, `voided`.
- Transitions: `authorize` (new→authorized), `receive` (authorized→completed),
  `partially_refund` (completed→partially_refunded), `refund` (completed|partially_refunded→refunded),
  `void` (completed→voided).

`buildPaymentOperations()` exposes on the order Payments tab: **Receive** and **Void** only while the
payment is `authorized`, and **Refund** while `completed`/`partially_refunded`.

## Payment lifecycle (what actually happens)

1. **Add payment method** — `PaymentMethodAddForm::buildPurchaseOrderForm()` renders a required PO
   `number` textfield (`#maxlength 19`; not required when file upload is allowed) and an optional
   `managed_file` (`#access` = the gateway `file_upload` setting AND private files configured; upload
   location `private://purchase-orders`; `FileExtension` validator from `file_extensions`).
   `createPaymentMethod()` requires `number` (or a file), stores `po_number`, marks the method
   non-reusable, sets a +60-day expiry, saves, and records `file.usage` for any uploaded file.
   Form errors are re-wrapped generically for the customer.
2. **Place order** — Commerce's checkout PaymentProcess pane calls
   `createPayment($payment)` → `assertPaymentState(new)` → `authorizePayment()` →
   `assertAuthorized()` → `save()`. `authorizePayment()` checks approval (see
   [../configure/user-approval.md](../configure/user-approval.md)) and the `limit_open` open-PO
   count; on success sets state `authorized` and the authorized time. The payment **amount is the
   order balance set by Commerce server-side** — the gateway never reads a customer-supplied amount.
   An unapproved/over-limit customer stays `new` and `assertAuthorized()` throws
   `HardDeclineException`, blocking checkout.
3. **Receive (staff)** — order Payments tab → *Receive* runs `receivePayment()`
   (`assertPaymentState(authorized)`; amount defaults to the payment amount) → state `completed`.
   *Void* → `voidPayment()` (from `authorized`) → `voided`. *Refund* → `refundPayment()` → `refunded`
   or `partially_refunded`.

`hook_post_update` `commerce_purchase_order_post_update_awaiting_payment` migrated legacy states for
issue 3184883 (`completed`→`authorized`, then `paid`→`completed`). `hook_update_8100` installed the
`po_file` field storage on `commerce_payment_method`.
