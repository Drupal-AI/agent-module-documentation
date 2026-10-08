Enables configuration-change tracking for Events Log Track: every config save and delete is recorded in the audit report with type `config`, including a short human-readable diff of the keys that changed.

---

`EventLogTrackConfigSubscriber` subscribes to core's `ConfigEvents::SAVE` and `ConfigEvents::DELETE`. On save it distinguishes a brand-new config object ("Config added") from an edit, for which it builds a compact diff (`key: old -> new`, with add/remove/change handling for nested arrays) while ignoring `dependencies`, `third_party_settings`, `_core`, `uuid`, and `langcode`; on delete it records "Config removed". The config object name is stored in `ref_char`, so the parent's wildcard `skip_patterns` (e.g. `system.*`) can silence noisy sources. `EventLogTrackConfigHooks` registers the `config` handler (operations save/delete) so these show up in the report's exposed filters. Entries write through the parent `event_log_track.manager` service, inheriting retention and the `access event log track` permission.

---

- Audit all configuration changes across the site.
- See a before/after diff of what a config save changed.
- Track who edited system, field, view, or module settings.
- Record configuration deletions.
- Distinguish newly added config from edits.
- Filter the audit report to only `config` events.
- Silence noisy config sources with wildcard skip patterns.
- Investigate configuration drift between deployments.
- Detect unauthorized settings changes.
- Correlate config changes with the acting user and IP.
- Demonstrate change-management compliance.
- Prune old config-change records via cron retention.
- Trace the history of a specific config object by name (`ref_char`).
- Export a report of configuration activity over a period.
- Spot risky changes such as permission or access settings edits.
