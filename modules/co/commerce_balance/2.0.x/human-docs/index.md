# Commerce Balance — manual setup guide

**Commerce Balance** (`commerce_balance`) extends Drupal Commerce with a
"how much is still owed?" layer. It adds a computed **balance** field to every
order (the part of the order total that hasn't been paid yet), a per‑user list of
orders that still carry an outstanding balance, and a manual **Balance (Pay
later)** payment gateway that lets a customer complete checkout without paying in
full up front. It's a natural fit for B2B "pay on invoice", deposits, and
partial‑payment or store‑credit workflows.

The order balance is *computed* from the order and payment totals — it is never
stored as an editable field. That's an intentional design choice: because there
is no writable balance value, there's nothing for a customer (or a tampered
request) to manipulate, and no way to force a negative balance. As payments are
recorded against an order, the balance updates on its own.

The module depends on Commerce's Order and Payment modules (`commerce_order`,
`commerce_payment`). It has **no settings form of its own** — the balance fields
are added automatically the moment you enable it, and the only setup step is
adding the "Balance (Pay later)" gateway if you want to offer it at checkout. It
pairs happily with your regular payment gateways so you can capture the remaining
balance later.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.

There is **no configuration page** for this module. It has no settings form; the
balance fields appear automatically, and the optional payment gateway is added
through Commerce's own Payment gateways screen (described below).

## Where it lives in the admin menu

Commerce Balance adds no admin page of its own. Its two moving parts surface in
existing Commerce screens:

- **The Balance (Pay later) gateway** is added like any other Commerce gateway at
  **Administration → Commerce → Configuration → Payment gateways**
  (`/admin/commerce/config/payment-gateways`). Click **Add payment gateway**,
  choose the **Balance (Pay later)** plugin, give it a label, and save. It runs
  as a *manual* gateway (its mode is "n/a") and requires billing information; it
  deliberately does not create a payment entity at checkout, so it simply lets an
  order be placed with a balance still owing.
- **The computed fields** can be surfaced on your displays: show the order
  **balance** on an order view display via **Manage display**, and show a user's
  outstanding‑balance orders on the user display using the provided formatter.

## How to use it

A common pattern: enable Commerce Balance, add the **Balance (Pay later)**
gateway so customers can check out on account, and keep a standard gateway (card,
etc.) available so the outstanding balance can be captured afterwards. Because
the balance recomputes from totals automatically, staff can watch it settle as
payments are applied — no manual bookkeeping field to keep in sync.
