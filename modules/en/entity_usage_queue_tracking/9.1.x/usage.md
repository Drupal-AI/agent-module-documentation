<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Queue Tracking makes the Entity Usage module track references asynchronously via a queue processed on cron, instead of synchronously during entity save/delete.

When the setting `entity_usage_queue_tracking.settings:queue_tracking` is TRUE (set only via settings.php `$config[...]`, deliberately not exposed in the UI), a `hook_module_implements_alter` removes Entity Usage's own entity CRUD hooks and this module's hooks enqueue `entity_usage_tracker` items instead. The `EntityUsageTracker` QueueWorker (cron time 300s) loads the entity and calls the Entity Usage update manager to (re)track it, deleting usage rows for non-current revisions, invalidating target entity cache tags, and letting other modules veto tracking via `hook_entity_usage_queue_tracking_should_remove_usage`. For delete operations where the entity is already gone, it removes usage rows by source. Because tracking is deferred, references can be momentarily stale — the README warns not to use queue mode when automated processes depend on up-to-date usage data.

The `drush clean_usage_table` command (service `entity_usage_queue_tracking.clean_usage_table`) removes duplicate rows and, with `--pointing`, rows where target equals source; run it periodically to prune outdated-revision references. No routes, permissions, or admin forms are added. The cleanup SQL interpolates only hardcoded column names (`source_id`, `source_id_string`), not user input.
---
Cron-queue-based tracking for Entity Usage plus a Drush cleanup command for stale/duplicate rows.
---
- Enable queue-based entity usage tracking via settings.php
- Defer reference tracking to cron instead of entity save time
- Reduce save-time latency on content with many references
- Process the `entity_usage_tracker` queue on cron
- Track inserts, updates, and deletions through the queue
- Handle translation and revision deletions
- Remove usage rows by source when an entity is already deleted
- Delete usage rows for non-current revisions on update
- Invalidate target entity cache tags when usage changes
- Veto tracking for specific entities via hook
- Run `drush clean_usage_table` to prune duplicate usage rows
- Run `drush clean_usage_table --pointing` to drop self-referencing rows
- Schedule the cleanup command periodically via cron/crontab
- Keep the entity_usage table lean on high-churn sites
- Disable queue mode when real-time usage data is required
- Log each queue operation to the `entity_usage_tracker` channel
