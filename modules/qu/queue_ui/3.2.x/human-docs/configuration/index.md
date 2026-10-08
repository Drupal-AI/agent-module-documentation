# Configuration

Queue UI has **no configuration object of its own** — it works directly on the
queues that Drupal's Queue API registers. "Configuring" it really means using the
**Queue manager** screen to manage those queues. Everything here requires the
**admin queue_ui** permission.

## Open the Queue manager

Go to **Configuration → System → Queue manager**
(`/admin/config/system/queue-ui`). You'll see a table of every registered queue
worker with these columns:

- **Title** and **Machine name** of the queue.
- **Number of items** currently waiting.
- **Class** — the backend serving the queue (for example `DatabaseQueue`).
- **Cron time limit** — how long cron may spend on this queue per run.
- **Operations** — per‑queue links (see below).

## Bulk actions

Tick one or more queues, choose an **Action**, and apply it:

- **Batch process** — run the queue's worker over its items now, using the Batch
  API, instead of waiting for cron.
- **Remove leases** — reset lease timestamps so items that were claimed by a
  crashed or aborted worker become available for processing again.
- **Clear** — delete all items from the selected queues. This asks for
  confirmation first.

## Per‑queue operations

Each row's **Operations** column can include:

- **Cron settings** — a small form to adjust the **cron time limit** for that one
  queue worker.
- **Inspect** — appears only when a matching inspection plugin exists for the
  queue's backend class (core's database queue is supported out of the box). The
  inspect view lists individual items; from there you can **view** an item's data
  payload, **release** a single item's lease, or **delete** a single item without
  clearing the whole queue.

## Queue Manager Features

The overview has a **Queue Manager Features** section with an optional
**Derivatives Grouping** toggle, which groups derivative queues under their main
worker ID for a tidier list. This is stored as a state flag, not exported
configuration.

If the optional **`queue_order`** module is installed, a drag‑and‑drop **Weight**
column also appears so you can reorder queue processing.

## Command line

The same processing and lease actions are available as Drush commands, handy for
deployment or maintenance scripts:

- `drush queue:process my_queue` — process a single named queue.
- `drush queue:process-all` — process all queues.
- `drush queue:release my_queue` — release leases on a queue.
- `drush queue:release-all` — release leases on every queue.

(Short aliases `qp`, `qpa`, `qr`, and `qra` are also available.)
