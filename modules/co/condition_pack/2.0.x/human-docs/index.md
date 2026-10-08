# Condition Pack — manual setup guide

**Condition Pack** (`condition_pack`) is a small collection of extra *visibility
conditions* for blocks. Drupal core lets you show or hide a block based on
things like the current path, content type, or user role; Condition Pack adds
three more useful axes: simple A/B testing, dates and days of the week, and
times of day and timezones. Once enabled, its conditions appear alongside the
core ones in the **Visibility** section of any block's configuration form.

The module is a *pure plugin provider* — it has no settings pages of its own and
adds no admin menu items. You never configure Condition Pack itself; you pick its
conditions when you place or edit a block. It is split into three submodules so
you can enable only the conditions you actually need, and each one depends on
core's **Options** module (Drupal enables that automatically for you).

One thing worth knowing up front: A/B and time-based conditions naturally vary
what a page shows from one request to the next, which reduces how aggressively
that page can be cached. The conditions declare the right cache metadata, but it
is worth checking performance on heavily cached pages after you add them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   submodule(s) that provide the conditions you want.

There is **no configuration page** for this module. You use its conditions
directly from a block's **Visibility** settings, described below.

## How to use it

1. Enable the submodule that provides the condition you need (see
   [Installation](installation/index.md)).
2. Go to **Structure → Block layout** (`/admin/structure/block`) and edit or
   place a block.
3. In the block form, open the **Visibility** tab. The new conditions appear as
   extra vertical tabs:
   - **A/B conditions** (`condition_pack_ab`) — show the block to a random slice
     of requests, e.g. 30% of page views, for simple A/B testing.
   - **Date conditions** (`condition_pack_date`) — show before a date, on or
     after a date, or only on specific days of the week.
   - **Time conditions** (`condition_pack_time`) — show only within a time-of-day
     window, or match a timezone.
4. Configure the condition and **Save block**. The block now honours the rule.
