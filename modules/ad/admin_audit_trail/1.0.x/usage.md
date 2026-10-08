Admin Audit Trail records create/update/delete (CUD) actions that users perform through the site's admin forms into a dedicated `admin_audit_trail` database table, and shows them in a filterable report at `/admin/reports/audit-trail`.

---

The base module provides the logging plumbing: a database table (`admin_audit_trail`), a procedural logger `admin_audit_trail_insert()`, a Views-based report, a settings form, and an event-handler registry populated through `hook_admin_audit_trail_handlers()`. It ships almost no logging on its own — you enable one of the 16 `admin_audit_trail_*` submodules for each subsystem you want tracked (node, user, taxonomy, menu, media, comment, files, config, workflows, groups, paragraphs, redirects, entityqueue, block content, user roles, authentication). Each submodule registers an event *type* (e.g. `node`, `user`) via the handler hook and implements Drupal entity/CRUD hooks that call `admin_audit_trail_insert()` with a `type`, `operation`, `description`, and optional `ref_numeric` / `ref_char` reference to the affected object. Every row also captures the acting user, client IP, request path, and timestamp. The report is a View with exposed filters by event type, operation, user, IP, and free-text; `hook_cron()` prunes the table to a configurable row limit. Note that `admin_audit_trail_insert()` deliberately ignores CLI requests, so logging only happens for real web-form submissions, not Drush.

---

- Maintain a compliance audit trail (HIPAA, GDPR, SOC 2) of who changed what and when.
- Track how many times create/update/delete operations were performed and by which users.
- Investigate when and how a specific piece of content was modified or deleted.
- Log every node create, update, delete, and translation event for editorial accountability.
- Log user account creation, edits, and deletions for security review.
- Record user login, logout, and password-reset activity for authentication monitoring.
- Audit user role assignments and removals to catch privilege escalation.
- Track taxonomy vocabulary and term changes across your site.
- Monitor menu and menu-link edits, including translated links.
- Record media asset (image, video, document) additions and removals.
- Log managed file uploads and deletions.
- Capture custom block content edits made through the block library.
- Log comment moderation actions (create, update, delete).
- Audit configuration changes through the config event subscriber submodule.
- Track Content Moderation / Workflows state transitions on content.
- Log Group entity membership and content changes on group-based sites.
- Record Paragraph entity edits inside structured content.
- Track redirect entity create/update/delete operations.
- Filter the audit report by event type, operation, acting user, or IP address to answer "who did this?".
- Search log descriptions by keyword to find all events touching a given title or object.
- Cap the audit table size via the row-limit setting so logging never bloats the database.
- Expose the log to site owners through the Views UI, cloning or theming the report as needed.
- Build a custom event type for a contrib entity the bundled submodules don't cover.
- Attach extra context to every log row (or veto rows) with `hook_admin_audit_trail_log_alter()`.
- Reference the affected object by numeric id (`ref_numeric`) and label (`ref_char`) so reports link back to it.
