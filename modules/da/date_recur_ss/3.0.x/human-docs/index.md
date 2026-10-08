# Date Recur SS — manual setup guide

**Date Recur SS** (`date_recur_ss`) provides an alternative **interpreter** for the
**Recurring Dates Field** (`date_recur`) module. In Date Recur, an "interpreter" is
the component that turns a machine RRULE recurrence rule into a human‑readable
sentence — something like *"Every second Tuesday"* — for display next to a
recurring date. This module adds a second interpreter with a different rendering
implementation, so you can pick the wording that best suits your locale or house
style.

It's a pure display/formatting add‑on: it takes a set of recurrence rules and
returns a readable string, with no database access, no routes, no permissions, and
no external calls. Because it's a plugin, Date Recur discovers it automatically
once the module is enabled — you then select it in Date Recur's interpreter
configuration and assign that interpreter to your recurring‑date field's formatter.
Multiple interpreters can coexist, so you can choose per formatter which one to
use. It depends on **Recurring Dates Field** (`date_recur`) 3.2+ and requires PHP
8.0+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Recurring Dates Field.

There is **no configuration page of its own** — you set it up through Date Recur's
existing interpreter UI, as described below.

## How to use it

1. Make sure the **Recurring Dates Field** (`date_recur`) module is installed and
   you have a recurring‑date field.
2. In Date Recur's **interpreter** configuration, create or edit an interpreter and
   choose the **SS** (`ss`) interpreter plugin provided by this module.
3. On your recurring‑date field's **display formatter** settings, assign that
   interpreter so its wording is used when the recurrence rule is shown.
4. Save and view content — the recurring rule now renders using this interpreter's
   phrasing. Use it whenever the default Date Recur interpreter's wording doesn't
   suit your locale or style.
