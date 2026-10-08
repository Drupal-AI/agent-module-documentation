<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ultimate Cron Views integrates Ultimate Cron's job-log data with Views, letting administrators report cron run history, durations, and frequency through configurable table views instead of the stock log screen.

---

It ships a custom Views query plugin (`CronLogSqlQuery`) plus field handlers (`CronLogJobStartDate`, `CronLogJobEndDate`, `CronLogJobDuration`) that map synthetic datetime/duration fields onto Ultimate Cron's real `start_time`/`end_time` log columns using `FROM_UNIXTIME` and `ROUND`. A bundled view (`views.view.ultimate_cron_views`) provides `summary` and `detail` displays, and a settings form lets you pick which view/display to render for each and choose the date format. Two controller routes render the chosen view displays under `/admin/config/system/cron/views/...`, surfaced as local tasks on the Ultimate Cron job collection. Everything is read-only reporting: the module never runs, enables, disables, or deletes cron jobs.

All three routes are gated by the `administer ultimate cron` permission, so there is no anonymous or low-privilege exposure and no state-changing endpoint. The SQL fragments in the query plugin interpolate only Views-internal table/field identifiers (not request input), so they are standard query-plugin practice rather than an injection vector. Setup is: enable the module (Ultimate Cron and Views are required), then optionally adjust the settings form to point at a custom view/display or change the timestamp format.
---
- Report cron job run history through a Views table.
- Show each job's last start and end time in a view.
- Compute and display cron job run durations.
- Provide a summary view of all cron jobs' recent runs.
- Provide a detail view drilling into a single job's log.
- Point the summary/detail tabs at a custom view display.
- Change the timestamp format used in the cron log views.
- Add cron log reporting tabs to the Ultimate Cron job collection page.
- Build a dashboard of slow-running cron jobs by sorting on duration.
- Filter cron log entries by job name using Views exposed filters.
- Expose cron start/end/duration as Views fields for custom displays.
- Reuse the bundled `ultimate_cron_views` view as a starting template.
- Audit which scheduled jobs ran and when, without reading raw logs.
- Restrict cron log reporting to holders of `administer ultimate cron`.
- Clone the default view to add columns or grouping.
- Track cron reliability over time via a saved view.
- Present cron history to admins in a familiar Views table UI.
- Sort jobs by most recent run to spot stalled schedules.
- Configure separate views for the summary and detail tabs.
- Keep reporting read-only, with no risk of triggering cron actions.
