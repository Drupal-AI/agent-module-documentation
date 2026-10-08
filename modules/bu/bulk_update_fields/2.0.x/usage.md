<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Update Fields adds a content-overview action that lets an administrator set one or more field values across many selected entities at once, driven by a multi-step confirm form and a batch process.

---

The module registers a single core Action plugin, `bulk_update_fields_action_base` ("Bulk Update Fields to Another Value"), and on install (and via `hook_entity_operation_alter()`) generates one `system.action.bulk_update_fields_on_<entity_type>` config entity per entity type so the action appears on each entity's admin listing. The typical flow starts at `/admin/content`: you tick the entities, choose the "Bulk Update … Fields" action and apply it. `executeMultiple()` stashes the selected entity IDs in a private tempstore (`bulk_update_fields_ids`) and redirects to the confirm form at `/admin/bulk_update_fields` (`BulkUpdateFieldsForm`), a stepped form: step 1 pick which fields to alter, step 2 enter the new value for each, step 3 confirm ("Alter Fields"), after which a batch writes the new values to every selected entity. A companion **exclude** form at `/admin/bulk_update_fields/exclude` (the module's `configure` route, `BulkUpdateExcludeForm`) writes a list of field machine names into `bulk_update_fields.settings:exclude`; excluded fields are hidden from the field-picker so sensitive fields cannot be mass-overwritten. Two permissions gate the feature: `administer bulk_update_fields` (the update form/action) and the exclude form's permission. Date/daterange values are normalized to storage format by the static helpers in `BulkUpdateFields` (`processField()` / `processDate()`), and paragraph fields get special handling. Note the module targets fields generically — you may select a field that only exists on some of the chosen entities.

---

- Set the same value on a field (e.g. a taxonomy reference or boolean flag) across hundreds of nodes in one operation.
- Re-tag a batch of Articles by bulk-setting their category/term field.
- Flip a custom boolean field (e.g. "featured", "archived") on many selected nodes at once.
- Normalize a text field value across legacy content without writing an update hook.
- Bulk-set a datetime/daterange field to a fixed date on many entities (values normalized to storage format).
- Update a link or string field to a new corporate URL/label site-wide via the content overview.
- Apply the action from `/admin/content` after filtering the list to the entities you want to change.
- Protect sensitive fields (e.g. `body`, an author field) from mass edits by adding them to the exclude list.
- Curate the field-picker so editors only see safe-to-bulk-edit fields.
- Give a specific role the `administer bulk_update_fields` permission so only trusted staff can mass-edit.
- Bulk-update fields on non-node entities that expose the auto-generated `bulk_update_fields_on_<type>` action.
- Change a paragraph-referenced field value in bulk (paragraph handling is built in).
- Stage a large editorial correction (typo, rename) across many nodes through the batch process.
- Select fields that exist on only some of the chosen content types — the module tolerates partial matches.
- Preview and confirm the change on an "Are you sure?" step before the batch runs.
- Reset a field to empty/default across a content set by supplying the new (blank) value.
- Combine with a filtered `/admin/content` view to scope the bulk edit to a date range or status.
- Migrate a field's values to a new vocabulary term by bulk-reassigning the reference.
- Exclude base fields (title, status, uid, created, …) automatically — they are never offered for bulk edit.
- Configure the exclude list per site and export `bulk_update_fields.settings` with your configuration.
