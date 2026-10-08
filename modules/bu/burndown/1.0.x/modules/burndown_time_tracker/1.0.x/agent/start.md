<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Burndown Time Tracker (burndown_time_tracker) — agent index

Optional **Burndown submodule** adding per-user start/stop **task timers** and an **hours report**.
Depends on `burndown` + core `views`. Package `Burndown`, version 1.0.x, `^9 || ^10 || ^11`,
GPL-2.0-or-later. Adds one permission `manage user work hours`.

## Solution docs

- **Timer API, service, forms, access, hooks** → [api/timers.md](api/timers.md)
- Parent module → [../../../../agent/start.md](../../../../agent/start.md)

## What it provides (from source)

- **Schema** (`burndown_time_tracker.install`): table `burndown_time_tracker_timer`
  (`uid` PK, `task_id`, `started`) — one active timer per user.
- **Service** `burndown_time_tracker.task_timer` = `TaskTimerService` (arg `@database`):
  `getActiveTimer(uid)`, `getActiveTimers()`, `startTimer()` (merge on uid), `stopAndRecord()`
  (writes a rounded `work` log entry `>= 0.02h` to the task, then deletes the row).
- **Timer API controller** `TaskTimerController` (routes `/burndown/api/time-tracker/state|start/{ticket_id}|stop`,
  perm `burndown comment on task`) — operates only on the current user's own timer.
- **Forms**: `TimeEntryEditForm` (`/burndown/hours/time-entry/{burndown_task}/{delta}/edit`,
  custom access `HoursReportController::checkTimeEntryAccess`), `ManageWorkTimersForm`
  (`/burndown/hours/manage-work-timers`, perm `manage user work hours`), `HoursReportFilterForm`.
- **Permission**: `manage user work hours` — edit any user's hours + manage running timers.
- **Views**: report `view.burndown_hours.hours` (menu "Hours"), access plugin
  `burndown_hours_access` (`HoursReportAccess`, allows `manage user work hours` OR
  `burndown comment on task`).
- **Event subscriber** `HoursOnlyWorkUnitSubscriber` (attaches the hours-only-units JS library on
  request); **Hook classes** `BurndownTimeTrackerHooks` (help) and `BurndownTimeTrackerViewsHooks`
  (`views_data_alter`, `views_pre_view`, `views_query_alter`, `page_attachments`).
- **Config schema**: `views.access.burndown_hours_access`. **Libraries**: `task_timer`,
  `hours_only_units`.
