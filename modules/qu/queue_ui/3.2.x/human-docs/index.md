# Queue UI — manual setup guide

**Queue UI** (`queue_ui`) adds an admin interface — and matching Drush commands —
for the queues Drupal creates through its Queue API. Drupal core has plenty of
background queues (search indexing, migrations, webhooks, and anything contrib
modules register), but core gives you no screen to see or manage them. Queue UI
fills that gap: a single **Queue manager** page lists every registered queue and
lets you process, inspect, and clean them up.

From the overview you can see each queue's item count and backing class, then run
a queue manually with the Batch API instead of waiting for cron, **remove leases**
to free items that a crashed worker left claimed, or **clear** a queue entirely.
When a queue's backend is supported by an inspection plugin (core's database queue
is supported out of the box), you also get an **Inspect** view to look at
individual items, view their data, and release or delete them one at a time. You
can also adjust the per‑queue cron time limit.

Queue UI requires no other modules and stores **no configuration of its own** — it
operates directly on core's queues. It provides a single **admin queue_ui**
permission, a `queue_ui` inspection plugin type (so developers can add support for
custom backends like Redis or SQS), and Drush commands for processing and
releasing queues from the command line. An optional companion module,
`queue_order`, adds drag‑and‑drop weighting when installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the Queue manager screen, the bulk
   actions, per‑queue cron settings, and inspection.

## Where it lives in the admin menu

The Queue manager lives at **Configuration → System → Queue manager**
(`/admin/config/system/queue-ui`). Everything Queue UI does is reached from there.
Access is gated by the single **admin queue_ui** permission.

## How to use it

1. Go to **Configuration → System → Queue manager** to see all registered queues
   with their item counts.
2. Select one or more queues and pick a bulk action — **Batch process**, **Remove
   leases**, or **Clear**.
3. Use a queue's **Cron settings** link to tune its cron time limit, or its
   **Inspect** link (when available) to view and act on individual items.
4. Or drive the same actions from the CLI with `drush queue:process`,
   `drush queue:process-all`, `drush queue:release`, and `drush queue:release-all`.

See [Configuration](configuration/index.md) for details.
