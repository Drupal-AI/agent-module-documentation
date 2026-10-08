<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scheduled Publish — agent index

Schedules future **content-moderation** state changes on entities. You add a
`scheduled_publish` field to a moderated bundle; editors queue date + target-state entries;
**cron** applies each transition when due. No global settings form (`configure: null`).
Depends on `content_moderation`, `workflows`, `datetime`.

- **Add & use a scheduled_publish field (field type/widget/formatter, storage, how transitions fire, listing page, permission)** →
  [configure/scheduled-field.md](configure/scheduled-field.md)
- **Run scheduled transitions on demand: Drush command + cron service** →
  [drush/commands.md](drush/commands.md)

Key facts:
- Field type **`scheduled_publish`** (default widget `scheduled_publish`, default formatter
  `scheduled_publish_generic_formatter`). Item columns: `value` (datetime_iso8601) +
  `moderation_state`. Usually multi-value.
- The bundle must be under **Content Moderation** (a workflow) for target states to exist.
- Cron service **`scheduled_publish.update`** (`ScheduledPublishCron::doUpdate()`) applies due
  transitions. Drush: **`scheduled_publish:doUpdate`** (alias **`schp`**).
- Admin listing: **`/admin/content/scheduled-publish`** (+ add/edit/delete). Permission
  **`access scheduled publish pages`**; the listing needs `view any unpublished content`.
- Optional config: `ultimate_cron.job.scheduled_publish_cron`, `views.view.scheduled_publish`.
