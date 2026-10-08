<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_menu — agent index

Submodule of **events_log_track**. Records custom **menu** and **menu-link** create/update/delete
into the shared `event_log_track` table. Depends on `event_log_track` + core `menu_link_content`.

- Handler (`hook_event_log_track_handlers`): type **`menu`**, title *Menu*, operations
  `insert`, `update`, `delete`, `link insert`, `link update`, `link delete` —
  `EventLogTrackMenuHooks`.
- **Menu entities** via `menu_insert/update/delete`: description `"<label> (<id>)"`,
  `ref_char` = menu id.
- **Menu links (entity)** via `menu_link_content_insert/update/delete`: description
  `"<bundle>: <title>"`, `ref_numeric` = link id, `ref_char` = link title.
- **Menu-link form path** additionally uses the parent's form-submit dispatch: the handler
  declares `form_ids` = `menu_link_content_menu_link_content_form` /
  `..._delete_form` with `form_submit_callback` `EventLogTrackMenuHooks::formSubmit`, emitting
  `link insert` / `link update` / `link delete` with the title, path, id and parent-menu name.

Shared storage, filtering, retention, permission and the form-dispatch mechanism belong to the
parent — [event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
