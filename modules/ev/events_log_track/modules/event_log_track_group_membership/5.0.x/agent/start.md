<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_group_membership — agent index

Submodule of **events_log_track**. Records Group **membership** create/update/delete (a user
joining, changing roles in, or leaving a group) into the shared `event_log_track` table.
Depends on `event_log_track` + contrib **`group`** (`group:group`).

- Handler (`hook_event_log_track_handlers`): type **`group_membership`**, title
  *Group membership*, operations `insert`, `update`, `delete` —
  `EventLogTrackGroupMembershipHooks`.
- Supports both Group **2.x** (`group_content_*` hooks) and Group **3.x**
  (`group_relationship_*` hooks); each pair funnels into the same logic and only acts when the
  entity is a `GroupMembershipInterface`.
- Descriptions capture the member name/uid, group name/gid, and role list; **update** records
  the original→new roles. `ref_numeric` = membership entity id, `ref_char` = membership label
  (or member name on delete). Delete uses null-safe fallbacks ("NULL") when the user/group is
  already gone.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
