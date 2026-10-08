<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Submissions Delete — agent index

Adds a manual **"Bulk Delete" tab** under each webform's Results tab to delete submissions whose
creation date is within an admin-chosen **start/end date range**. On-demand admin action — **not cron,
not scheduled, not a retention policy**. Depends on `webform`. Version **8.x-1.2** (dir `8.x-1.x`).
Core `^8.8 || ^9 || ^10 || ^11`.

Deletion is **destructive/permanent** (export first). Runs inline under the webform's batch limit,
else via Batch API. Route gated by Webform's `webform.submission_purge_any` access + results-access
check. Defines no permissions, config schema, cron, or Drush of its own.

- `configure/bulk-delete.md` — the form, route, access, validation, and batch behavior.
