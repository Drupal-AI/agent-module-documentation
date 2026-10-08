<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an admin interface to review migration messages far more usefully than Drush output.

---

Two routes, both gated by the **`view migrate log messages`** permission (`restrict access: true`): `/admin/migrate/log_ui/migration` (`MigrateLogUiController::overview`) lists every non-disabled migration grouped by migration group with counts (total, processed, imported, failed, ignored, unprocessed, to-update, messages); and `/admin/migrate/log_ui/migration/{migration}/messages` (`::logViewer`) shows that migration's message table. The log viewer joins the migration's `messageTableName()` to its `mapTableName()` on `source_ids_hash` and supports filters via the `MigrationMessageFilterForm` (GET-method, shareable URL): by level (multi-select), source key (`map.sourceid1`), and up to two message substrings with LIKE/NOT LIKE and a group-by-message aggregation. Results are paged (limit 500) and sortable by header. All conditions use parameterized query builder conditions (no string concatenation), and rows render through `#type => table` (auto-escaped), so no SQLi/XSS is introduced; access is properly restricted. No config, service or Drush command.

---

- Browse migration error/warning/notice messages in a real admin table.
- See all migrations and their counts on one overview page.
- Filter messages by severity level.
- Search messages by substring (contains / starts / ends), including negation (NOT LIKE).
- Combine two message filters with AND.
- Group identical messages and count occurrences.
- Filter by source key (`sourceid1`) to find a specific record's problems.
- Share a filtered view with a colleague via the GET-parameter URL.
- Page through large message sets (500 per page) and sort by column.
- Diagnose why rows failed to import without re-running the migration.
- Restrict log access to trusted users via `view migrate log messages`.
- Jump from the overview to a migration's messages via links.
- Work with any migration exposing an id-map message table.
- Support Drupal 8/9/10 migrations.
- Replace scrolling Drush logs with a filterable interface.
- Show total record counts alongside filtered results.
