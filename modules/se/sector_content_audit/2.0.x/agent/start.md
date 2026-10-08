<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector Content Audit (sector_content_audit) — agent index

**Adds audit/review status taxonomies, an audit field group, and a VBO-enabled Views listing to track content auditing and development.**

- **Version:** 2.0.x · **Package:** Sector · **Core:** ^10.1 || ^11 || ^12
- **Depends on:** default_content, datetime, node, taxonomy, user, views, views_bulk_operations. (Best with the Sector Starter Kit.)
- **Ships:** vocabularies `content_audit` + `content_development` (sample terms via Default Content); field storages `field_content_audit`, `field_content_development`, `field_audit_date`, `field_review_notes`, `field_document_notes`; view `sector_content_audit`.
- **Behavior:** `hook_form_node_type_edit_form_alter` adds a "Sector Audit settings" checkbox; on submit `_sector_content_audit_node_type_form_submit` creates the audit fields on the bundle and stores `sectorAudit_{type}` in config `sector_content_audit.settings`. `hook_form_alter` groups the audit fields into an "Audit and review" section on node add/edit/translate.
- **Routes/permissions:** none of its own.

**Security:** no custom routes, permissions, or public endpoints; configuration is via admin content-type forms and editable config only, no untrusted-input handling. No security findings.

See [configure/setup.md](configure/setup.md).