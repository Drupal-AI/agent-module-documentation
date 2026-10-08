<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Queues — configuration & API

## Settings
`/admin/dynamic-queues/config` (`DynamicQueuesConfigForm`, permission `access administration pages`). Stores `max_queue_limit` in `dynamic_queues.settings_form` — the number of items a single sub-queue holds before the next index is created.

## Enqueue from code
```php
\Drupal\dynamic_queues\Controller\DynamicQueueController::loadDatatoDynamicQueues(
  $queueType,   // e.g. 'email'
  $queueData    // arbitrary payload stored on the queue item's ->data
);
```
The helper finds the highest existing `dynamic_queues:<type>_queue_<n>`, checks whether it has reached `max_queue_limit`, and either reuses it or creates `<type>_queue_<n+1>`.

## Inspect
- `DynamicQueueController::getQueueLength($type)` — highest sub-queue index for a type.
- `DynamicQueueController::getDynamicQueueLists()` — dashboard render array (route `dynamic_queues.queue_lists`).
- Dashboard filter param: `?queue_lists_name=<full queue name>`.

## Processing
Sub-queues are processed by the `DynamicQueues` QueueWorker via cron or `drush queue:run`.
