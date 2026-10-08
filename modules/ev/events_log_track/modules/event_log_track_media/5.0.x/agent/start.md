<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_media — agent index

Submodule of **events_log_track**. Records media-entity create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` + core `media`.

- Handler (`hook_event_log_track_handlers`): type **`media`**, title *Media*, operations
  `insert`, `update`, `delete` — `EventLogTrackMediaHooks`.
- Records via `media_insert` / `media_update` / `media_delete`; description
  `"<name> (<bundle>)[: <revision log>]"`, `ref_numeric` = media id, `ref_char` = media label.
- Adds a Views relationship `elt_media_join` (`event_log_track.ref_numeric` →
  `media_field_data.mid`, constrained to `type = 'media'`) via
  `EventLogTrackMediaViewsHooks::viewsData()`.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
