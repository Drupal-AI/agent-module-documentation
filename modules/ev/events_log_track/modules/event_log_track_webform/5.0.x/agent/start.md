<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# event_log_track_webform — agent index

Submodule of **events_log_track**. Records **webform submission** lifecycle plus view, download
and clear operations into the shared `event_log_track` table. Depends on `event_log_track` +
contrib **`webform`** (`webform:webform`).

- Handler (`hook_event_log_track_handlers`): type **`webform_submission`**, title
  *Webform Submission*, operations `insert`, `update`, `delete`, `view`, `download`, `clear` —
  `EventLogTrackWebformHooks`.
- **CRUD + view** via entity/view hooks (`EventLogTrackWebformHooks`):
  `webform_submission_insert/update/delete` and `entity_view` (a `view` when a submission is
  rendered). Description names the webform id, submission id (SID) and owner uid; `ref_numeric`
  = SID, `ref_char` = webform id.
- **Download + clear** via an event subscriber, `WebformSubmissionActionLoggerSubscriber`
  (service `event_log_track_webform.action_logger_subscriber`), on `KernelEvents::CONTROLLER`:
  matches the webform results-export routes → `download`, and the results-clear/purge routes →
  `clear`; `ref_char` = webform id.

Shared storage, filtering, retention and permission come from the parent —
[event handler system](../../../../5.0.x/agent/hooks/event-handlers.md) ·
[logging API & table](../../../../5.0.x/agent/api/logging.md).
