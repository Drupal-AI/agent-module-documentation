<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce Push Queue UI exposes the Salesforce Suite's `salesforce_push_queue` database table to Views and ships a ready-made admin view for inspecting stuck or failing push items. It adds per-row operations (and VBO-style bulk actions) to reset an item's failure count or claim expiration so it gets retried on the next cron run.

---

The Salesforce Suite (`salesforce_push`) queues entity pushes in a plain database table, `salesforce_push_queue`, which has no UI of its own — items that fail repeatedly simply stop being processed and are invisible outside the database. This module implements `hook_views_data()` for that table, declaring every column (`item_id`, `name` = mapping id, `entity_id`, `mapped_object_id`, `op`, `failures`, `last_failure_message`, `expire`, `created`, `updated`) as a Views field/sort/filter/argument, plus a relationship from `mapped_object_id` to the `salesforce_mapped_object` base table. Four Views plugins are added: a `salesforce_push_queue_mapping_name` filter that builds a select list of the mapping ids actually present in the queue, a `salesforce_push_queue_timestamp` field for human-readable dates, a `salesforce_push_queue_expire` field that colours the lease expiry red/green depending on whether it has passed, and a `salesforce_push_queue_operations` field rendering per-row links. Those links hit two controller routes — `/admin/content/salesforce-push-queue/reset-failures/{item_id}` and `.../reset-expiration/{item_id}` — which directly `UPDATE` the queue row to clear `failures`/`last_failure_message` or to zero `expire`; both require the `administer salesforce` permission and a CSRF token, and redirect back to the view via `destination`. A default view (`views.view.salesforce_push_queue`) is installed with the module. `hook_views_pre_render()` strips the repetitive "Queue item %item failed %fail times…" prefix from failure messages so the column shows only the underlying Salesforce error. The module defines no permissions, no config schema, and no Drush commands of its own.

---

- See every pending Salesforce push item in one admin screen instead of querying the database.
- Find out why a specific entity never reached Salesforce by reading its last failure message.
- Reset the failure counter on an item that hit the `salesforce_push` retry limit so it is retried.
- Zero a stale claim lease (`expire`) so a stuck item becomes claimable on the next cron run.
- Bulk-reset failures across dozens of items after fixing a bad field mapping.
- Bulk-clear expirations after a Salesforce outage so the whole backlog reprocesses.
- Filter the queue by mapping name to see only pushes for one Salesforce object type.
- Filter by operation (`create` / `update` / `delete`) to isolate delete syncs that are failing.
- Spot expired vs. still-leased items at a glance via the red/green expiry indicator.
- Sort by failure count to find the worst-offending records first.
- Follow the relationship to `salesforce_mapped_object` to see which Salesforce record an item maps to.
- Build a custom view of the queue (e.g. a dashboard block of failures in the last 24 hours).
- Add an exposed filter on `entity_id` to trace pushes for one specific node or user.
- Expose the queue as a Views REST/JSON export for external monitoring.
- Give a Salesforce admin a queue screen without granting database access.
- Verify that a newly configured mapping is actually enqueuing pushes.
- Confirm the queue drains after enabling cron-based push processing.
- Audit how long items sit in the queue by comparing `created` and `updated`.
- Detect a mapping whose items are re-enqueued endlessly (high `failures`, recent `updated`).
- Use the operations links from a custom view by adding the `Operations` field to it.
