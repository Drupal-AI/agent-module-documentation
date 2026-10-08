Queue UI adds an admin interface and Drush commands for viewing, processing, releasing, inspecting, and clearing the queues Drupal core creates through the Queue API.

---

Queue UI provides a "Queue manager" overview at **Admin → Configuration → System → Queue manager** (`/admin/config/system/queue-ui`) that lists every registered queue worker with its title, machine name, number of items, backing queue class, and cron time limit. From the overview you select one or more queues and apply a bulk action: **Batch process** (run the worker over its items via the Batch API), **Remove leases** (reset lease timestamps so stuck/claimed items become available again), or **Clear** (delete all items after a confirmation step). Per-queue operations link to a **Cron settings** form (adjust the cron time limit per worker) and, when a `QueueUI` inspection plugin matches the queue's backend class, an **Inspect** view that lists individual items and lets you view item data, release a single item, or delete a single item. Inspection is built on a plugin system: the module ships a `DatabaseQueue` plugin for core's database queue, and other modules can add plugins for custom backends (Redis, SQS, etc.) by implementing `QueueUIInterface` and tagging the class with the `QueueUI` attribute/annotation whose `class_name` matches the backend. A `queue_ui.features` state flag enables optional "Derivatives Grouping" so derivative queues are grouped by their main worker ID; the companion `queue_order` module (a dev/suggested dependency) adds drag-and-drop weighting. Drush commands (`queue:process`, `queue:process-all`, `queue:release`, `queue:release-all`) cover the same processing and lease actions from the command line. Everything is gated by a single `admin queue_ui` permission. The module requires no other modules and stores no configuration of its own.

---

- Open the Queue manager overview to see all registered queues and how many items each holds.
- Manually run (batch process) a specific queue instead of waiting for cron.
- Batch process several selected queues at once from the overview.
- Process all queues from the command line with `drush queue:process-all`.
- Process a single named queue from the command line with `drush queue:process my_queue`.
- Reset stuck leases so items claimed by a crashed/aborted worker become processable again.
- Release leases on every queue at once via `drush queue:release-all`.
- Clear (delete all items from) a queue that has bad or obsolete data.
- Inspect the individual items sitting in a core database queue.
- View the serialized data payload of a single queue item before acting on it.
- Delete one problematic item from a queue without clearing the whole queue.
- Release the lease on a single claimed item.
- Adjust the cron time limit for a specific queue worker via its Cron settings form.
- See which backend class (e.g. `DatabaseQueue`) is serving each queue.
- Diagnose why a queue is not draining by checking item counts and lease state.
- Add inspection support for a custom queue backend (Redis, SQS) with a `QueueUI` plugin.
- Group derivative queues under their main worker via the Derivatives Grouping feature.
- Drag-and-drop reorder queue processing weight when the `queue_order` module is installed.
- Give a single role queue-management access with the `admin queue_ui` permission.
- Quickly empty a test/dev queue during development.
- Script queue processing in deployment or maintenance routines using the Drush aliases (`qp`, `qpa`, `qr`, `qra`).
- Confirm a queue worker plugin is registered and picking up items.
- Recover a queue after a failed cron run by releasing leases and reprocessing.
- Manage queues created by other contrib modules (search indexing, migrations, webhooks) from one screen.
