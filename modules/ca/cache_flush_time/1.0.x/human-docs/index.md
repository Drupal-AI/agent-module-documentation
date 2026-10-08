# Cache Flush Time — manual setup guide

**Cache Flush Time** (`cache_flush_time`) is a small developer/ops convenience that
**prints when Drupal's cache was last rebuilt**. It shows the timestamp of the most recent
cache clear/rebuild so you can quickly verify the site's cache state — handy after a
deployment or when you want to confirm a cache flush actually happened.

It is deliberately tiny: it depends only on core **System**, displays a single timestamp,
and has no content and no access‑control role of its own. There is nothing to configure —
the module does its one job once enabled.

Because the flush time is an operational detail, expose it only where that is appropriate
for your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — it has no settings form. Enabling it
is the entire setup.

## Where it lives in the admin menu

Cache Flush Time adds no admin settings page. It simply makes the last cache‑rebuild time
available once enabled; where the timestamp surfaces is a matter of that operational
detail, so treat it as something to show only where appropriate.
