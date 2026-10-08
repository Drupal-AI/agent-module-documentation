<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Direct Queue provides a Drush command that processes a single named Drupal queue item on demand, so an external supervisor (the project ships around a Go daemon) can dispatch queue items individually instead of waiting for cron.
---
The module registers the Drush command `direct_queue:run` (alias-less, tagged `drush.command` via `direct_queue.commands`). It takes an `$item_id` and an `$expire` value, looks up that exact row in the core `{queue}` table with a range query (matching both `item_id` and `expire` so the same item is not fetched twice), unserializes the item data, instantiates the matching queue worker plugin, calls `processItem()`, and deletes the item on success. `SuspendQueueException` releases the item; any other exception logs and leaves the item for later. The command is CLI-only — there are no HTTP routes, permissions, or web-facing endpoints.

Both `$item_id` and `$expire` are passed through `preg_replace('/[^0-9]/','',...)` and used as bound query parameters, so the SQL is parameterised. Note the command calls `unserialize()` on the queue payload without an `allowed_classes` restriction; this is the same trust model core's database queue uses (the data originates from queue producers within the site, not from HTTP request input) and the command runs only from the CLI. Operate it by wiring the external daemon to invoke `drush direct_queue:run <item_id> <expire>` per item.
---
- Process a single queue item immediately from the CLI.
- Drive queue processing from an external Go daemon.
- Dispatch queue items in parallel by item_id instead of serial cron.
- Match item_id + expire to avoid double-processing a leased item.
- Delete an item automatically after its worker succeeds.
- Release an item back on `SuspendQueueException`.
- Leave an item in the queue on generic failure for retry.
- Run `drush direct_queue:run <item_id> <expire>`.
- Integrate near-real-time queue handling without cron latency.
- Log processing errors to the `direct_queue` logger channel.
- Scale worker throughput by launching many CLI invocations.
- Keep queue processing off the web request path.
- Use with any core queue worker plugin.
- Combine with core cron for cleanup of expired items.
- Retry a failed item by leaving it leased until re-dispatch.
- Monitor the `direct_queue` log channel for worker failures.