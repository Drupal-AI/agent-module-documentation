# Date Range Simplify — manual setup guide

**Date Range Simplify** (`daterange_simplify`) is a **field formatter** for core
Datetime Range fields that renders a range more concisely by collapsing the parts
the start and end dates share. Instead of printing "1 June 2026 – 30 June 2026" in
full, it can render "1–30 June 2026" — and it makes the equivalent reduction when
only the month, or only the year, is shared.

It is a purely presentational module: it changes how a daterange field is
*displayed*, not the value stored in the database and not who can see it. Use it
anywhere date ranges appear — events, opening times, availability windows — and
the default verbose formatter reads repetitively. Under the hood it wraps the
[flack/ranger](https://github.com/flack/ranger) library and exposes a simplified
set of date/time output options based on PHP's `IntlDateFormatter` styles (full,
long, medium, short, or none for each of the date and time parts).

One requirement worth flagging up front: for any locale other than English,
Ranger needs the PHP **`intl`** extension installed on the server. English output
works without it.

The module works as soon as it is enabled — it adds a new formatter you select on
a Datetime Range field's display settings. There is no central settings page; all
the options live on the field's *Manage display* screen for each view mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You choose the formatter and
its date/time style options per view mode on the field's *Manage display* tab.

## Where it lives in the admin menu

Date Range Simplify adds no admin page. You use it from **Structure → Content
types → *(your type)* → Manage display**: find your Datetime Range field, change
its **Format** to the Date Range Simplify formatter, then click the gear icon to
choose how detailed the date and time parts should be.
