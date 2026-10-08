<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The action + confirm-form + batch workflow

## The Action plugin

`src/Plugin/Action/BulkUpdateFieldsActionBase.php`:

```php
@Action(
  id = "bulk_update_fields_action_base",
  label = "Bulk Update Fields to Another Value",
  type = "node",
  confirm_form_route_name = "bulk_update_fields.form"
)
```

- `executeMultiple($entities)` keys the selected entities by `id:langcode` and stores them in the
  private tempstore collection `bulk_update_fields_ids` under the current user id. `execute()` just
  calls `executeMultiple([$entity])`.
- `access()` returns the entity's `update` access — so a user can only bulk-edit entities they may edit.

## Auto-created action config entities

`bulk_update_fields.module` creates a `system.action.bulk_update_fields_on_<entity_type>` config entity
for **every** entity type, on `hook_install()` and again in `hook_entity_operation_alter()` when one is
missing. Each uses `plugin: bulk_update_fields_action_base`, `type: <entity_type>`, label
"Bulk Update &lt;Entity Type Label&gt; Fields". A base action `system.action.bulk_update_fields_action_base`
(type `node`) also ships in `config/install`. This is what makes the action appear on each entity's
admin listing / VBO.

## The multi-step form

`src/Form/BulkUpdateFieldsForm.php` (route `bulk_update_fields.form` → `/admin/bulk_update_fields`),
a `FormBase` with a `$step` counter:

1. **Step 1** — choose which field(s) to alter (the exclude list from
   `bulk_update_fields.settings:exclude` is removed from the choices).
2. **Step 2** — enter the new value for each chosen field. Datetime/daterange values are normalized;
   paragraph fields have dedicated handling.
3. **Step 3** — "Are you sure?" confirm; on submit `updateFields()` runs a **batch** that loads each
   tempstored entity and writes the new values.

Value normalization helpers live in `src/BulkUpdateFields.php`:
- `processField($value, $field_definition)` — for `date*` field types calls `processDate()` to convert
  to `DATE_STORAGE_FORMAT` / `DATETIME_STORAGE_FORMAT` (and `end_value` for `daterange`).
- `preprocessField()` — unwraps `target_id` / strips `add_more` / handles `value` sub-keys.

There is no public service/API to call for a headless bulk update — the operation is UI/batch driven.
The scriptable surface is the `bulk_update_fields.settings:exclude` config (see `configure/exclude.md`).
