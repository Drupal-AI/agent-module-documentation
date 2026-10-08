<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_workflows — agent index

Submodule of **events_log_track**. Records content-moderation **workflow state** transitions
into the shared `event_log_track` table. Depends on `event_log_track` + core `workflows`.

- Handler (`hook_event_log_track_handlers`): type **`workflows`**, title *Workflows*,
  operations `insert`, `update`, `delete` — `EventLogTrackWorkflowsHooks`.
- Records via `node_insert` / `node_update` **and** `group_insert` / `group_update`, but only
  for entities that have a `moderation_state` field. Insert logs the initial state; update logs
  only when the state actually changed (`old_state != new_state`), with description
  `"<type>: <title> - Workflow state changed from <old> to <new>"`. `ref_numeric` = entity id,
  `ref_char` = entity title/label.
- Despite the handler declaring a `delete` operation, no delete hook is implemented (deletions
  are captured by the node/group submodules instead).

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
