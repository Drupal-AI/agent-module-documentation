# Commerce Multiple Payments — manual setup guide

**Commerce Multiple Payments** (`commerce_multi_payment`) lets a customer put
**several partial payments** toward a single Commerce order at checkout — for
example a gift card *plus* store credit *plus* a card charge — instead of paying
the whole total with one method. It's aimed at payment types like gift cards or
store credit, where the available balance may not cover the order and the customer
needs to pay the remainder another way.

Under the hood it adds a `commerce_staged_multi_payment` entity that represents an
amount "staged" against an order, and an order processor that turns those staged
amounts into order **adjustments** so the balance due updates as credit is applied.
The customer then pays whatever is left with a normal payment gateway. A
staged-payments admin tab on each order lets staff see and manage what has been
applied. It depends on Commerce's **Payment**, **Checkout** and **Order** modules.

One important limitation: this module **does not support offsite payment gateways**
(such as PayPal) for the staged payments — it is designed for on-site balance-style
methods like gift cards and store credit.

To actually collect staged payments you need at least one payment gateway that
implements the multi-payment inline forms. The bundled **example submodule**
(`commerce_multi_payment_example`) ships **Gift Card** and **Store Credit** gateway
plugins with inline checkout forms as working reference implementations — enable it
to try the feature, or model your own gateway on it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and enable a multi-payment-capable gateway (or the example submodule).

This module has **no global settings form**. Its behaviour is driven by the payment
gateways you enable and by permissions; day-to-day use happens at checkout and on
each order's staged-payments tab, described below.

## Where it lives in the admin menu

There is no configuration page. Each order gains a **staged-payments** view at
**Commerce → Orders → *(order)* → Staged payments**
(`/admin/commerce/orders/{order}/staged-payments`), where staff can review and
manage the partial payments applied to that order. Access to it requires update
access on the order (it is not open to anonymous users).

## How to use it

1. Enable the module and at least one multi-payment-capable gateway — the
   `commerce_multi_payment_example` submodule is the quickest way to get **Gift
   Card** and **Store Credit** gateways for testing.
2. At checkout, the customer applies a staged payment (say, a gift card balance)
   through that gateway's inline form. The order's balance due drops by that
   amount.
3. They can apply further staged payments, then pay any remaining balance with a
   standard payment method.
4. Back-office staff can review or remove staged payments from the order's
   **Staged payments** tab.

## Permissions

The module defines a permission set for working with staged-payment entities — add,
edit, delete, view (published/unpublished), access the overview, and **administer
staged payment entities** (marked *restrict access*). Grant the administration
permission only to trusted roles, since it governs money already applied to orders.
