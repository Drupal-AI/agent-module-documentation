# Commerce Funds — manual setup guide

**Commerce Funds** (`commerce_funds`) turns a Drupal Commerce site into a system
with **user wallets**. Each user gets an account balance they can deposit money
into, transfer to other users, hold in escrow, and spend on products, and they
can send withdrawal requests to administrators to cash out. It works with
multi-currency stores and can convert one currency into another.

For customers it provides a balance to deposit into, peer-to-peer transfers,
escrow payments that are released in due time, withdrawal requests, and the
ability to pay for any product on the site from their balance — plus views of all
their transactions and escrow payments. For administrators it adds configurable
transaction **fees** (fixed, percentage, or percentage-with-minimum), manageable
**withdrawal methods**, editable **email notifications**, approval/decline of
withdrawal requests, a site-balance overview, and integration with Commerce
Exchanger (exchange rates), Encrypt (to protect stored withdrawal details) and
Rules.

Because this module moves real money between accounts, treat it as financial
software. Deposits, transfers and withdrawals are money-handling operations:
restrict the funds permissions tightly, require administrator approval for
withdrawals, keep the transaction log enabled and reconcile it, and test the
deposit/withdraw/transfer/escrow flows against adversarial cases before you run
real value through it. It depends on the core Commerce stack (Commerce, Checkout,
Order, Payment, Product, Store) and runs on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.
2. [Configuration](configuration/index.md) — set up fees, withdrawal methods,
   notification emails, and the user-facing operations.

## Where it lives in the admin menu

Commerce Funds adds its administration under the Commerce section of the admin
menu, where you manage fees, withdrawal methods, notification messages, pending
withdrawal requests, and the various transaction views. User-facing operations
(balance, deposit, transfer, escrow, withdraw) are exposed through blocks and
routes, and there is a per-user balance block for profile pages. See
[Configuration](configuration/index.md) for how to set these up.
