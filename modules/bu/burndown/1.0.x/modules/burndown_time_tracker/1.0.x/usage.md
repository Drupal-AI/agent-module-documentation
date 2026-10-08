Optional Burndown submodule that adds per-user start/stop task timers and an hours report/editor for Burndown Task work-log entries.

---

Burndown Time Tracker layers time tracking onto the parent Burndown module. Each user gets a single active timer (one row per user in the `burndown_time_tracker_timer` table, keyed by uid). Starting a timer on a task stops and records any previously running timer; stopping records the elapsed time as a rounded "work" entry in the task's Burndown work log (entries under ~0.02h are discarded as noise). It ships an "Hours" report view (`view.burndown_hours.hours`) showing the current user's logged hours, an individual time-entry edit form, and a "Manage work timers" admin screen. A single permission, `manage user work hours`, lets time managers edit any user's hours and stop other users' running timers; other users can only start/stop their own timer and edit their own work entries. Requires the parent `burndown` module and core `views`.

---

- Add a start/stop stopwatch to Burndown tasks so users clock time as they work.
- Record actual time spent on a task as a work-log entry automatically when the timer stops.
- Ensure only one timer runs per user at a time (starting a new one banks the previous).
- Show each user a personal "Hours" report of their logged Burndown time.
- Let a user edit an individual time entry (correct hours or the comment) after the fact.
- Give project/team leads a "Manage work timers" screen to see and stop running timers.
- Let a time manager edit work-hour entries for any user via the `manage user work hours` permission.
- Filter the hours report (via `HoursReportFilterForm`) to review a period's logged work.
- Capture billable hours for client projects run in Burndown.
- Keep time data attached to the task's existing work log rather than a separate system.
- Discard trivially short timers so accidental start/stop clicks don't create 0.00h noise.
- Report on team effort by summarizing recorded work entries across tasks.
