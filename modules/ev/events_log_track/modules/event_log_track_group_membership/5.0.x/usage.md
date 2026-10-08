Enables Group membership tracking for Events Log Track: users joining a group, changing their group roles, or leaving a group appear in the audit report with type `group_membership`.

---

`EventLogTrackGroupMembershipHooks` registers the `group_membership` handler (operations insert/update/delete) and implements both the Group 2.x `group_content_*` hooks and the Group 3.x `group_relationship_*` hooks, funnelling each into shared logic that only fires for `GroupMembershipInterface` entities. The insert entry records the member, group, and assigned roles; the update entry records the original→new role change; the delete entry uses null-safe fallbacks when the user or group has already been removed. `ref_numeric` holds the membership id. Entries write through the parent `event_log_track.manager` service, inheriting filtering, retention, and the `access event log track` permission.

---

- Audit when users are added to a group.
- Track group-role changes for a member (before/after roles).
- See who removed a member from a group.
- Record memberships across both Group 2.x and 3.x sites.
- Filter the audit report to only `group_membership` events.
- Investigate privilege changes inside groups.
- Trace a membership's history by its id (`ref_numeric`).
- Detect bulk membership removals.
- Correlate membership changes with the acting user and IP.
- Demonstrate access-governance compliance for group-based access.
- Prune old membership records via cron retention.
- Exclude specific memberships using skip patterns.
- Export a report of group-role changes over a period.
- Combine with the group submodule for full Group auditing.
- Identify accounts rapidly added then removed from a group.
