<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown Time Tracker — timer API, service & access

## Data model

Table `burndown_time_tracker_timer` (`burndown_time_tracker.install`, `hook_schema`): `uid`
(primary key → one active timer per user), `task_id`, `started` (unix ts). Timers are transient
scratch rows; the durable record is a `work` entry appended to the parent task's Burndown work log.

## Service — `TaskTimerService` (`src/Service/TaskTimerService.php`)

Service id `burndown_time_tracker.task_timer`, constructed with `@database`. `final` class.

- `getActiveTimer(int $uid): ?array` — the user's timer row or NULL.
- `getActiveTimers(): array` — all rows (used by the manage screen).
- `startTimer(int $uid, int $task_id, int $started): void` — `merge()` keyed on `uid`.
- `stopAndRecord(int $uid, int $stopped, string $stopped_by = ''): ?array` — computes elapsed hours,
  and if `>= MIN_LOG_HOURS` (0.02) appends `Task::addLog('work', 'clocked' [+ "Stopped by …"],
  "{hours}h", …)` and saves the task; always deletes the timer row. Returns
  `['timer'=>…, 'task'=>…, 'recorded'=>bool]`.
- `formatHours(float): string` — trims trailing zeros to max 2 decimals.

## Timer API — `TaskTimerController` (routes in `burndown_time_tracker.routing.yml`)

All three require permission **`burndown comment on task`** and act on
`$this->currentUser()->id()` — a caller can only read/start/stop **their own** timer.

- `GET  /burndown/api/time-tracker/state` — `state()`: current user's active timer payload.
- `POST /burndown/api/time-tracker/start/{ticket_id}` — `start()`: resolves the task via
  `Task::loadFromTicketId()` (404 if missing); if another task's timer is running it is stopped and
  recorded first, then the new timer starts.
- `POST /burndown/api/time-tracker/stop` — `stop()`: stops + records the current user's timer.

Payloads are normalized (uid, task_id, ticket_id, task_name, started).

## Forms & routes

- `TimeEntryEditForm` — `/burndown/hours/time-entry/{burndown_task}/{delta}/edit` (route param typed
  `entity:burndown_task`). Access = `HoursReportController::checkTimeEntryAccess($burndown_task,
  $delta, $account)`: the log delta must exist and be a `work` entry; then **allowed** if the account
  has `manage user work hours`, else **only** if `burndown comment on task` AND the entry's `uid`
  equals the current user (own entries only).
- `ManageWorkTimersForm` — `/burndown/hours/manage-work-timers`, permission
  **`manage user work hours`**; lists/stops running timers (`stopAndRecord(..., $stopped_by)`).
- `HoursReportFilterForm` — exposed filter form for the hours report.

## Views & access plugin

- View `view.burndown_hours.hours` (synced into config on install by
  `burndown_time_tracker_sync_hours_view()`), menu link "Hours" under the dashboard.
- Access plugin `burndown_hours_access` (`HoursReportAccess`): `access()` and the generated
  `routeAccess()` allow `manage user work hours` **OR** `burndown comment on task`
  (`cachePerPermissions`). `BurndownTimeTrackerViewsHooks::viewsQueryAlter()` scopes the report to
  the current user unless they hold the manage permission.

## Permission

`manage user work hours` (`burndown_time_tracker.permissions.yml`) — "Edit work hour entries for any
user and manage the Burndown time tracker report."
