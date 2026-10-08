# Dynamic Queues — manual setup guide

**Dynamic Queues** (`dynamic_queues`) is a developer‑oriented tool for spreading a
large volume of queued work across many smaller, **capacity‑limited sub‑queues**
instead of piling everything into one giant queue. You give it a queue "type" name
and a maximum item count; as you push items in, it fills a sub‑queue up to that
limit, then automatically rolls over to the next one — producing auto‑named queues
like `dynamic_queues:content_queue_queue_0`, `..._queue_1`, and so on. An
inspection dashboard lets you look inside a chosen queue and see the items waiting
in it.

The problem it addresses is unbounded queues. When thousands of items accumulate in
a single Drupal queue, processing and monitoring get awkward. By capping each
sub‑queue and creating new ones as needed, Dynamic Queues keeps each unit of work a
predictable size and makes it easy to see how much is outstanding.

This is **not a point‑and‑click feature** — it's a scaffold you drive from code.
You enable it, set the maximum queue limit on its settings form, then call a small
helper from your own module to enqueue items; Drupal's cron (or `drush queue:run`)
processes each sub‑queue through the module's bundled queue worker. It depends only
on Drupal core and targets Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the per‑queue limit, enqueue items
   from code, and use the dashboard.

## Where it lives in the admin menu

The settings form is at `/admin/dynamic-queues/config` (it requires the *Access
administration pages* permission). The inspection dashboard is at
`/admin/dynamic-queues/lists`. See [Configuration](configuration/index.md) for how
to use both, and for an important caution about the dashboard's access.
