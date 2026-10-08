# Views Year Filter — manual setup guide

**Views Year Filter** (`views_year_filter`) lets a Views date filter match on just a
**year** — a four‑digit `CCYY` value like `2021` — instead of a full timestamp or an
offset from "now". It is the simplest way to build listings such as "content published
in 2023" without hand‑crafting a date range.

The module does not add a brand‑new filter to the "Add filter" dialog. Instead it
quietly upgrades three existing date filters — the core **date** filter (timestamp
fields like *Authored on*, *Updated*, and Scheduler's *Publish on*), the **datetime**
filter (Datetime fields you create in Field UI), and the **Search API date** filter
(when Search API is installed). Each of those filters gains one extra value **Type**
option: **A date in CCYY format.** Pick it, type a year, and the filter compares only
the year part of the field.

Under the hood the query becomes `YEAR(field) = 2023` (or `YEAR(FROM_UNIXTIME(field))`
for timestamp columns), and the "Is between" operator gives you a year range. Smart Date
fields are intentionally left alone so their own year handling keeps working. There is
also a tiny settings form with one option — an optional Bootstrap year datepicker for
exposed year filters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — how the year mode is stored in
the view and the query rewriting — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — using the year filter in a view, and the
   optional datepicker setting.

## Where it lives in the admin menu

The year behavior is configured **per view**, inside the Views UI at
**Structure → Views** (`/admin/structure/views`) — there is no separate global filter.
The one small global setting (the Bootstrap datepicker) lives at
**Configuration → User interface → Views year filter settings**
(`/admin/config/views-year-filter/settings`).
