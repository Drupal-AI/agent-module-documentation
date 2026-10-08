<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Connect hooks

All hooks are documented in `entityconnect.api.php`. Implement them in `<yourmodule>.module`.

## Choosing what gets buttons

| Hook | Purpose |
|---|---|
| `hook_entityconnect_exclude_forms_alter(array &$exclude_forms)` | Add form ids that Entity Connect must **not** process (e.g. `search_block_form`, `page_node_form`). |
| `hook_entityconnect_ref_fields_alter(array &$ref_fields)` | Alter the set of reference fields that receive add/edit buttons. |
| `hook_entityconnect_field_attach_form_alter(array &$data)` | Change the target `entity_type`, `acceptable_types`, or `field_definition` for a field. |

## Altering the cached parent-form payload

`hook_entityconnect_add_edit_button_submit_alter(array &$data)` — change the data cached when a button is
pressed. `$data` includes `form`, `form_state`, `dest`, `params`, `field`, `field_info`, `key`,
`add_child`, `target_id`, `target_entity_type`, `acceptable_types`, `field_container`,
`field_container_key_exists`.

## Building / altering the add & edit choice screens

| Hook | Purpose |
|---|---|
| `hook_entityconnect_add_info($cache_id, $entity_type, array $acceptable_types)` | Build the render array of entity types offered by the "add" screen. |
| `hook_entityconnect_add_info_alter(array &$info, array $context)` | Alter that add render array (`context`: cache_id, entity_type, acceptable_types). |
| `hook_entityconnect_edit_info($cache_id, $entity_type, $target_id)` | Build the render array for the "edit" screen. |
| `hook_entityconnect_edit_info_alter(array &$info, array $context)` | Alter that edit render array (`context`: cache_id, entity_type, target_id). |

## Altering the child (target) form and its return

| Hook | Purpose |
|---|---|
| `hook_entityconnect_child_form_alter(array &$data)` | Alter the target add/edit form (`data`: form, form_state, form_id). |
| `hook_entityconnect_child_form_submit_alter(array &$data)` | Alter the child form's submit handling (`data`: form, form_state, entity_type, cached data). |
| `hook_entityconnect_return_form_alter(array &$data)` | Set the value written back to the parent field when the field type can't be auto-determined; set `$data['element_value']`. |
