# Commerce Order Withdrawal — manual setup guide

**Commerce Order Withdrawal** (`commerce_order_withdrawal`) adds a customer-facing
**order withdrawal form** to Drupal Commerce — an implementation of the EU *right
of withdrawal* (the French *droit de rétractation*). A customer identifies their
order, submits the form, and the module records the withdrawal request on the order
and sends a confirmation email (optionally with a BCC copy to the merchant).

The module is deliberately **lightweight**: it **records and notifies — it does not
cancel or refund the order**. Actually cancelling or refunding is left to your staff
or to custom code that reacts to the module's events. Think of it as the compliant
"request to withdraw" front door, with the fulfilment decision staying under human
(or your own coded) control.

It depends on **Commerce Order** (`commerce_order`) and **Commerce Log**
(`commerce_log`) — the log is where the withdrawal request is recorded — and it
provides its own permission for using the form. The confirmation email body comes
from a Twig template you can override in your theme.

> **This module is not stable yet** (version 1.0.0-alpha1). Use it with caution and
> test thoroughly before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — grant the permission, enable
   withdrawal per order type, set the confirmation email, and show the withdrawal
   link.

## Where it lives in the admin menu

There is no central settings page. You configure withdrawal **per order type**
under **Commerce → Configuration → Order types → *(order type)* → Edit** (an *Order
withdrawal* section), grant the form permission at **People → Permissions**, and
optionally add the withdrawal link to the order display and to your customer orders
View.

## A note on the public form

The withdrawal form is customer-facing and acts on a specific order, and the module
scopes it accordingly. The public form at `/order_withdrawal` verifies the request
against the order itself: the submitted order number **and** the email must both match
before anything is recorded, and the not-found message is deliberately generic so the
form never reveals whether an order number exists. The per-customer form at
`/user/{user}/order_withdrawal/{commerce_order}` is limited to the order's own owner
(or staff with *administer commerce_order*), so a logged-in customer only ever confirms
their own orders. On sites that do not use guest checkout you can additionally withhold
the form permission from the anonymous role. Because the module only **logs and
notifies** — it does not auto-refund — a request doesn't move money on its own; staff
(or your own event subscriber) decide what happens next. The
[Configuration](configuration/index.md) page covers the permission and per-order-type
opt-in that control access.
