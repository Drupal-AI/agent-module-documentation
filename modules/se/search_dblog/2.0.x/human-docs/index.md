# Database Logging Search Field — manual setup guide

**Database Logging Search Field** (`search_dblog`) adds a search box to Drupal's
core Database Logging (dblog) report. Instead of paging through the recent log
messages one screen at a time, you can type a keyword and jump straight to the
entries that match — a small but genuinely useful convenience when you are hunting
for a specific error or event in a busy log.

The problem it solves is simple: the core **Reports → Recent log messages** page
lists entries but gives you no way to search them by keyword. This module fills
that gap by adding a search field to that report. It depends only on core's
**Database Logging** (`dblog`) module and works the moment you enable it — there
is nothing to configure.

Access is unchanged: who can see the log report is still governed by core's
existing **Access site reports** (`access site reports`) permission. This module
adds a search box; it does not change who can view logs, and it has no
access-control role of its own.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no separate settings page. Once enabled, the search box appears directly
on the core log report at **Reports → Recent log messages**
(`/admin/reports/dblog`). Type a keyword there to filter the log entries.
