<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Revision Cleanup

Form `Drupal\revision_cleanup\Form\RevisionCleanupSettingsForm` (`ConfigFormBase`), form id
`revision_cleanup_settings_form`, route `revision_cleanup.settings` at
`/admin/config/system/revision-cleanup`, permission `administer site configuration`.
Menu link under `system.admin_config_system`. All values live in the config object
`revision_cleanup.settings` (schema in `config/schema/revision_cleanup.schema.yml`).

## Config keys

| Key | Type | Default | Form field | Meaning |
|-----|------|---------|-----------|---------|
| `days_to_keep` | integer | 90 | "Number of days" (min 0, required) | Keep **all** revisions whose `revision_timestamp` is newer than this many days. 0 disables the day-based keep. |
| `revisions_per_month` | integer | 1 | "Number of revisions to keep per month" (min 0, required) | For each node + language + calendar month, keep this many newest revisions. 0 disables the per-month keep. |
| `use_site_timezone` | boolean | 0 | "Use site timezone instead of UTC" | Compute the year-month bucket and the day cutoff in the site timezone (`system.date` `timezone.default`) instead of UTC. |
| `on` | boolean | 0 | "Run on cron" | Master switch. When false, `hook_cron` does nothing. **Cleanup is off until you turn this on.** |
| `logger` | boolean | 0 | "Log activities on watchdog" | When true, log a count of queued entities (cron) and each deleted vid (worker) to channel `logger.channel.revision_cleanup`. |

## Set it without the UI

Drush:

```
drush config:set revision_cleanup.settings days_to_keep 90 -y
drush config:set revision_cleanup.settings revisions_per_month 1 -y
drush config:set revision_cleanup.settings on true -y
```

PHP:

```php
\Drupal::configFactory()->getEditable('revision_cleanup.settings')
  ->set('days_to_keep', 90)
  ->set('revisions_per_month', 1)
  ->set('use_site_timezone', FALSE)
  ->set('on', TRUE)
  ->set('logger', FALSE)
  ->save();
```

## What happens at runtime

1. `revision_cleanup_cron()` (in `.module`) runs at most **once per calendar day** — it compares
   `date('ymd')` against the state value `revision_cleanup.last_cron` and returns early otherwise.
   It only proceeds when `on` is true.
2. It calls `RevisionCleanupService::addEntitiesToQueue($days_to_keep, $revisions_per_month)`, which
   computes the delete set for every node, **clears** the queue `revision_cleanup_processor`
   (`deleteQueue()`, to avoid duplicates), and enqueues one item per node that still has revisions to
   delete. See [api/service.md](../api/service.md) for the keep/delete algorithm.
3. The QueueWorker `revision_cleanup_processor` (`cron = {"time" = 60}`, so ~60s of queue work per
   cron run) deletes each queued vid via `EntityStorage::deleteRevision($vid)` — **but only if the vid
   is not in that node's `default_vids`**, so the current/default revision and the latest
   translation-affected revision per language are never deleted.
4. To run the queue immediately instead of waiting for cron:
   `drush queue-run revision_cleanup_processor`.

Notes: revisions are bucketed per month using `node_revision` joined to `node_field_revision` on
`revision_translation_affected = 1`, so per-language history is respected. Deleting a node revision
lets core cascade-delete composite children of that revision (e.g. paragraphs). Deletion is
irreversible — the master switch defaults off precisely so an operator opts in deliberately.
