<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Purchase Order adds a "pay by Purchase Order" gateway to Drupal Commerce checkout — the B2B method where a customer enters a PO number (and optionally uploads a PO document), the order is placed as an offline/manual payment, and staff record payment later.

---

Business-to-business selling works differently from consumer selling: an approved account places an order against a purchase order number, goods ship, and payment follows on agreed terms. Commerce's gateways are built around taking money at checkout, so this supplies the alternative — a `purchase_order_gateway` payment gateway that records a PO reference on a one-time payment method and authorizes the order without moving money. A payment placed this way sits in the `authorized` state until a user with `administer commerce_payment` opens the order's Payments tab and runs the Receive operation to mark it `completed`. Two controls decide who may use it: the gateway's `user_approval` setting checks each customer's `field_purchase_orders_authorized` boolean at authorization time (declining unapproved customers), while the `commerce_purchase_order_auth` condition can hide the gateway entirely from customers who are not approved. A `limit_open` setting caps how many unpaid POs a customer may carry, admin-defined `instructions` appear at checkout and in the receipt email, and an optional private-file upload lets customers attach the PO paperwork. Dependencies are `commerce`, `commerce_payment`, `profile`, and core `file`; the single permission `authorize user purchase orders` governs which staff can approve accounts.

---

- Let approved customers pay by purchase order.
- Support B2B checkout without card payment.
- Record a PO number against an order.
- Invoice a customer after fulfilment.
- Restrict PO payment to authorised accounts.
- Attach a PO document (private file) to an order.
- Support net payment terms.
- Sell to public-sector and agency buyers.
- Handle a procurement / requisition workflow.
- Reconcile orders against purchase orders.
- Offer PO alongside card and other gateways.
- Cap the number of open unpaid POs per customer.
- Show payment instructions on the order receipt.
- Extend credit terms per account.
- Complete an order without a live transaction.
- Route PO orders to a finance team to receive later.
- Provide a familiar B2B checkout experience.
- Track outstanding authorized (unpaid) orders.
- Void or refund a placed PO payment.
- List all purchase orders in an admin View.
- Require staff approval before an account can use PO.
