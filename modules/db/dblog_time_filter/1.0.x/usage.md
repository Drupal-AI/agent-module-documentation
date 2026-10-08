Adds a quick relative-time-range select and a live server clock to Drupal's core "Recent Log Messages" report (/admin/reports/dblog).

---

DBLog Time Filter is a small utility module that improves the debugging experience on Drupal Core's watchdog report page without any configuration. It attaches to the core `watchdog` View's exposed filter form via `hook_form_FORM_ID_alter()`, injecting a "Time" select element with relative options (last 10 minutes, hour, 12 hours, day, week) whose value is a duration in seconds. A companion `hook_views_query_alter()` reads that duration from the exposed input, computes `now - duration` from the request time, and adds a `watchdog.timestamp >= start` condition to the View query so only recent log rows are shown. The module also renders a "Current Server Time" element above the form and attaches a JavaScript library (`dblog_time_filter/time_updater`) that moves the clock outside the form and updates it every second using the offset between the server timestamp captured at page load and the client clock. A small CSS file repositions the clock to the top-right and tightens the filter form's vertical spacing. The module ships no permissions, routes, services, config, or plugins — access is gated entirely by core's existing "access site reports" permission on the dblog report page.

---

- Filter the Recent Log Messages report to only entries from the last 10 minutes while reproducing a bug.
- Show only log messages from the last hour after triggering an error, without manually computing timestamps.
- Narrow the watchdog report to the last 12 hours when reviewing a scheduled/cron job's output.
- Review the last day of log activity for a quick daily health check.
- Inspect the last week of log entries to spot a recurring warning.
- Reset back to the full, unfiltered log by choosing "- No time filter -".
- Read a live, second-by-second "Current Server Time" clock to correlate log timestamps with real-world events.
- Compare the displayed server time against your local machine time when logs look "off" due to timezone differences.
- Give developers a consistent time reference on the dblog page regardless of the client's local clock.
- Combine the time range select with core's existing Type and Severity exposed filters on the watchdog View.
- Speed up incident triage by jumping straight to recent entries instead of paging through the whole log.
- Use the relative filter as a lightweight alternative to writing a custom Views time filter.
- Keep the dblog report tidier and more compact via the module's spacing adjustments.
- Deploy on Drupal 10 or 11 sites (core_version_requirement ^10 || ^11) as a no-config debugging aid.
- Enable temporarily on a staging or production site during an active investigation, then disable.
- Confirm whether a just-triggered event has been logged yet by watching the live clock alongside the newest rows.
- Provide support/ops staff a one-click way to scope logs to a recent window.
- Avoid manually editing the watchdog View to add relative-time filtering.
- Correlate front-end user reports ("it broke a few minutes ago") to a matching log window quickly.
- Use as a reference example of altering a core View's exposed form and query with `hook_form_FORM_ID_alter()` and `hook_views_query_alter()`.
