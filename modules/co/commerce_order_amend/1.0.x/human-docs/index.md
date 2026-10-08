# Commerce Order Amend — manual setup guide

**Commerce Order Amend** (`commerce_order_amend`) adds an **"Amend Order" tab** to
placed Commerce orders, giving back-office staff a guided interface for changing an
order *after* it has been placed — swapping item variations, adding or removing
order items, and adding or removing coupons. It depends on Commerce **Order**
(`commerce_order`) and Commerce **Promotion** (`commerce_promotion`).

The problem it solves is that Commerce core lets you raw-edit an order's entity but
lacks the business logic around amendments: price protection, refreshing a *placed*
(non-draft) order, audit logging with SKUs, balance-difference calculation, payment
guidance and event-driven extensibility. Order Amend wraps all of that into one
guided form. It **locks all item prices during the refresh** so the original
checkout pricing is preserved, **detects side effects** (promotions added or removed,
tax recalculations) and warns staff about them, tracks the payment balance
difference with guidance to collect payment or issue a refund, and records a
**Commerce Log audit trail** prefixed with "Order Amended" (including SKUs and
reasons).

This module needs a little configuration: it lets you choose which order states are
editable via its admin UI, and it can optionally validate stock (respecting the
always-in-stock flag) if **Commerce Stock** is installed. It also dispatches an
`OrderAmendEvent` so other modules can react — for stock adjustments, made-to-order
sync, notifications or ERP integration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — set which order states are editable,
   the stock-validation option, and the permission.

## Where it lives in the admin menu

The feature appears as an **Amend Order** tab on an individual order's page in the
back office (**Commerce → Orders → *(order)***). Its settings — which order states
are editable — are managed through the module's admin UI, described in
[Configuration](configuration/index.md).

## How to use it

1. Open a placed order in the back office and click the **Amend Order** tab.
2. Make your changes — swap a variation, add or remove items, add or remove coupons,
   or override a unit price (the currency is locked to the order's currency).
3. Save. The module forces a full order refresh (with prices locked), warns you
   about any unexpected side effects with a link to the order edit form, and shows
   the payment balance difference so you know whether to collect more or refund.
4. The change is written to the Commerce Log audit trail, and an `OrderAmendEvent`
   is dispatched for any integrations that need to react.

> **Heads-up on refresh side effects.** Commerce core deliberately skips order
> refresh on placed orders because the pipeline can be destructive. This module
> forces the refresh anyway (with mitigations), so some side effects can't be fully
> prevented — expired or usage-limited promotions may be removed or re-applied, tax
> rules that changed since placement will apply current rates, and availability
> checkers may flag items. The module warns you about these; review them before
> confirming.
