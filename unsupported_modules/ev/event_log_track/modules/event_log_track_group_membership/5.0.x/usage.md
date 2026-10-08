<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Logs group membership (add/change-role/remove) events.

---

This submodule of Events Log Track logs group membership events. `group_content_*` (Group 2.x) and `group_relationship_*` (Group 3.x) hooks log membership add/role-change/remove, recording user, group and roles. Each event is written through the base module's `event_log_track.manager` service into the `event_log_track` table with `type` `group_membership` and one of the operations [insert, update, delete]. `ref_numeric` = membership id, `ref_char` = user/label; description names the user, group and roles. Enable it with `drush en event_log_track_group_membership -y`; view the results in the Events Log Track report at `/admin/reports/events-track` (filter Type = group_membership). Requires the contrib **Group** module (supports Group 2.x `group_content` and 3.x `group_relationship` hooks). It registers a handler via `hook_event_log_track_handlers()` so its type/operations appear in the report filters.

---

- Log when a user joins a group.
- Log when a member's group role changes.
- Log when a user is removed from a group.
- Log when auditing membership changes.
- Record the `insert` operation on group membership in the audit trail.
- Record the `update` operation on group membership in the audit trail.
- Record the `delete` operation on group membership in the audit trail.
- Answer "who changed this group membership and when" from the event log.
- Filter the Events Log Track report to just `group_membership` events.
- See the acting user, IP address and timestamp behind every group membership change.
- Build a custom View of group membership activity on the `event_log_track` base table.
- Also enable the syslog or stdout submodule to forward group membership events to external logging.
- Automatically prune old group membership logs via the base module's cron-based deletion.
- Exclude noisy group membership events with a base-module `skip_patterns` glob on `ref_char`.
- Demonstrate for a compliance audit that group membership changes are tracked.
- Correlate a group membership change with the acting account via `ref_numeric`/`ref_char`.
- Investigate an unexpected group membership deletion after the fact.
- Measure how often each user performs group membership operations.
- Retain a searchable history of group membership events for incident response.
