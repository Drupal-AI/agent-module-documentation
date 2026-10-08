<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Queues (dynamic_queues) — agent index

**Splits Drupal queue items into auto-named, capacity-limited sub-queues with an inspection dashboard.**

- **Version:** 1.0.x
- **Core:** `^8 || ^9 ||  ^10`
- **Configure:** `/admin/dynamic-queues/config` (`dynamic_queues.settings_form`, `access administration pages`) — sets `max_queue_limit`.
- **Routes:** `dynamic_queues.queue_lists` (`admin/dynamic-queues/lists`) dashboard controller; `dynamic_queues.settings_form` admin config.
- **Plugins:** QueueWorker `DynamicQueues` + derivative reporting queue lengths.
- **Key API:** `DynamicQueueController::loadDatatoDynamicQueues($type,$data)` to enqueue; `::getQueueLength()` / `::getQueueLists()` to inspect.

See [configure/settings.md](configure/settings.md).