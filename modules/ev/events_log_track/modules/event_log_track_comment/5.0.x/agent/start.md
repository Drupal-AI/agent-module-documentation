<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_comment — agent index

Submodule of **events_log_track**. Records comment create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` + core `comment`.

- Handler (`hook_event_log_track_handlers`): type **`comment`**, title *Comment*, operations
  `insert`, `update`, `delete` — `EventLogTrackCommentHooks`.
- Records via `comment_insert` / `comment_update` / `comment_delete`; description
  `"<comment type>: <subject>"`, `ref_numeric` = comment id, `ref_char` = comment subject.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
