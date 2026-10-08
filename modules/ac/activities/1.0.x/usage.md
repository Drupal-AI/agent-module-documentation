<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Activities tracks and logs user transactions — create, update, delete, and view (read) operations on Drupal entities — into a queryable `user_activities` log for auditing who changed what and when.

---

The module listens to core entity CRUD hooks (`hook_entity_insert`/`update`/`delete`/`view`) and, for each entity type/operation you have opted into, records a `user_activities` content-entity row capturing the acting user, operation, a human-readable description and link to the affected entity, the related entity's type/id/bundle, a timestamp, IP address, and location. You choose exactly what is logged on the settings form at `/admin/config/activities`: for every content entity type it offers Create/Delete/Update/View checkboxes and an optional per-bundle restriction (leave bundles empty to log all). Because logging **View** fires on every page request for that entity type, the form also exposes security controls — a per-user/per-entity view throttle window (default 60s) and an "exclude anonymous users from view tracking" toggle (default on) — to protect against log-spam/DoS. Configuration is stored in one `activities.settings` object (per-entity-type maps plus `security` and `purge` sections). To keep the log from growing without bound, a purge service runs on cron with three methods — never, time-based (delete entries older than N days/…), or count-based (keep at most N entries) — configured at `/admin/config/activities/purge`, plus a manual purge form. The log itself is exposed through Views (the `user_activities` base table with custom description/link fields and a "Filter by bundles" filter), three services (`activities.logger`, `activities.manager`, `activities.purge`) let you log/summarise/purge programmatically, and `hook_activities_logger_log` lets other modules alter an activity before it is saved. Three permissions gate viewing, administering, and manually purging activity. The bundled **Activity Data Export** submodule adds a Views page + CSV/XLS export of the log.

---

- Keep an audit trail of who created, edited, or deleted content on the site.
- Log all updates to user accounts for security/compliance review.
- Track deletions of taxonomy terms to investigate accidental removals.
- Record view (read) access to a sensitive content type for auditing.
- Restrict logging to specific bundles (e.g. only "Article" and "Page" nodes).
- Enable only Create and Delete logging for nodes while ignoring updates.
- Throttle duplicate view logs from the same user within a 60-second window to prevent spam.
- Exclude anonymous users from view tracking on a public site to reduce database load.
- Automatically purge activity entries older than 90 days via cron (time-based purge).
- Cap the activity log at a maximum number of rows (count-based purge) to bound growth.
- Disable automatic purging entirely (purge method "never") for full retention.
- Manually purge activity entries on demand from the admin form.
- Review recent activity through a Views listing of the `user_activities` entity.
- Filter the activity log by acting user, entity type, operation, bundle, or date range.
- See the IP address and location associated with each logged action.
- Grant auditors the "can view users activity" permission without full admin rights.
- Restrict manual purging to trusted admins via the "purge activities" permission.
- Log activity programmatically from custom code via the `activities.logger` service.
- Alter or enrich an activity record before it is saved using `hook_activities_logger_log`.
- Count how many activities exist per entity type or bundle for reporting.
- Purge activities for one specific entity type or bundle via the purge service.
- Export the full activity log to CSV or XLS using the Activity Data Export submodule.
- Build a compliance report of entity changes over a chosen time period.
- Investigate an incident by tracing all operations a given user performed.
