# Block Visibility Days — manual setup guide

**Block Visibility Days** (`block_visibility_days`) extends Drupal's built‑in
block visibility settings with rules based on **days and dates**. Core lets you
show or hide a block by page, role or content type; this module adds the missing
time dimension, so a block can appear only on certain days of the week or only
within a date range.

That makes it handy for scheduled content — a promotional banner that runs only
on weekends, a notice that shows during a campaign window, or an announcement
that switches off automatically once a date passes — without you having to
remember to place and remove the block by hand.

It is a site‑building enhancement that controls **display only**: it decides when
a block is *shown*, not who is allowed to reach the underlying content. It works
on Drupal 8 through 11 and has no dependencies beyond core's Block system.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the day/date rules appear wherever you already configure block
visibility:

1. Go to **Structure → Block layout** (`/admin/structure/block`) and place a new
   block, or click **Configure** on an existing one.
2. In the block's configuration form, open the **Visibility** settings and find
   the **Days** condition this module adds.
3. Choose the day(s) of the week and/or the date range during which the block
   should be visible, then save.

Remember this only affects whether the block is *displayed*; it is not an
access‑control mechanism for the content itself.
