# Commerce Invoice Payment — manual setup guide

**Commerce Invoice Payment** (`commerce_invoice_payment`) lets your customers pay
their outstanding **Commerce Invoices** online through the normal Commerce
checkout. It bridges two systems that don't otherwise talk to each other: the
**Commerce Invoice** module (which produces invoices) and Commerce's **order and
payment** flow (which actually collects money). The result is a self‑service
"pay my invoices" experience built on top of the checkout you already trust.

The mechanism is a **Views Bulk Operations "Pay invoice" action**. You add this
action to a View that lists invoices; a customer (or an administrator) selects one
or more open invoices, triggers the action, and the module turns them into line
items on a special `invoice_payment` order and sends that order straight to the
checkout **review** step. Payment then happens through whichever Commerce
**payment gateway** you have configured — this module does not process cards
itself.

The security posture here is deliberately careful and worth understanding.
Invoices are **only ever marked paid in response to Commerce's own `ORDER_PAID`
event** — that is, after the order has genuinely been paid through a configured
gateway. There is **no webhook or callback route** that could flip an invoice to
"paid" from an unverified request. On top of that, the "Pay invoice" action is
access‑controlled: a user needs both **update access** on the invoice entity *and*
the restricted **`use pay invoice action`** permission before they can run it.

It depends on **Commerce**, **Commerce Order**, **Commerce Invoice**
(`commerce_invoice`), and **Views Bulk Operations** (`views_bulk_operations`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no dedicated settings page** for this module. Setup happens by adding
the "Pay invoice" action to an invoices View and granting a permission, described
in "How to use it" below.

## Where it lives in the admin menu

Commerce Invoice Payment adds no admin configuration page of its own. You work
with it in three familiar places:

- **Views** (**Structure → Views**) — where you add the "Pay invoice" bulk action
  to a View that lists `commerce_invoice` entities.
- **Permissions** (**People → Permissions**) — where you grant the restricted
  **`use pay invoice action`** permission.
- **Commerce checkout / payment gateways** — the standard Commerce settings that
  actually collect the payment.

## How to use it

1. **Enable the module** (see [Installation](installation/index.md)). An optional
   `commerce_invoice_payment_example` submodule ships with the project if you want
   a worked example to learn from.
2. **Add the "Pay invoice" action to an invoices View.** Edit (or create) a View
   that lists `commerce_invoice` entities, enable its bulk‑operations field, and
   include the **Pay invoice** action in the allowed actions.
3. **Grant the permission.** Under **People → Permissions**, give the
   **`use pay invoice action`** permission to the roles that should be allowed to
   pay invoices. This permission is flagged *restrict access*, so grant it
   deliberately. Also make sure those users have **update** access to the invoices
   they are meant to pay — both checks must pass.
4. **Configure checkout and a payment gateway** for the `invoice_payment` order
   type, exactly as you would for any Commerce order, so there is a real gateway
   to take the payment.

Once that's in place, a customer selects their open invoices in the View, runs
**Pay invoice**, and is taken to checkout. When they complete payment, Commerce
fires `ORDER_PAID`, and the module transitions each paid invoice through its
workflow (confirming a draft first if needed, then marking it paid). A
checkout‑complete pane lists the invoices they just settled and offers a link back.
