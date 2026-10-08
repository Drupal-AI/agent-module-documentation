Enables cache-clear tracking for Events Log Track: every full cache flush is recorded in the audit report with type `cache_clear`, capturing who triggered it.

---

`EventLogTrackClearCacheHooks` registers the `cache_clear` handler and implements `hook_cache_flush`, which fires on a full rebuild (admin *Clear all caches*, `drush cr`, or any `drupal_flush_all_caches()`). The entry records "Cache cleared" with the current user id in `ref_numeric` and the username in `ref_char`, then writes through the parent `event_log_track.manager` service. Because cache clears often happen on the command line, remember that CLI events are only stored when the parent's `log_cli` setting is enabled. Filtering, retention, and the `access event log track` permission are inherited from the parent.

---

- Audit every full cache clear and who performed it.
- Detect frequent cache flushes that may indicate a problem.
- Correlate a performance dip with a recent cache clear.
- Filter the audit report to only `cache_clear` events.
- See whether a clear came from the UI or (with log_cli) from Drush.
- Investigate unexpected cache rebuilds.
- Hold operators accountable for production cache clears.
- Record the acting user's IP for each clear.
- Prune old cache-clear records via cron retention.
- Export a report of cache-clear frequency over time.
- Combine with deployment auditing to confirm post-deploy rebuilds.
- Identify who ran a rebuild during an incident.
- Track cache clears alongside config changes.
- Spot automation or bots repeatedly flushing caches.
- Demonstrate operational accountability for maintenance actions.
