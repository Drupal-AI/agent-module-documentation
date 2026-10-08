# Granular Time Cache — manual setup guide

**Granular Time Cache** (`granulartimecache`) solves a specific caching problem:
how to cache content whose freshness is tied to the **clock** rather than to an
edit. It provides **cache tags that invalidate at time boundaries** — for example
a tag that expires exactly at midnight — so you can keep a page cached and still
have it refresh at the right moment.

The classic example is an **event calendar** that only shows events whose date is
in the future. Making that view uncacheable is bad for performance, and a plain
`max-age` doesn't line up with the calendar day. What you actually want is a cache
tag that invalidates precisely at midnight — which is exactly what this module
provides. Pair it with the **Views Custom Cache Tags** module to attach the tag to
a time‑sensitive view.

The module defines several granularity tags:

- **hourly**
- **daily**
- **monthly**
- **hourly_exact** — included mainly for illustration: it always lasts a full 60
  minutes, whereas `daily` can last 25 hours on days when the clocks change (DST).

Developers can implement a hook to add further granularity tags if needed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module — it provides cache tags for other
modules and your own code to use.

## How to use it

1. Enable Granular Time Cache.
2. Attach the appropriate tag (e.g. `granulartimecache:daily`) to the render array
   or view whose freshness depends on the clock. The
   [Views Custom Cache Tags](https://www.drupal.org/project/views_custom_cache_tag)
   module is the easiest way to add the tag to a view.
3. The cached output then invalidates automatically at the chosen boundary — for
   `daily`, at midnight.

## Limitation: time zone

For the calendar‑based tags, the module uses a **single time zone** — the site
default set at `admin/config/regional/settings` (or the cron user's time zone if
"time zone by user" is enabled). It does not currently produce per‑time‑zone tags.
