<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Deletion mechanics: batch service, queue worker, cron

Two independent delete paths share the same core action (delete an order plus its payments). Both are reached only after config is set from the admin form ([../config/settings.md](../config/settings.md)).

## What "delete an order" means

For each order ID:
1. Load the `commerce_order` entity.
2. `entity_type.manager->getStorage('commerce_payment')->loadByProperties(['order_id' => $order->id()])` and `->delete()` each matched payment.
3. `$order->delete()`.
4. Log `notice` to the `delete_commerce_order` logger channel.

Only `commerce_order` and its `commerce_payment` children are removed. Other related entities (profiles, order items via cascade, etc.) are handled by Commerce's own entity deletion, not by extra code here. Deletion is permanent.

## Path A — foreground Batch (immediate)

- Service `delete_commerce_order.batch_processing_service` = `CommerceOrderDeleteService` (`src/Service/`), args `@entity_type.manager`, `@logger.factory`.
- `initiateBatchProcessing(array $data, array $batchArray)` builds a Batch API definition, adds one operation `[[$this, 'deleteOrder'], [$orderId]]` per ID, sets `finished` → `finishedCallback`, and calls `batch_set()`. The batch then runs on the normal Batch API request cycle.
- `deleteOrder($orderId, &$context)` performs the delete-an-order action above and records `$context['results']` / `$context['message']`.
- `finishedCallback()` logs "Record(s) delted successfully." on success or an error otherwise.
- Triggered from `CommerceOrderDeletionForm::submitForm()` when `cron_radio == 0`, over orders with `created < strtotime($selected_date)`.

## Path B — cron + queue (scheduled)

- `hook_cron()` (`delete_commerce_order.module`): if `delete_commerce_order.settings:cron_radio == '1'`, reads `intervel`, queries `commerce_order` with `created < strtotime($intervel)` and `accessCheck(FALSE)`, and if non-empty pushes the **whole array of IDs as one queue item** into queue `commerce_delete_order`.
- Queue worker plugin `commerce_delete_order` = `CommerceOrderDeleteQueue` (`src/Plugin/QueueWorker/`), annotation `cron = {"time" = 300}` (up to 300s per cron run). Constructor injects `entity_type.manager`, `logger.factory`, `datetime.time`.
- `processItem($data)` → `deleteOrder($orderIds)` loops the ID array and performs the delete-an-order action per ID, logging each.

Note: because the cron path enqueues one item containing all matching IDs, the whole set is processed in a single `processItem` call when the queue runs; there is no per-order chunking on this path (the Batch path does chunk, one operation per order).

## Operating notes

- Both delete queries use `accessCheck(FALSE)`; scoping is entirely by the `created` date condition and, for the UI, the `administer commerce_order` route gate.
- `intervel` is a snapshot date saved when the form is submitted, not a rolling window recomputed each cron run — re-save the form to advance the cutoff.
- Watch the `delete_commerce_order` logger channel (dblog/syslog) for the per-order deletion notices as an audit trail.
- No Drush command is provided; run cron (`ddev drush cron`) to trigger Path B, or submit the form for Path A.
