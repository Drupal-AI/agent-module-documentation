<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an editorial content-audit toolkit: taxonomies for audit and development status, a group of audit fields (status, date, review/document notes), and a Views listing with exposed filters and bulk operations.

Part of the Sector ecosystem/distribution, it lets teams track where each piece of content sits in an auditing or content-development workflow. It ships two vocabularies (`content_audit`, `content_development`) with sample terms via Default Content, and field storages for `field_content_audit`, `field_content_development`, `field_audit_date`, `field_review_notes`, and `field_document_notes`. On a content type's edit form it adds a "Sector Audit settings" group with an "Add audit fields to the {type}" checkbox; enabling it (submit handler `_sector_content_audit_node_type_form_submit`) programmatically creates the audit `FieldConfig`s on that bundle, sets sensible widgets (options buttons/select, datetime, textareas), optionally binds the document-notes field to a restricted text format via Better Formats, and stores per-type state in `sector_content_audit.settings` (`sectorAudit_{type}`). On node add/edit/translate forms, the audit fields are grouped into an "Audit and review" details section in the advanced sidebar. A `sector_content_audit` View (with Views Bulk Operations) gives a filterable audit dashboard.

Setup: enable the module (pulls in node, taxonomy, views, datetime, default_content, VBO), then per content type check "Add audit fields" on the type's edit page; adjust the shipped View's VBO actions to match your workflow. All configuration is admin-form/config-driven (uses `hook_form_alter` and editable config); there are no custom routes, permissions, or public endpoints, and no untrusted input handling. Note it depends on the Sector Starter Kit for full functionality (e.g. the `restricted_basic_html` format and rabbit-hole term redirects referenced in the README).
---
Editorial audit/review workflow: status taxonomies, audit fields, and a VBO-enabled audit View.
---
- Enable audit fields on a content type from its edit page.
- Track a page's content-audit status via taxonomy.
- Track content-development/production status via taxonomy.
- Record an audit/review due date on nodes.
- Leave review notes and document notes on content.
- Use the Sector Content Audit View to see all audited content.
- Filter the audit View by status via exposed filters.
- Run bulk actions on audited content with Views Bulk Operations.
- Group audit fields into an "Audit and review" sidebar section.
- Start from sample taxonomy terms provided via Default Content.
- Assign a status during a content audit (e.g. due/replace/complete).
- Assign a status during content creation (queued/in progress/review).
- Restrict document-notes formatting via Better Formats + restricted HTML.
- Store per-content-type enablement in `sector_content_audit.settings`.
- Build an editorial dashboard for content review cycles.
- Bulk-reassign or update content flagged for audit.
- Add audit tracking to multiple content types selectively.
- Redirect audit taxonomy terms to a pre-filtered audit view (with Sector).
- Report on stale content by filtering on audit date.
- Set review dates to schedule periodic content re-audits.
- Give reviewers structured note fields instead of ad-hoc comments.
- Integrate content auditing into a Sector distribution site.