<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Records who cleared the site cache.

---

This submodule of Events Log Track logs clear cache events. `hook_cache_flush()` logs a single `cache_clear` event with the current user as the reference. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `cache_clear` and one of the operations [cache_clear]. `ref_numeric` = current uid, `ref_char` = current username; description is 'Cache cleared'. Enable it with `drush en event_log_track_clear_cache -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = cache_clear). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when an admin runs 'Clear all caches'.
- Log when a deploy flushes caches.
- Log when drush cr is run (with log_cli on).
- Log when tracking who invalidated caches.
- Record the `cache_clear` operation on clear cache in the audit trail.
- Answer "who changed this clear cache and when" from the event log.
- Filter the Events Log Track report to just `cache_clear` events.
- See the acting user, IP address and timestamp behind every clear cache change.
- Build a custom View of clear cache activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward clear cache events to external logging.
- Automatically prune old clear cache logs via the base module's cron-based deletion.
- Exclude noisy clear cache events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that clear cache changes are tracked.
- Correlate a clear cache change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected clear cache deletion after the fact.
- Measure how often each user performs clear cache operations.
- Retain a searchable history of clear cache events for incident response.
