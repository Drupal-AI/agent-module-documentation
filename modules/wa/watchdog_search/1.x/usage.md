Watchdog Search replaces the core database-log report page with a searchable, multi-filter version of the same log messages.

---

Drupal core's Recent log messages page (`/admin/reports/dblog`, provided by the `dblog` module) offers only type and severity filters and no free-text search, so tracking down a specific message in a busy log means paging through it. Watchdog Search overrides that page with a custom controller that adds a text search box (matched against the message text, its serialized variables, the acting username and the log ID), keeps the type and severity multi-select filters, and adds a From/To date range. It disables the core `views.view.watchdog` view via a config override and re-points the `dblog.overview` route to its own controller, so it drops into the existing report with no new route, permission or settings page. Results are paged (50 per page) and sortable, and each truncated message opens the full core log-event view in an AJAX modal. Access is unchanged from core: the page stays behind the standard log-report permission.

---

- Search Recent log messages by free text instead of paging through the whole log.
- Find a specific error by typing a fragment of its message.
- Locate all log entries whose serialized variables contain a value.
- Filter the log to entries created by a specific username.
- Jump straight to a log entry by its numeric watchdog ID.
- Combine a text search with a type filter (for example `php` errors only).
- Combine a text search with one or more severity levels.
- Narrow the log to a date/time range with the From and To pickers.
- Restrict triage to "everything after last night's deploy".
- Restrict triage to "everything before an incident window".
- Apply several filters at once, then share the resulting URL with a colleague.
- Reset all filters back to defaults with the Reset filters button.
- Sort the filtered results by ID, type, date or user.
- Open a matched message in a modal without leaving the report page.
- See the severity and watchdog ID in the modal title for quick reference.
- Speed up production incident triage on sites with high log volume.
- Audit which user triggered a run of similar log entries.
- Keep the standard core log-report access restricted to trusted roles.
- Give support staff a faster way to inspect logs without database access.
- Use it as a drop-in upgrade to the core dblog report with no reconfiguration.
- Enable it only where log search is needed and leave it off elsewhere.
