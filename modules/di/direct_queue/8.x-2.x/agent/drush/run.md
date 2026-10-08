<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drush direct_queue:run

```
drush direct_queue:run <item_id> <expire>
```

- `<item_id>` and `<expire>` are filtered to digits and matched against the `{queue}` table row (`item_id = :item_id AND expire = :expire`).
- On match: loads the queue worker named by the item's `name`, calls `processItem($item->data)`, then `deleteItem()`.
- `SuspendQueueException` → `releaseItem()`; other exceptions → logged, item left for retry (core cron cleans up when `expire < time()`).
- Intended to be invoked once per item by an external daemon; no HTTP entry point.
