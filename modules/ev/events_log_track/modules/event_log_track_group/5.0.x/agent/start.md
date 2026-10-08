<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_group — agent index

Submodule of **events_log_track**. Records Group-entity create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` + contrib **`group`** (`group:group`).

- Handler (`hook_event_log_track_handlers`): type **`group`**, title *Group*, operations
  `insert`, `update`, `delete` — `EventLogTrackGroupHooks`.
- Records via `group_insert` / `group_update` / `group_delete`; description
  `"<label> (<bundle>)[: <revision log>]"`, `ref_numeric` = group id, `ref_char` = group label.

For membership (role) changes use the sibling **event_log_track_group_membership** submodule.
Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
