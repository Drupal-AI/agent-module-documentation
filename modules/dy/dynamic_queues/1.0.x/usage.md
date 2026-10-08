<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dynamic Queues splits Drupal queue items into uniquely-named, capacity-limited sub-queues with an inspection dashboard.

---

Dynamic Queues generates uniquely-named sub-queues (`dynamic_queues:<type>_queue_<n>`) so a large volume of queued work can be spread across many queues that each hold up to a configured maximum before a new one is spun up.

The module exposes a settings form (`/admin/dynamic-queues/config`, `access administration pages`) for the per-queue maximum item limit, a QueueWorker plugin plus a derivative that reports each dynamic queue's length, and a dashboard controller that lists the items inside a chosen queue. Helper methods in `DynamicQueueController` read the core `queue` table directly, compute the current highest sub-queue index, and create items via `\Drupal::queue()`. The dashboard route reads queued rows and unserializes their stored `data` blob to display node title / recipient / status columns.

Operationally you enable the module, set the max queue limit, then push items through `loadDatatoDynamicQueues()` from your own code; cron (or drush) processes each sub-queue via the QueueWorker.

---
- Set the maximum number of items per sub-queue on the config form.
- Spread queued work across auto-incrementing sub-queue names.
- Push a work item into the next available dynamic sub-queue.
- View the dynamic-queue dashboard listing.
- Filter the dashboard by a specific queue name.
- See how many sub-queues exist for a queue type.
- Report per-queue item counts through the derivative.
- Process dynamic sub-queues with the bundled QueueWorker on cron.
- Inspect in-progress vs failed items in the dashboard.
- Use the pager to page through a large queue listing.
- Roll over to a new sub-queue when the current one hits the limit.
- Integrate custom producers that call the loader helper.
- Track node-title and email-recipient metadata per queued item.
- Drive email or notification sends through per-type queues.
- Clear cached queue-worker definitions after creating items.
- Audit stuck items by their expire timestamp.
- Group unrelated jobs into separate typed queues.
- Monitor queue depth for capacity planning.
- Rebuild queue derivatives after configuration changes.
- Use as a scaffold for high-volume email batching.