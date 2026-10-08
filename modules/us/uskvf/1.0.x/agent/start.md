<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Status KV Flush (uskvf) — agent index

**Adds a status-report requirement that detects and one-click-fixes the `update_fetch_task` KV store vs `update_fetch_tasks` queue desync which makes available updates disappear.**

- **Version:** 1.0.x — core `^10 || ^11`; depends on core `update`.
- Internal module machine name / namespace: `update_status_kv_flush` (project/dir `uskvf`).
- **Check:** `hook_requirements()` flags ERROR when KV store count > 0 and queue item count = 0.
- **Route:** `update_status_kv_flush.reset` → `/admin/reports/update-status-kv-flush/reset`; controller `UpdateFetchTaskResetController::reset` clears the `update_fetch_task` KV store, then redirects to `system.status`.
- **Manual fix:** `drush php-eval '\Drupal::keyValue("update_fetch_task")->deleteAll();'` then `drush cron`.
- **Security:** reset route gated by `_permission: administer site configuration` + `_csrf_token: TRUE`; only clears a transient fetch-task registry, no content/config mutation. No anonymous or write endpoints.
