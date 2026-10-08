# Commerce Purchase Order — manual setup guide

**Commerce Purchase Order** (`commerce_purchase_order`) adds the classic B2B
"pay by purchase order" payment method to Drupal Commerce. Instead of paying at
checkout, an approved customer supplies a **PO number**, the order is placed and
the goods ship, and payment is invoiced and reconciled later on agreed terms.

The problem it solves is that Commerce's normal gateways are built around taking
money at checkout, which does not match how businesses, universities, and public
bodies buy. This module supplies the alternative: a payment method that records
the PO reference and **completes the order without a transaction**, leaving
payment to be recorded manually once it arrives.

The most important thing to understand is that the permission
**"authorize user purchase orders" is effectively a credit decision**. It
controls which customers may check out on PO terms — meaning goods ship before you
are paid — so granting it is a commercial approval, not a UI convenience. The
module also adds a **Purchase Orders Authorized** field to the User entity so you
can approve accounts individually. Dependencies are substantial: `commerce`,
`commerce_payment`, `profile` (customer profiles are where authorisation attaches),
and core `file` (so PO documents can be attached to an order).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce.
2. [Configuration](configuration/index.md) — expose the authorization field, add
   the PO payment gateway, and understand the PO workflow.

## Where it lives in the admin menu

Purchase Order is a **payment gateway**, added under **Administration → Commerce →
Configuration → Payment gateways** (`/admin/commerce/config/payment-gateways`).
The customer-authorization field is managed on the account form display at
**Configuration → People → Account settings → Manage form display**
(`/admin/config/people/accounts/form-display`).
