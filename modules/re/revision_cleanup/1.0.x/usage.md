<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Revision Cleanup prunes old **node** revisions on a schedule so a site that has been creating a revision on every save for years stops carrying its entire history in the database.

---

Revisions are cheap individually and expensive in aggregate: a content type that stores one per save, edited daily for five years, leaves close to two thousand rows per node across the revision tables, and on a large or multilingual site those tables become the majority of the database — slowing backups, restores and the entity queries that join them. Core ships no retention policy. This module adds one: a settings form at `/admin/config/system/revision-cleanup` (permission `administer site configuration`) sets `days_to_keep` and `revisions_per_month`, and once the "Run on cron" switch is on, `hook_cron` runs at most once a day and hands the work to a queue. The service `RevisionCleanupService` computes, per node, which revisions to keep — everything newer than N days, plus the newest M revisions in each calendar month per language — and enqueues the rest; the `revision_cleanup_processor` QueueWorker deletes them (about a minute of work per cron run, or `drush queue-run revision_cleanup_processor` on demand). The current/default revision and each language's latest translation-affected revision are always protected, and `hook_revisions_cleanup_keep_alter` lets a site keep more (e.g. moderation drafts). Deletion is irreversible, so the master switch defaults off; retention is a policy decision worth testing on a copy of production with a backup in hand.

---

- Reduce database size on a long-lived site.
- Delete node revisions older than a retention period.
- Keep a fixed number of revisions per month per node.
- Keep all revisions from the last N days.
- Respect per-language revision history on a multilingual site.
- Speed up backups and restores.
- Reduce revision-table bloat.
- Apply a documented retention policy to content history.
- Clean up after a bulk resave of nodes.
- Free space before a migration.
- Reduce query time on revision joins.
- Schedule cleanup rather than running it by hand.
- Force an immediate pass with `drush queue-run revision_cleanup_processor`.
- Keep moderation drafts via `hook_revisions_cleanup_keep_alter`.
- Preserve the current/published revision automatically.
- Shrink a database dump for local development.
- Control revision growth on a high-edit site.
- Reduce hosting storage costs.
- Bucket retention by the site timezone instead of UTC.
- Cascade-remove paragraph revision data attached to pruned node revisions.
- Log each cleanup action to a dedicated watchdog channel.
- Prepare a site for an upgrade.
- Enforce a data-minimisation retention rule.
