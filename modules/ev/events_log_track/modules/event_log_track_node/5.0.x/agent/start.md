<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_node — agent index

Submodule of **events_log_track**. Records node create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` + core `node`.

- Handler (`hook_event_log_track_handlers`): type **`node`**, title *Node*, operations
  `insert`, `update`, `delete` — `EventLogTrackNodeHooks`.
- Records via entity hooks `node_insert` / `node_update` / `node_delete`; each builds a `$log`
  with `description` = `"<type>: <title>, <Published|Unpublished>"` (no status word on delete),
  `ref_numeric` = node id, `ref_char` = node title, then calls `event_log_track.manager`.
- Also adds a Views relationship `elt_node_join` (`event_log_track.ref_numeric` →
  `node_field_data.nid`, constrained to `type = 'node'`) so a report can join the node.

The storage table, the logging pipeline, filtering, retention and permissions are all the
parent's. See the shared docs:
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
