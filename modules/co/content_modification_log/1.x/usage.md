<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Modification Log records every create, update, and delete of node and file entities into a dedicated database table and shows them on a date-filterable, CSV-exportable admin report.

---

Content Modification Log gives a site a lightweight audit trail for editorial activity. Using core entity hooks (`hook_entity_insert`, `hook_entity_update`, `hook_entity_delete`), it writes one row per node or file save/delete into its own `content_modification_log` table, capturing the acting user, a client IP, a timestamp, the entity type/id/title/bundle, the revision log message, and the action (created / updated / deleted). Administrators view the history at `/admin/reports/content-modification-log`, a paged, sortable table with a date-range filter form and links back to each node/file. The same data can be exported to a CSV file, and the whole log can be truncated from the settings form behind a confirmation step. Configuration is minimal: rows per page, whether to show a "Modifications" tab on the Content overview page, and the export CSV filename (token-aware). The report, settings, export, and clear actions are all gated behind a single restricted permission. It is an audit tool, so the log itself is sensitive; keep access restricted and set a retention approach. Note the log covers only `node` and `file` entities — not users, taxonomy terms, comments, config, or other entity types.

---

- Keep an audit trail of who changed which content and when.
- Record node create, update, and delete events automatically.
- Record file (managed file) create, update, and delete events automatically.
- Capture the acting user for every content modification.
- Capture the client IP address of each modification.
- Capture a timestamp of each modification.
- Capture the entity title, type, id, and bundle at the time of change.
- Capture the revision log message where one was entered.
- View modifications on an admin report at /admin/reports/content-modification-log.
- Sort the report by entity, title, type, action, author, IP, or time.
- Filter the report by a start date, an end date, or a date range.
- Page through large logs with a configurable rows-per-page limit.
- Follow a report row straight back to the modified node or file.
- Export the (optionally date-filtered) log to a CSV file.
- Use tokens in the export CSV filename.
- Clear the entire log from the settings form behind a confirmation step.
- Show or hide a "Modifications" tab on the Content overview page.
- Support compliance and editorial-oversight reporting.
- Review the modification history of your content over time.
- Restrict who can read, export, or clear the log via one permission.
- Add a Content Modification Log block to a region if desired.
- Enable when an audit record is needed and disable it otherwise.
