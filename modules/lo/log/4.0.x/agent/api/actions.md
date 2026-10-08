<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk actions (log operations)

The module ships four core **Action plugins** (type `log`) for the log admin listing /
Views bulk operations, plus two confirm forms and their routes. It does **not** define a
new plugin type — these are `#[Action]` plugins on core's Action system, installed as
`system.action.*` config.

| Action id | Config id / label | Class | Effect |
|-----------|-------------------|-------|--------|
| `log_clone_action` | `log_clone_action` / "Clone" | `Plugin\Action\LogClone` | Duplicates selected logs at a new date (confirm form). |
| `log_reschedule_action` | `log_reschedule_action` / "Reschedule" | `Plugin\Action\LogReschedule` | Moves selected logs to a new/relative date, resetting to pending (confirm form). |
| `log_mark_as_done_action` | `log_mark_as_done_action` / "Mark as done" | `Plugin\Action\LogMarkAsDone` | Applies the `done` state transition. |
| `log_mark_as_pending_action` | `log_mark_as_pending_action` / "Mark as pending" | `Plugin\Action\LogMarkAsPending` | Applies the `pending` state transition. |

Config installed at `config/install/system.action.log_*.yml`. `mark_as_pending` has no
install-config file but its plugin/schema exist.

## Class hierarchy

- `LogActionBase` (extends core `EntityActionBase`) — clone & reschedule. `executeMultiple()`
  stashes the selected entities into `tempstore.private` keyed by plugin id + user id, then
  the confirm form takes over. `access()` requires `update` on each log.
  - `LogClone::access()` requires `view` **and** `create`.
  - `LogReschedule::access()` requires `timestamp` field `edit` **and** `update`.
- `LogStateChangeBase` (extends `EntityActionBase`) — the two mark-as actions. `execute()`
  finds and applies the transition to `$targetState` (skipping if already there), validates
  the entity, sets a revision-log message ("Marked as …"), forces a new revision, and saves.
  `access()` requires `status` field `edit` **and** `update`, and forbids if the target
  state / transition is not available in the log's workflow.

## Confirm forms

- `Form\LogCloneActionForm` (route `log.log_clone_action_form`, `/admin/content/log/clone`,
  requirement `_entity_create_any_access: 'log'`). Asks for a new date + optional revision
  message. On submit it re-checks `view`+`create` per log, `createDuplicate()`s each
  accessible log, sets the new timestamp, sets the current user as owner, writes a "Cloned
  from …" revision message, **dispatches `LogEvent::CLONE`** (see
  [../events/log-clone.md](../events/log-clone.md)), then saves. Inaccessible logs are skipped
  with a warning.
- `Form\LogRescheduleActionForm` (route `log.log_schedule_action_form`,
  `/admin/content/log/reschedule`, requirement `_user_is_logged_in: 'TRUE'`). Supports an
  absolute date or a relative offset (amount + hour/day/week/month/year). On submit it
  re-checks `timestamp` edit, `status` edit, and `update` per log, applies the `to_pending`
  transition if allowed, sets the new timestamp, writes a "Rescheduled to …" revision
  message, forces a new revision, and saves. Inaccessible logs are skipped with a warning.
- Both extend `Form\LogActionFormBase` (a `ConfirmFormBase`) which reads the pending
  selection from `tempstore.private` (keyed by user id) and clears it on submit. Cancel URL
  is the log collection.

The confirm forms act only on the current user's own tempstore selection and re-verify
per-entity access before mutating, so the broad route requirements do not widen access.
