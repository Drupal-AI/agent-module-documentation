<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Update Fields — agent index

Adds a content-overview **Action** that mass-updates one or more field values across selected
entities via a multi-step confirm form + batch. Depends on `node`. No Drush commands, no plugin types
defined, no theming.

- **Exclude fields from bulk edit / the `bulk_update_fields.settings` config** → [configure/exclude.md](configure/exclude.md)
- **How the action, multi-step form, tempstore and batch fit together (auto-created actions)** → [api/workflow.md](api/workflow.md)
- **Permissions (and a permission-name gotcha)** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Action plugin id `bulk_update_fields_action_base` (label "Bulk Update Fields to Another Value").
- On install / `hook_entity_operation_alter()` it creates `system.action.bulk_update_fields_on_<entity_type>` per entity type.
- Update flow: `/admin/content` → select → "Bulk Update … Fields" → tempstore `bulk_update_fields_ids` →
  confirm form `/admin/bulk_update_fields` (`BulkUpdateFieldsForm`) → batch.
- Exclude list stored at `bulk_update_fields.settings:exclude` (sequence of field machine names);
  `configure` route = `bulk_update_fields.bulk_update_exclude_form` (`/admin/bulk_update_fields/exclude`).
