# Multiple Time Clock (MTC) — manual setup guide

**Multiple Time Clock** (`mtc`) displays several clocks side by side, each showing
the current time in a different time zone. It is handy for offices, teams, or
audiences spread across the world — a header or sidebar that shows, at a glance,
what time it is in your London, New York, and Singapore locations, for example.

The module provides a **block** plus an admin config area where you set up the
clocks. You add one entry per time zone, and each clock can use one of five
built‑in **skins**, so you can match the look to your theme. It has no external
JavaScript or PHP library dependencies — everything it needs ships with the
module.

It is a purely presentational, content‑display feature: the zones are configured by
an administrator and it plays no role in content access or permissions. Setup is a
two‑part job — configure your clocks, then place the block in a region.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings form on the Configuration overview** for this
module in the usual sense — instead you configure the clocks at the module's own
admin path and then place its block, both described in "How to use it" below.

## Where it lives in the admin menu

The clock settings live at `/admin/config/multiple_timezone_clock`, and the block
is placed from **Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Go to `/admin/config/multiple_timezone_clock`.
2. Fill in the settings for your first clock (choose the country / time zone under
   the clock fieldset), and click **Add one more** to add another clock. Repeat for
   each zone you want to display, and save.
3. Go to **Structure → Block layout** (**Admin menu → Structure → Block layout**).
4. Find the region where you want the clocks (for example a header or sidebar) and
   click **Place block** for that region.
5. In the dialog, click **Place block** next to **Multiple Timezone Clock**.
6. Configure the block's visibility if needed, then **Save block**.

Your configured clocks now appear in that region, each ticking in its own time
zone.
