<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce: Admin Payment (commerce_admin_payment) — agent index

Submodule of **Commerce: Admin Checkout**. It lets an administrator **stage manual payments against
an order during checkout** — record a real-world payment (cash, cheque, etc.) or apply a payment
that behaves like a discount, reducing what the customer pays. Built on **Commerce Multiple
Payments** (`commerce_multi_payment`), so staged payments are held on the order until checkout
completes. Package `Commerce`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Installed **3.1.0**.

## Dependencies

- Drupal modules (`.info.yml`): **`commerce_checkout`**, **`commerce_order`**, **`commerce_multi_payment`**.
- Enabled on top of the parent `commerce_admin_checkout`.

## What it provides (from source)

- **Checkout pane** `commerce_admin_manual_payment_apply` (**Admin: Apply Manual Payments**,
  `Plugin/Commerce/CheckoutPane/AdminApplyPayment`, default step `order_information`). `isVisible()`
  requires the permission `apply admin payments in checkout` **and** at least one Admin-Manual
  gateway that applies to the order. Configurable display label / wrapper element. Its summary
  renders the staged admin payments.
- **Form element** `commerce_admin_payment_apply_form` (`Element/AdminManualPaymentApplyForm`) — the
  pane body. Lists existing staged admin payments (each with a **Remove** button →
  `ajaxRemoveStagedPayment`), and an **Add Payment** fieldset: pick an Admin-Manual gateway, enter
  amount + description, **Apply** → `ajaxCreateStagedPayment` creates a `StagedPayment` via
  `commerce_multi_payment.manager`, adjusts the amount, and appends it to the order's
  `staged_multi_payment` field.
- **Payment gateway** `admin_manual` (`Plugin/Commerce/PaymentGateway/AdminManual`) implementing
  `AdminManualPaymentGatewayInterface` (extends core `ManualPaymentGatewayInterface` +
  `SupportsMultiplePaymentsInterface`). Config: `instructions`, `automatically_received` (default
  TRUE), `allow_negative` (default FALSE). Implements the standard manual-payment lifecycle
  (`createPayment`, `receivePayment`, `voidPayment`, `refundPayment`, `capturePayment`) plus the
  multi-payment authorize/void/expire/capture hooks that turn a staged payment into a real
  `commerce_payment`.
- **Payment type** `payment_admin_manual` (`Plugin/Commerce/PaymentType/PaymentAdminManual`,
  workflow `payment_manual`) — adds a `description` field ("Comments about this payment entered by
  the administrator").
- **Plugin forms**: `AdminManualPaymentAddForm` (add-payment: amount + description + received flag,
  honours `allow_negative` / `automatically_received`) and a `PaymentReceiveForm` (in the
  `commerce_payment` namespace) for the receive-payment operation.
- **Condition** `commerce_admin_payment_pane` (`Plugin/Commerce/Condition/AdminPaymentPane`) — lets
  a gateway be limited by context: the admin-payments pane, other checkout panes, or the admin
  "Add payment" form. It keys off the transient `$order->is_admin_payment_pane` flag set by the
  manager and the current route.
- **Manager service** `commerce_admin_payment.manager` (`AdminManualPaymentManager`) — resolves the
  Admin-Manual gateways that apply to an order (dispatches the core `FILTER_PAYMENT_GATEWAYS` event
  with `is_admin_payment_pane = TRUE`, evaluates conditions, sorts). Also (re)registers the
  `commerce_multi_payment.multi_payment_order_processor` order processor.
- **Permission** (`.permissions.yml`): `apply admin payments in checkout` (`restrict access: true`).
- One theme hook (`commerce_admin_payment_apply_form`) + template. No config schema, no
  install/update hooks.

## How a payment flows

1. Admin (with `apply admin payments in checkout`) sees the pane, picks an Admin-Manual gateway,
   enters amount + description, clicks **Apply**.
2. A `StagedPayment` is created and attached to the order's `staged_multi_payment` field (nothing is
   charged yet).
3. On checkout completion, Commerce Multiple Payments' order processor + the gateway's
   `multiPaymentAuthorizePayment` / `multiPaymentCapturePayment` turn staged payments into real
   `commerce_payment` entities (auto-received when `automatically_received` is on).

Because these are manual payments, "receiving" one records money without any external gateway — the
control that matters is *who can apply them*, which is the `apply admin payments in checkout`
permission.
