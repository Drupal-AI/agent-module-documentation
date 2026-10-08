<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_file — agent index

Submodule of **events_log_track**. Records file-entity create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` (uses core `file`'s `FileInterface`;
core `file` is a standard dependency in practice).

- Handler (`hook_event_log_track_handlers`): type **`file`**, title *File*, operations
  `insert`, `update`, `delete` — `EventLogTrackFileHooks`.
- Records via `file_insert` / `file_update` / `file_delete`; description = the file URI,
  `ref_numeric` = file id, `ref_char` = filename.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
