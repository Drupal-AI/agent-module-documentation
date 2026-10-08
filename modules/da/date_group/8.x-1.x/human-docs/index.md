# Date Group — manual setup guide

**Date Group** (`date_group`) is a field formatter for **date‑range** fields that
collapses the repeated parts of a start and end date into one readable string.
Core renders a range as two full dates with a separator — correct, but clumsy:
"12 March 2026 09:00 – 12 March 2026 17:00" repeats the whole date just to say the
event is on one day, and "12 March 2026 – 15 March 2026" repeats the month and
year to say it spans a few days. Date Group merges the common parts, so the same
ranges read the way a person would write them — "April 21–28, 2016", "May 05 –
June 06, 2016", or across years "August 27, 2016 – May 14, 2017".

You use it by choosing the **Date Group** format for a date‑range field on its
*Manage display*, then picking a date format to render with. The maintainers
recommend a **date‑only** format (no time), since the whole idea is to group
dates. It's a display‑only formatter — it changes how the stored value renders,
never the data itself — which makes it low‑risk and useful anywhere you show event
dates, opening periods, exhibition runs, booking windows, and the like. It depends
on core's **Datetime Range** module.

This is a **beta** release (8.x‑1.0‑beta4). A few things determine whether the
collapsed output is actually correct, and they're worth keeping in mind: the
comparison should happen in the display timezone rather than UTC (or a late‑night
event can look like two days), all‑day events are a distinct case that a date‑only
format handles best, and the "house style" of a collapsed range is
language‑specific — so review the output on a multilingual site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Datetime Range.

There is **no configuration page** — you configure the formatter per field on its
*Manage display*, as described below.

## How to use it

1. Make sure you have a **date‑range** field (a field of type *Date range*,
   provided by core's Datetime Range module) on your content type or other entity.
2. Go to that entity's **Manage display** (for example **Structure → Content types
   → *(type)* → Manage display**).
3. For the date‑range field, set the **Format** to **Date Group**.
4. Click the settings gear and choose the **date format** to render with — a
   format containing only the date (no time) is recommended so the dates group
   cleanly.
5. Save. The field now renders as a single collapsed range wherever that display
   is shown.
