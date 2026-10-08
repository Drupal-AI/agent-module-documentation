<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_clear_cache — agent index

Submodule of **events_log_track**. Records **who cleared the cache** into the shared
`event_log_track` table. Depends on `event_log_track` only.

- Handler (`hook_event_log_track_handlers`): type **`cache_clear`**, title *Cache Clear*,
  operation `cache_clear` — `EventLogTrackClearCacheHooks`.
- Records via `hook_cache_flush`: description `"Cache cleared"`, `ref_numeric` = current
  user id, `ref_char` = current user account name. Fires on a full cache flush
  (e.g. `drush cr`, or the admin *Clear all caches*). Note: CLI events are only logged when the
  parent's `log_cli` setting is on.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
