<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up Sector Content Audit

## Install
Enable the module — it requires `node`, `taxonomy`, `views`, `datetime`, `user`, `default_content`, and `views_bulk_operations` (VBO). For full behavior it expects the **Sector Starter Kit** (e.g. the `restricted_basic_html` text format and rabbit-hole term redirects mentioned in the README).

On install it provides:
- Vocabularies `content_audit` and `content_development` with sample terms (via Default Content).
- Field storages: `field_content_audit`, `field_content_development`, `field_audit_date`, `field_review_notes`, `field_document_notes`.
- A `sector_content_audit` View with exposed filters and VBO.

## Enable audit fields per content type
1. Edit the content type: `/admin/structure/types/manage/<type>`.
2. Under **Sector Audit settings**, check **Add audit fields to the &lt;type&gt; content type**.
3. Save. The submit handler `_sector_content_audit_node_type_form_submit()`:
   - Calls `_sector_content_audit_create_audit_fields()` to create the five audit `FieldConfig`s on the bundle with widgets: `field_content_audit` → options buttons, `field_content_development` → options select, `field_audit_date` → datetime, `field_review_notes`/`field_document_notes` → textareas. `field_document_notes` is bound to `restricted_basic_html` via Better Formats third-party settings when that format exists.
   - Saves `sectorAudit_<type> = 1` in config `sector_content_audit.settings`.

Once enabled, node add/edit/translate forms show the audit fields grouped under an **Audit and review** details section (advanced sidebar), via `hook_form_alter`.

## Audit dashboard
Use/adjust the `sector_content_audit` View — enable the VBO actions that match your publishing workflow, and use the exposed filters (status, audit date) to review content.
