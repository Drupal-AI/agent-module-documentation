# Expense Tracker — manual setup guide

**Expense Tracker** (`expense_tracker`) — full name *Expense Income Tracker* —
adds a complete, self‑contained financial‑management layer to a Drupal 10 or 11
site. You record income and expense transactions through a clean admin form or by
uploading a file, then explore the data through interactive charts, tabular
statements, and a filterable admin list — all without leaving the Drupal admin
interface. It suits a personal budget, a small‑business cash‑flow tracker, a
corporate expense‑reporting portal, or a multi‑user financial intranet.

Transactions are stored as a proper fieldable content entity (`et_transaction`),
so they inherit the full Drupal toolkit: you can attach fields, use view modes,
translate them, give them URL aliases (Pathauto), publish/unpublish them, and
build Views on them. Each transaction is classified as **income** or **expense**,
can belong to a **category** hierarchy (top‑level categories with child entries
that reports group and total automatically), carries free‑text notes, and gets its
own comment thread. There's also a **cron‑driven recurring** system for
transactions that repeat on a schedule, and a **bulk import** that accepts CSV,
JSON, XML, and XLSX files (with duplicate detection and downloadable sample
files). A six‑endpoint **REST API** lets decoupled frontends and third‑party
accounting systems read and write transactions under the same access rules as the
UI.

A word on security. Financial records are **personal, sensitive data**. Expense
Tracker provides its own permissions — use them (together with core access) to
restrict who can view and manage transactions. Because it exposes a REST API that
can use **Basic Auth**, make sure the REST resources are properly permission‑gated
and served only over **HTTPS**, so credentials and financial data are never sent in
the clear. The module depends on core **Views**, **REST**, and the contributed
**Views Bulk Operations** module, and it also builds on core **Comment**, **Path**,
**Serialization**, and **Basic Auth**. It has zero external PHP dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which pulls in
   Views Bulk Operations), enable it, and set permissions.

The module has **no single settings form**; you work with it through its admin
list, add/import forms, and reports, described below. Access is governed by its
permissions rather than a configuration page.

## Where it lives in the admin menu

Once enabled, Expense Tracker's tools live in the admin interface:

- The **transaction list**, add form, and reports/charts are reached from the
  admin content area (the module builds these with Views and its own entity UI).
- **Bulk import** is at **Content → Import Transactions**, where you can also
  download the bundled sample `.csv`, `.json`, `.xml`, and `.xlsx` files.
- Permissions are set under **People → Permissions**.

## How to use it

1. **Grant permissions first.** Under **People → Permissions**, give the
   appropriate roles the module's permissions to view and manage transactions.
   Because the data is sensitive, keep these tight — grant them only to roles that
   genuinely need financial access.
2. **Add transactions.** Use the add form to record an income or expense entry:
   set its type, amount, category, and any notes. To create a category, add a
   top‑level "category" transaction (e.g. *Monthly Rent*, *Salary*) and attach
   child entries to it — reports group and total children by category
   automatically.
3. **Set up recurring entries (optional).** On the add/edit form, tick **Repeat
   this transaction** and pick a frequency (daily, weekly, monthly, yearly,
   working days, specific weekdays, or specific days of the month) and an end
   date. Cron then auto‑generates the copies, each tagged as automatically created
   and linked back to its source.
4. **Import in bulk (optional).** Go to **Content → Import Transactions**, download
   a sample file if you need the format, then upload a CSV, JSON, XML, or XLSX
   file. Rows are processed with Drupal's Batch API, and re‑importing the same file
   is safe thanks to duplicate detection.
5. **Review.** Explore the interactive charts, tabular statements, and the
   filterable admin list. Unpublished transactions are excluded from reports,
   charts, and API responses.
6. **Use the REST API (optional).** If you're building a decoupled frontend or
   integrating another system, the six REST endpoints read and write transactions
   under the same permissions — expose them over HTTPS only.
