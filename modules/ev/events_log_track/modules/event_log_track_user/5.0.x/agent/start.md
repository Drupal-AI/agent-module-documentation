<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_user — agent index

Submodule of **events_log_track**. Records user-account create/update/delete into the shared
`event_log_track` table. Depends on `event_log_track` + core `user`.

- Handler (`hook_event_log_track_handlers`): type **`user`**, title *User*, operations
  `insert`, `update`, `delete` — `EventLogTrackUserHooks`.
- Records via `user_insert` / `user_update` / `user_delete`. Descriptions capture the account
  name, uid, roles, and blocked/active status; **update** logs the original→new role change
  (uses `$account->getOriginal()`). `ref_numeric` = uid, `ref_char` = account name (or
  "Anonymous").

This tracks the *user entity* lifecycle (account CRUD). For login/logout/password events use
the sibling **event_log_track_auth** submodule. Shared storage, filtering, retention and
permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
