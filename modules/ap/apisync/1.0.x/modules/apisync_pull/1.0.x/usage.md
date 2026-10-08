<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imports remote OData records into Drupal entities based on API Sync mappings, using cron or standalone endpoints plus queue workers.

---

`apisync_pull` moves data from the remote system into Drupal. On cron (`apisync_pull_cron`) it asks each pull-enabled mapping's `QueueHandler` for records updated since the last pull (honoring the mapping's trigger date and optional WHERE clause), enqueues them into the `apisync_pull` queue, and processes them with the `CronPull` queue worker (`PullBase`), which creates or updates the mapped Drupal entity and its `apisync_mapped_object`. A `DeleteHandler` removes Drupal entities whose remote records were deleted. When global or per-mapping `standalone` mode is enabled, cron processing is skipped and an external scheduler must call the cron-key-protected pull endpoints instead (`/apisync_pull/endpoint/{key}`, optionally scoped to a mapping or a single record id). Drush commands support querying, resetting, and setting pull state. Pull respects the active auth provider and only runs when a token is available (for token providers).

---

- Import remote OData records into mapped Drupal entities on cron.
- Create Drupal entities for new remote records; update existing mapped ones.
- Delete Drupal entities when their remote records are removed.
- Pull only records changed since the last run (trigger-date based).
- Apply a per-mapping custom WHERE clause to scope the pull.
- Pull a single remote record on demand by API Sync ID.
- Process pulls via a Drupal queue (`apisync_pull`) and queue workers.
- Cap enqueued items with `pull_max_queue_size`.
- Run standalone HTTP endpoints (cron-key protected) instead of cron.
- Scope a standalone endpoint to one mapping or one record.
- Run `drush apisync_pull:pull-query`, `pull-reset`, `pull-set` to manage pull state.
- Redirect after a standalone pull via a `destination` parameter.
- Skip pulls when no auth token is available (token providers).
- Emit notice/error events (logged by `apisync_logger`) for pull progress and failures.
- Handle remote OData collections and paging through the OData client.
