<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Activity Data Export is a submodule of Activities that adds an admin Views page listing the activity log plus a downloadable CSV/XLS export of that data.

---

Enabling the submodule installs a single View, `views.view.activity_log`, over the parent module's `user_activities` base table. The View ships three displays: a `page` display at `/admin/config/system/activity` ("Activities Log") that renders the log using the Activities module's custom Views fields (description, event link, related-entity link, and the bundle filter), and a `data_export` display at `/admin/config/system/activity/export` that streams the same rows as a downloadable file. An action link "Export all activity log data for content" appears on the log page and points at the export display. The export is powered by the `views_data_export` module (which provides the data-export display) and `xls_serialization` (which adds an XLS serializer alongside core's CSV), and it depends on `rest` for the serialization/encoder stack. It adds no config schema, services, permissions, routes (other than the View's), or Drush commands of its own — it is a thin glue layer: the parent Activities module does the logging, and this submodule surfaces and exports the result. Uninstalling it deletes the `activity_log` View.

---

- Provide administrators a ready-made "Activities Log" page at `/admin/config/system/activity`.
- Download the full user-activity log as a CSV file for offline analysis.
- Export the activity log as an XLS spreadsheet (via xls_serialization).
- Hand auditors a spreadsheet of who created/updated/deleted content and when.
- Feed activity data into an external SIEM or reporting tool via periodic CSV export.
- Produce a compliance report of entity changes over a period from the log view.
- Give non-Drupal stakeholders activity data in a familiar spreadsheet format.
- Archive the activity log to a file before purging old entries.
- Filter the on-screen activity log by bundle before exporting.
- Use the export action link directly from the activity log page.
- Share an activity extract with a colleague without giving them site access.
- Build a scheduled data pipeline off the `activity_log` export path.
- Review recent activity in a paged admin table rather than raw database rows.
- Re-use the shipped `activity_log` View as a starting point for a custom activity report.
- Separate the (optional) export/reporting concern from the core logging module.
- Export activity data to import into a data warehouse.
- Keep an off-site audit copy of user transactions.
- Provide a one-click export button for the audit team.
