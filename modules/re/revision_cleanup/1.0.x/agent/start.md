<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Cleanup (revision_cleanup) — agent index

Prunes old **node** revisions on a schedule to shrink the database. `hook_cron` (once/day, only when
enabled) fills a queue with the revisions to delete; a cron QueueWorker deletes them. Retention is
"keep everything newer than N days" plus "keep the newest M revisions per calendar month" (per
language), and the current/default revision is never deleted. No dependencies beyond core; range
`^8 || ^9 || ^10 || ^11`.

- **Settings form, config keys, enabling cron, running the queue, runtime trace** → [configure/settings.md](configure/settings.md)
- **The cleanup service and its methods (build the delete set / fill the queue)** → [api/service.md](api/service.md)
- **`hook_revisions_cleanup_keep_alter` — keep extra revisions (e.g. drafts)** → [hooks/keep_alter.md](hooks/keep_alter.md)

Key facts:
- Configure route: `revision_cleanup.settings` at `/admin/config/system/revision-cleanup`,
  gated by the core permission `administer site configuration` (no permission of its own).
- Config object `revision_cleanup.settings` (schema provided): `days_to_keep` (int, default 90),
  `revisions_per_month` (int, default 1), `use_site_timezone` (bool, default 0), `on` (bool,
  default 0 — cleanup is OFF until enabled), `logger` (bool, default 0).
- Service id `revision_cleanup.revision_cleanup_service` → `Drupal\revision_cleanup\Services\RevisionCleanupService`.
- Queue id `revision_cleanup_processor`, worker `Drupal\revision_cleanup\Plugin\QueueWorker\RevisionCleanUpQueueProcessor`
  (`@QueueWorker`, `cron = {"time" = 60}`). Force a run with `drush queue-run revision_cleanup_processor`.
- Logger channel `logger.channel.revision_cleanup`. State key `revision_cleanup.last_cron`.
- Operates on `node` entities only (entity type is hardcoded; `@todo` for others). Composite
  references (e.g. paragraphs) are removed by core when the node revision is deleted.
- No drush commands of its own, no plugin types of its own, no submodules.
