Site Audit Report Entity adds a revisionable `site_audit_report` content entity so audit runs can be saved, listed, viewed, and kept over time instead of only printed by Drush.

---

This submodule of Site Audit defines a `site_audit_report` content entity type (base table `site_audit_report`, revisionable and translatable, owner-aware). Each report stores a `label`, a site `uri`, and a `data` field holding the serialized JSON of an audit run (normalized on save via the `serializer` service — hence the `serialization` dependency). It ships an admin route provider so reports have collection/canonical/add/edit/delete pages under `/admin/reports/site-audit/reports`, plus a list builder, a Views data handler, an access control handler, a settings form (`/admin/config/system/site-audit-report`), a bundle/field settings route (`/admin/structure/site-audit-report`), and a `site_audit_report_html` field formatter that renders the stored report data as HTML. Static helpers on the entity class generate report data by running the audit: `SiteAuditReport::saveReport($label, $log)` runs a full audit and saves a new entity; `getNewReportData()` / `audit('json')` produce the underlying data. Access is governed by five permissions (create/view/edit/delete plus "administer site audit report"). When a user is cancelled or deleted, their reports are anonymized or removed (`hook_user_cancel` / `hook_ENTITY_TYPE_predelete`).

---

- Save the result of an audit run as a persistent entity for later review.
- Keep a history of audits over time using the entity's revisions.
- List all saved audit reports at /admin/reports/site-audit/reports.
- View a stored report rendered as HTML via the `site_audit_report_html` formatter.
- Compare audits across dates by inspecting successive revisions.
- Programmatically create a saved report with `SiteAuditReport::saveReport($label, $log)`.
- Build a Views listing of saved reports (Views data is provided).
- Attach fields to the report entity via the field UI (field_ui base route provided).
- Control who can create/view/edit/delete reports with the five permissions.
- Anonymize a departing user's saved reports automatically on account cancel.
- Delete a user's reports automatically when the account is deleted.
- Store the serialized JSON audit data for external processing.
- Track the site URI and label alongside each report.
- Provide a canonical page per report for linking/sharing internally.
- Add an "Add Site Audit Report" action from the audit page.
- Feed saved reports to the site_audit_send submodule for remote delivery.
- Retain audit evidence for compliance or client reporting.
- Use revisions' log messages to note why an audit was captured.
- Expose report data in a dashboard by querying the entity.
- Serve as the storage layer that cron-based saving (site_audit_send) writes into.
