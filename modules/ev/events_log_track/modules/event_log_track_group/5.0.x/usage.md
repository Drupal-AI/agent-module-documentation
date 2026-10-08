Enables Group-entity tracking for Events Log Track: create/update/delete of groups (from the contrib Group module) appears in the audit report with type `group`.

---

`EventLogTrackGroupHooks` registers the `group` handler (operations insert/update/delete) and implements the `group` entity insert/update/delete hooks. Each entry records the group label, bundle, and revision log message in the description, the group id in `ref_numeric`, and the label in `ref_char`, then writes through the parent `event_log_track.manager` service. Group *membership* changes are covered by the separate `event_log_track_group_membership` submodule. Filtering, retention, and the `access event log track` permission come from the parent.

---

- Audit creation of new groups.
- Track edits to group labels and settings.
- See who deleted a group.
- Record group revision log messages.
- Filter the audit report to only `group` events.
- Distinguish group insert vs update vs delete.
- Trace a group's history by its id (`ref_numeric`).
- Detect unauthorized group deletions.
- Correlate group changes with the acting user and IP.
- Demonstrate governance over group structures.
- Prune old group-change records via cron retention.
- Exclude specific groups using skip patterns.
- Export a report of group activity over a period.
- Combine with the membership submodule for full Group auditing.
- Identify groups created and deleted within a short window.
