# Date Range Formatter — manual setup guide

**Date Range Formatter** (`date_range_formatter`) is a flexible field formatter for
core **date‑range** fields. A stored range like "10 June 2026 – 12 June 2026" is
rarely what you want to show verbatim: a single‑day event should read "10 June
2026", not "10 June 2026 – 10 June 2026", and a range within one month often reads
best as "10–12 June 2026". Core's date‑range formatter is rigid about this;
matching the natural, human way of writing a range usually means a custom formatter
or a Twig template. This module turns those choices into configuration on the
field's display.

It lets you format the start and end **separately**, **collapse a same‑day range**
to a single date, and choose the **separators** between the parts — so the same
field can render clean output for events, exhibitions, opening periods, or
availability windows. It's purely a display formatter: it changes how the stored
range renders, never the underlying data, which makes it low‑risk and broadly
useful. Its only dependency is core's **Datetime Range** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Datetime Range.

There is **no separate configuration page** — all the options live on the field's
*Manage display* formatter settings, described below.

## How to use it

1. Make sure you have a **date‑range** field (type *Date range*, from core's
   Datetime Range module) on your content type or other entity.
2. Go to that entity's **Manage display** (for example **Structure → Content types
   → *(type)* → Manage display**).
3. Set the date‑range field's **Format** to **Date Range Formatter**.
4. Click the settings gear and configure it to match your locale and house style:
   - choose the date/time format for the **start** and **end**,
   - set how a **same‑day** range should collapse to a single date,
   - and choose the **separator** used between the two ends of the range.
5. Save. The field now renders ranges the natural way wherever that display is
   shown.
