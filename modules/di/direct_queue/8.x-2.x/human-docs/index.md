# Direct Queue — manual setup guide

**Direct Queue** (`direct_queue`) is a small developer/operations tool that lets you
process a **single** Drupal queue item on demand from the command line, instead of
waiting for cron to work through the queue one item at a time. It exists for sites
where queue work is slow or bursty and you want items handled almost immediately,
and in parallel, rather than serially on cron's schedule.

It works by registering a Drush command, `direct_queue:run`, that takes a queue
item's `item_id` and its `expire` value, finds that exact row in Drupal's core
`{queue}` table, runs the matching queue worker on it, and deletes it on success.
If the worker throws a `SuspendQueueException` the item is released; any other error
is logged and the item is left in place for a later retry. The command is
**CLI-only** — it adds no routes, no permissions, and no web-facing endpoints.

The important thing to understand before installing is that **the module does not
process the queue by itself.** It is one half of a system: it needs an external
backend (a "supervisor" daemon) that watches the queue table and calls
`direct_queue:run` once per item. The project ships a backend written in Go, with
releases for most operating systems; without a backend, the Drush command is just
something you can invoke by hand. This version (`8.x-2.x`) targets Drush; the older
`8.x-1.x` line used Drupal Console.

Note the project is currently marked **seeking a new maintainer**, so weigh that
before adopting it for a critical pipeline.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   understand the backend requirement.

There is **no configuration page** for this module — it has no settings form and no
admin UI. Everything happens through the `direct_queue:run` Drush command driven by
an external backend.

## How to use it

Once enabled, the command is:

```bash
drush direct_queue:run <item_id> <expire>
```

In normal operation you do not type this yourself — your backend daemon discovers
unclaimed items in the queue table and invokes the command once per item, running
as many at a time as you allow. Combine it with core cron, which still cleans up
items whose lease has expired.
