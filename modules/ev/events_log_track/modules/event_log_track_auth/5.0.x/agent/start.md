<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_auth — agent index

Submodule of **events_log_track**. Records **user authentication** activity — login, logout,
password-reset request, failed login, and unauthorized (403) access — into the shared
`event_log_track` table. Depends on `event_log_track` only.

- Handler (`hook_event_log_track_handlers`): type **`authentication`**, title
  *User authentication*, operations `login`, `logout`, `request password`, `fail` —
  `EventLogTrackAuthHooks`.
- **Login/logout** via `hook_user_login` / `hook_user_logout`: description includes username,
  uid, and a live session count (uses `EventLogTrackManager::sessionCount()`); anonymous logins
  (uid 0, can occur with 2FA) are skipped. `ref_numeric` = uid, `ref_char` = username.
- **Password reset** via the parent's form dispatch: handler `form_ids` = `user_pass`,
  `form_submit_callback` `EventLogTrackAuthHooks::formSubmit` → operation `request password`.
- **Failed login** via `hook_form_user_login_form_alter` adding a `#validate` callback
  (`userLoginValidate`) that logs the validation errors as operation `fail` (username truncated
  into `ref_char`).
- **403 responses**: `EventLogTrackAuthExit` (service `event_log_track_auth_exit`) subscribes to
  `KernelEvents::TERMINATE` and logs `type=authorization`, operation `fail`,
  "Unauthorized access attempt" on any 403.

Sibling **event_log_track_tfa** adds TFA-login tracking (and depends on this module).
Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
