# Site Audit Report Entity — agent index

Adds a revisionable `site_audit_report` content entity to save audit runs. Depends on `site_audit`
and `serialization`.

- **The entity type, routes, permissions, static save helpers, field formatter** →
  [api/entity.md](api/entity.md)

Key facts:
- Entity type id `site_audit_report`; base table `site_audit_report`; revisionable + translatable;
  owner (`uid`) aware; admin permission `administer site audit report`.
- Key fields: `label`, `uri`, `data` (serialized JSON audit output, normalized on save).
- Routes under `/admin/reports/site-audit/reports` (collection/canonical/edit/delete) + add at
  `/admin/reports/site-audit/save`; settings route `site_audit_report_entity.settings_form`
  (`/admin/config/system/site-audit-report`); bundle settings `entity.site_audit_report.settings`.
- Permissions: `create/view/edit/delete site audit report`, `administer site audit report`.
- Static helpers: `SiteAuditReport::saveReport($label, $log)` (runs a full audit + saves),
  `sendReport(...)`, `audit('json'|'html')`.
- Field formatter `site_audit_report_html` renders stored report data as HTML.
