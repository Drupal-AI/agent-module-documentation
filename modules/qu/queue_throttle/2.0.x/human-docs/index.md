# Queue Throttle — manual setup guide

**Queue Throttle** (`queue_throttle`) provides **throttled (rate‑limited) queue
processing**. It lets you pace how fast Drupal works through a queue's items, which
is exactly what you need when a queue drives something that must not be hammered —
most commonly a rate‑limited third‑party API, but also heavy notification or
indexing work that could otherwise overwhelm the server.

The way it works is command‑driven rather than automatic. When you enable a queue
for throttled processing, that queue **stops running on the default core cron** and
is instead processed by Queue Throttle's own commands, which apply a limit over a
chosen time unit. You typically set up a dedicated cron job to run the throttle, or
you run the Drush commands by hand. It supports both Drush 8 and Drush 9, and it
only works for queues that have a paired QueueWorker.

Because queue items run with the site's own privileges (as all queue processing
does), this is an operations/automation feature — it has no access‑control role of
its own beyond the permission it provides.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** documented for this module — throttled
processing is driven by Drush commands (and a cron job you schedule), described in
"How to use it" below.

## How to use it

Once a queue is enabled for throttled processing (which removes it from the default
core cron run), schedule or run the throttle with Drush:

- `drush queue-throttle` — run the throttle cron across enabled queues.
- `drush queue-throttle-run` — throttle a specific queue by name.

For example, to process up to 10 items of `some_queue` over a 180‑minute window:

```bash
drush queue-throttle-run some_queue --time-limit=180 --items=10 --unit=minute
```

Set up a cron job to call `drush queue-throttle` on the cadence you want, so
throttled queues are processed on schedule instead of by core cron. Remember this
only works for queues that have a matching `QueueWorkerInterface`.
