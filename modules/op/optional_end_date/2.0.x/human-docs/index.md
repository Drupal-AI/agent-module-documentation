# Optional end date — manual setup guide

**Optional end date** (`optional_end_date`) makes the end date of a core **Date
range** field optional. Out of the box, Drupal's Date range field (the `daterange`
type from core's Datetime Range module) always demands both a start *and* an end
value. That is a problem for content like events with no known end, open‑ended
"available from" dates, subscriptions that have started but not finished, or
"published since" ranges. This module lets you save such content with just a start
date.

You turn the behaviour on per field, using a single **"Optional end date"**
checkbox on the field's *Storage settings*. There is no site‑wide admin settings
page — the whole configuration is that one checkbox on each Date range field you
want to relax. When it is ticked, the module quietly rewires the field so the end
date is no longer required: the "End date" form element becomes optional (and is
relabelled **"End date (optional)"**), the validation that forced an end value is
dropped, and the display formatters render just the start date when the end is
empty. Fields you leave unchecked keep core's strict "both dates required"
behaviour.

It works by swapping in its own versions of core's Date range field type, widgets,
and formatters — it does *not* add a new field type you have to choose. So existing
Date range fields simply gain the checkbox; you don't migrate any data. When you
enable the module it also adjusts the database columns of existing Date range
fields so the end‑value column is allowed to be empty.

Optional end date needs only core's **Datetime Range** module and mirrors the
optional‑end‑date behaviour that later shipped in Drupal core — so once you rely on
core's own implementation you can uninstall this module cleanly.

> **Version note (2.0.x):** this branch supports **Drupal 10.3, 11, and 12**
> (`^10.3 || ^11 || ^12`). If you are on Drupal 8, 9, or 10.0–10.2, use the 1.x
> branch instead. Everything you do in the admin UI is the same as in 1.x — the
> 2.0.x changes are internal (the module's hooks were modernised and the display
> code tidied), so this guide applies unchanged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (Datetime Range is required).

## How to use it

Enabling the module alone changes nothing until you opt a field in:

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the Date range field you want to change — **Structure → Content types →
   *your type* → Manage fields → *your Date range field*** — and open its **Field
   settings / Storage settings**.
3. Tick **"Optional end date"** and save.

Because this is a *storage* setting, it applies to every place that field storage
is used across bundles. After saving:

- Editors can fill in only the **start date** and save without a validation error.
- The end‑date form element is still there, but it is optional and labelled **"End
  date (optional)"** — this works with both the default and the "select list"
  (datelist) Date range widgets.
- When the end date is empty, the field's output shows **only the start date** — no
  separator and no blank end date — across the default, plain, and custom Date
  range formatters.

To keep a field strict (both dates mandatory), simply leave its "Optional end date"
box **unchecked**.
