<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Events Logger records Drupal system events — entity create/update/delete and form submissions — as `elog` entities, capturing a token-formatted message, an entity diff of what changed, the submitted form values, and the requester IP and user agent, all browsable and exportable through a bundled Views listing.

---

Drupal's watchdog records that something happened; elogger records what changed and by whom, storing each event as a queryable `elog` content entity rather than a transient log line. Its hooks fire on every entity insert/update/delete and (via a global form-submit handler) on form submissions, so no code is required to start logging — you choose which modules' entity events and which form ids to track from the `elogger.settings` config (forms default to `*`, all forms, with the login, registration and Commerce checkout forms excluded). For content updates it uses the `diff` module to store a before/after comparison that renders as a diff table in the listing; for form submissions it serializes the submitted values and shows them in a collapsible JSON panel. The listing lives at `/admin/reports/elogger` and leans on `views` to browse, `views_bulk_operations` for bulk actions, and `views_data_export` for a CSV export (`elogger.csv`). Configuration is split across `/admin/config/system/elogger` (tracked modules and form ids), `/admin/config/system/elogger/log-messages` (per-event message templates and text format) and `/admin/config/system/elogger/settings` (how many rows to keep). A cron job prunes the `elog` table to that row limit. When the core `syslog` module is enabled, each event can additionally be forwarded to raw syslog or watchdog using a configurable token format set on the *Logging and errors* page. Programmatic logging is available through the `elogger.logger` service with `setEntity()`/`setForm()` then `logEvent()`. Core requirement is `^9 || ^10 || ^11`.

---

- Record what changed in an entity, not just that it changed.
- Keep a browsable history of who created, updated or deleted content.
- Show a before/after diff for an entity update.
- Log submissions of a specific set of forms by form id.
- Log every form submission on the site with the `*` setting.
- Capture the submitted values of a form for later review.
- Restrict logging to a chosen set of modules' entity events.
- Browse the event history through a Views listing at `/admin/reports/elogger`.
- Filter the listing by module or event type.
- Export the event log to CSV for offline review.
- Bulk-delete log entries with Views Bulk Operations.
- Customize each event's message with tokens and built-in placeholders.
- Cap the log table size and let cron prune old rows.
- Forward events to raw syslog when the syslog module is enabled.
- Forward events to watchdog/dblog in a custom token format.
- Log an event from custom code via the `elogger.logger` service.
- Record the IP address and user agent behind each tracked action.
- Investigate an unexpected content change from the stored diff.
- Track menu, view or taxonomy entity changes.
- Give reviewers a searchable activity history.
- Report on editorial activity across the site.
- Choose the text format applied to stored log messages.
