<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Events remove expired (localgov_events_remove_expired) — agent index

Submodule of [localgov_events](../../../../3.2.x/agent/start.md). On cron it finds `localgov_event`
nodes whose every recurring-date occurrence has ended more than `expire_days` ago and, per the
configured `action`, unpublishes/archives or deletes them in batches. Default action is `none` — it
does nothing until an admin opts in. Depends on `localgov_events:localgov_events`. No Drush commands,
no plugin types; provides config schema and one permission.

- **Choose delete vs unpublish/archive, retention days, batch size, and how the cron sweep works** →
  [configure/expire.md](configure/expire.md)
- **The one permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Settings form route `localgov_events_remove_expired.form` → `/admin/config/content/expired-events`
  (`ExpiredEventSettingsForm`, form id `localgov_events_remove_expired_form`); menu link
  `localgov_events_remove_expired.admin.settings` under `system.admin_config_content`. The info.yml
  declares no `configure:` key.
- Config object `localgov_events_remove_expired.settings`: `action` (`none`|`unpublish`|`delete`,
  default `none`), `expire_days` (int, default `30`), `items_per_cron` (int, default `100`).
- Permission `administer expired events` (`restrict access: TRUE`) — only requirement on the form route.
- Mechanism: `localgov_events_remove_expired_cron()` in `localgov_events_remove_expired.module`.
  Cut-off = UTC midnight today minus `expire_days`; a direct DB query over the `date_recur` occurrence
  table (`DateRecurOccurrences::getOccurrenceCacheStorageTableName`) selects published `localgov_event`
  nodes whose occurrences are entirely before the cut-off; up to `items_per_cron` per run.
- `unpublish` is content-moderation aware: with `content_moderation` + a `moderation_state` field it
  sets state `archived` via `localgov_events_remove_expired__set_content_state()`, otherwise
  `$entity->setUnpublished()`. `delete` calls `$entity->delete()` (permanent).
- Logs to channel `localgov_events_remove_expired`; guards that node type `localgov_event` and a
  `date_recur` field `localgov_event_date` exist before running.
