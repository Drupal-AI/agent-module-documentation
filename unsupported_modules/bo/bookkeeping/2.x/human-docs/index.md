# Bookkeeping — manual setup guide

**Bookkeeping** (`bookkeeping`) is a double‑entry accounting system for Drupal.
It models **accounts** and balanced **transactions** (debits and credits) as
entities, so an organization can keep basic financial books inside Drupal —
often alongside Drupal Commerce. Reporting is built on Views, and figures can be
exported to CSV.

Because this is a double‑entry system, transactions are meant to balance
(debits equal credits), and the data it holds is genuinely sensitive financial
information. The module reflects that with three separate permissions — viewing,
managing, and administering — so you can keep management and administration in
the hands of trusted finance staff while letting others only view.

It depends on Commerce's `commerce_price`, core `views`,
`dynamic_entity_reference`, and `views_data_export`, and supports Drupal 10 and
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Commerce Price and other dependencies) and enable it.
2. [Configuration](configuration/index.md) — the three permissions and where
   accounts, transactions, and reports live.

## Where it lives in the admin menu

The module works through account and transaction entity collections plus
Views‑based reports, and its access is governed by its three permissions at
**People → Permissions** (`/admin/people/permissions`). See
[Configuration](configuration/index.md) for how to set it up.

## How to use it

1. Enable the module and grant its permissions to the right people.
2. Create your **accounts** (the ledger accounts your books are organized
   around).
3. Record **transactions** as balanced debits and credits against those
   accounts.
4. Use the Views‑based reports to review balances, and export to CSV when you
   need the figures elsewhere.
