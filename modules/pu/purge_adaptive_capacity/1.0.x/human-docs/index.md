# Purge Adaptive Capacity — manual setup guide

**Purge Adaptive Capacity** (`purge_adaptive_capacity`) makes the **Purge** cache
system smarter about how much work it does each cron run. Out of the box, Purge
processes its invalidation queue in fixed‑size chunks (often 100 items per cron
run, set by the active purger). On busy sites, cache invalidations can pile up
faster than that fixed rate can clear them — or a delayed cron lets the queue
grow — and the backlog never catches up.

This module fixes that by **scaling the per‑cron processing limit with the queue
size**: when the backlog grows toward a high‑watermark you set, it processes more
items; when the queue shrinks, it processes fewer (never below a floor you set).
That keeps the queue under control during spikes without permanently
over‑processing during quiet periods.

A few things worth knowing:

- It's **purger‑agnostic** — it decorates Purge's capacity tracker, so it works
  with any purger you've configured.
- It **respects Purge's execution‑time safeguards** — the scaled number is an
  upper bound, not a way to blow past Purge's own limits.
- It can be **switched off** to fall back to the standard purger capacity.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Purge dependency.

The module's tuning is done on one small settings page (see below), covered under
"How to use it".

## Where it lives in the admin menu

After enabling, the settings sit at **Administration → Configuration →
Development → Performance → Purge adaptive capacity**
(`/admin/config/development/performance/purge-adaptive-capacity`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Development → Performance → Purge adaptive capacity**.
3. Set the three values that drive the scaling:
   - **Minimum items** — the hard floor of items processed per cron run (the
     module enforces a minimum of 100). The limit never drops below this.
   - **Maximum items** — the ceiling of items processed per cron run when the
     backlog is at or above the high‑watermark.
   - **Queue high‑watermark** — the queue size at which processing reaches the
     maximum.
4. Save. From then on, each cron run processes a number of items scaled between
   your minimum and maximum according to how full the queue is. The formula is:
   `limit = min_items + (max_items − min_items) × min(1, queue_size ÷
   queue_high_watermark)`.

To revert to Purge's standard fixed capacity, disable the adaptive behavior in
these settings.
