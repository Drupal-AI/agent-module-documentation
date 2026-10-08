<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_tfa — agent index

Submodule of **events_log_track**. Records a **TFA (two-factor) login** into the shared
`event_log_track` table. Depends on `event_log_track`, **`event_log_track_auth`**, and contrib
**`tfa`** (`tfa:tfa`).

- Handler (`hook_event_log_track_handlers`): type **`authentication_tfa`**, title
  *User authentication - TFA*, operation `TFA login` — `EventLogTrackTfaHooks`.
- Recorded via the parent's form dispatch: handler `form_ids` = `tfa_entry_form`,
  `form_submit_callback` `EventLogTrackTfaHooks::formSubmit`. On a non-anonymous submit it logs
  `TFA login` with a session count in the description (`"SC(<n>)"`), `uid` = current user,
  `ref_numeric` = uid, `ref_char` = username.

Complements the login/logout events from **event_log_track_auth**. Shared storage, filtering,
retention, permission and the form-dispatch mechanism belong to the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
