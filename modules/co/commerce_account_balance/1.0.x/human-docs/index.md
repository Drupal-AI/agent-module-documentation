# Commerce Account Balance — manual setup guide

**Commerce Account Balance** (`commerce_account_balance`) shows, on a Drupal
Commerce order page, how much a customer still **owes** across all of their
orders. It reads Commerce core's per‑order *balance* (order total minus the
amount paid), finds every order tied to the same customer email, and adds those
balances together. In other words it is an "amount owed" / accounts‑receivable
view to help you collect money — not a spendable store‑credit wallet.

The typical reason to reach for it is to see, at a glance, the total a customer
owes when one email is attached to several unpaid or partly‑paid orders. It works
by adding an *Account Balance* link and a summary table to the order view, and it
can optionally show the owed amount converted into other currencies if the
`currencyapi` module is installed. It depends on Drupal Commerce, Commerce Price,
and core User, and sits in the Commerce package.

> **Maturity note.** The module also ships an *Account Balance* block, an
> *AccountBalance* entity, and a balance‑adjustment form, but on the current
> release these are incomplete or inactive (the block and entity are unfinished,
> the adjustment form is commented out, and a large body of Drupal 7 code in the
> module does not run on Drupal 10/11). Treat the working feature as the
> "amount owed across orders" display described above.

Because the figures are financial, the module is **permission‑gated**. Three
permissions govern it — `view account balance` (the own‑balance block),
`view any account balance` (used when deciding whether to show the balance link),
and `administer account balances` (the balance summary route at
`/account/balance/{order}`). Grant the last two only to trusted staff. There is
no separate settings form; setup is really about enabling the module and
assigning those permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and assign the balance permissions.

There is no dedicated configuration form for this module, so there is no
Configuration page in this guide. What little "configuration" it needs is
permission assignment, covered at the end of Installation.

## Where it lives in the admin menu

Commerce Account Balance adds no top‑level settings page of its own. You manage
who can use it from **People → Permissions**
(`/admin/people/permissions`), and its balance information appears on Commerce
order view pages under **Commerce → Orders**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On **People → Permissions**, grant `administer account balances` and
   `view any account balance` to your staff/administrator roles only.
3. Open an order under **Commerce → Orders** for a customer whose email has an
   outstanding balance; an **Account Balance** section/link appears, and the
   balance route shows a table of that customer's orders and what each still owes.
