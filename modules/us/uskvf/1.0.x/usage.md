<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update Status KV Flush adds a status-report check that detects and repairs the desync between Drupal's `update_fetch_task` key-value store and the `update_fetch_tasks` queue that makes available-updates appear missing.
---
Drupal's Update module records which projects still need release data fetched in two places: a database-backed `update_fetch_task` key-value store (a registry `createFetchTask()` consults before queuing) and an `update_fetch_tasks` queue (often Redis-backed) processed by cron. If the queue backend is flushed or restarted, the queue items vanish but the DB key-value store keeps its entries, so on the next cron run Drupal sees every project "already queued", skips re-queuing, never fetches, and `admin/reports/updates` shows modules as unavailable.

The module implements `hook_requirements()` (module internal name `update_status_kv_flush`): when the key-value store has entries but the queue reports zero items it shows an ERROR on `admin/reports/status` with a fix link, otherwise an OK "In sync" line. The fix link points at route `update_status_kv_flush.reset` (`/admin/reports/update-status-kv-flush/reset`), gated by `administer site configuration` plus a CSRF token, whose controller calls `keyValue('update_fetch_task')->deleteAll()` and redirects back to the status report so cron can re-queue every project. The same repair is available manually via `drush php-eval`.

Operationally there is nothing to configure; enable it and watch the status report. The reset endpoint only clears a transient fetch-task registry (no content or config is deleted) and is admin-and-CSRF protected, so the security surface is minimal.

---

- Diagnose why `admin/reports/updates` shows modules as unavailable
- Detect the update_fetch_task KV store vs update_fetch_tasks queue desync from the status report
- See an at-a-glance In sync / Out of sync indicator on admin/reports/status
- One-click clear the stuck update_fetch_task store via the fix link
- Recover update status after a Redis (queue backend) flush or restart
- Restore release-data fetching without a full cache rebuild
- Clear the store manually with `drush php-eval '\Drupal::keyValue("update_fetch_task")->deleteAll();'`
- Force an immediate refetch: clear the store then run `drush cron`
- List stuck store entries: `drush php-eval` on keyValue('update_fetch_task')->getAll()
- Check queue depth: `drush php-eval` on queue('update_fetch_tasks')->numberOfItems()
- Inspect cached release data via keyValueExpirable('update_available_releases')
- Confirm the fix worked by re-checking the status report goes green
- Trigger a manual re-fetch from Available updates → Check manually after clearing
- Provide a stop-gap for the underlying core createFetchTask() bug
- Audit whether a site's update status is reliable before trusting it
- Run the reset safely (CSRF + admin permission gated) from the status report link
