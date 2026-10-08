<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_block_content — agent index

Submodule of **events_log_track**. Records custom (content) block create/update/delete into the
shared `event_log_track` table. Depends on `event_log_track` + core `block_content`.

- Handler (`hook_event_log_track_handlers`): type **`block_content`**, title *Block content*,
  operations `insert`, `update`, `delete` — `EventLogTrackBlockContentHooks`.
- Records via `block_content_insert` / `block_content_update` / `block_content_delete`;
  description `"<bundle>: <label>, <Published|Unpublished>"` (no status on delete),
  `ref_numeric` = block id, `ref_char` = block label.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
