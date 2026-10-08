<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime AJAX option filtering

How a dependent child field is filtered on entity forms and updated live when the parent changes. All logic is in `dependent_list.module` + `src/Ajax/*`.

## Widget alter (build time)
`hook_field_widget_single_element_form_alter` and `hook_field_widget_complete_form_alter` both delegate to `_dependent_list_alter_widget_element()`. The complete-form alter also handles multi-value checkboxes/radios cases and calls `_dependent_list_add_wrapper_attribute()`. `_dependent_list_alter_widget_element()` does two things per widget:

- **Parent case** — if the field has dependent children (`_dependent_list_get_dependent_children()` matches other fields whose `dependent_list.parent_field` == this field and that have a non-empty `value_map`), it attaches `#ajax`:
  - `callback => dependent_list_update_options_callback`, `event => change`,
  - `wrapper => 'dependent-list-' . childField . '-' . md5(entityUuid)[0..8] . '-wrapper'`,
  - `dependent_list_children => [childFieldNames]`, plus library `dependent_list/dependent_list`.
- **Child case** — if this field has `parent_field` + `value_map` settings: pushes `Checkboxes::processCheckboxes` / `Radios::processRadios` (so option children still build), appends process callback `dependent_list_process_dependent_options` and element-validate `dependent_list_validate_dependent_value`, stores an `#dependent_list` context array (field_name/entity_type/bundle/parent_field/value_map), computes the current parent value (form state preferred over stored entity value via `_dependent_list_get_parent_value_from_form()`), and if that parent value maps to allowed keys sets `#options` to `array_intersect_key(allOptions, allowedKeys)`. It attaches the library plus `drupalSettings.dependentList[field] = {parentField, valueMap}`.

`_dependent_list_add_wrapper_attribute()` wraps the child widget in `<div id="dependent-list-{field}-{uuidhash}-wrapper">` and sets `data-dependent-list-field` so the AJAX `ReplaceCommand` has a stable target even across multiple open IEF rows (the uuid hash keeps ids unique).

## AJAX handler (parent change)
`dependent_list_update_options_callback()` -> service `dependent_list.ajax_handler` -> `DependentListAjaxHandler::updateOptions()`:
1. Reads `#ajax[dependent_list_children]` from the triggering element; resolves parent field/value (`getParentFieldFromTrigger`, `getParentValue`).
2. For each child field, locates its element by walking up the trigger's `#array_parents` (`findFormFieldByParents`, no depth limit) with a recursive `findFormField` fallback for paragraph subforms (`resolveSubform`).
3. Resolves the child `FieldConfig` — from `#entity_type`/`#bundle` via `entityFieldManager`, else by loading all `field_config` entities with that `field_name` and matching one whose `dependent_list.parent_field` equals the trigger's `#field_name`.
4. Builds `options = value_map[parentValue]` intersected with `options_allowed_values()` of the child storage (only keys valid in both).
5. **select** -> `UpdateOptionsCommand` (JS DOM update). **checkboxes/radios** -> server-side re-render of the inner fieldset via `ReplaceCommand`, rebuilt with `Checkboxes::processCheckboxes` / `Radios::processRadios` and manually supplemented `#parents`/`#name`/`#id` so the next POST submits correctly.
6. Calls `_dependent_list_sync_child_form_state()` to drop stale child values, then `drupal_static_reset('options_allowed_values')` + `gc_collect_cycles()`.

`resolveIefEntity()` / `resolveEntity()` handle inline-entity-form and paragraph nesting by reading `#ief_id` / `#paragraph_type` to get the right field definitions.

## Ajax command + JS
`UpdateOptionsCommand` (`src/Ajax/UpdateOptionsCommand.php`) renders `{command:'updateOptionsCommand', elementId, fieldName, parentField, drupalSelector, options:[{key,value}], formatter, multiple}`. `js/update-options-command.js` registers `Drupal.AjaxCommands.prototype.updateOptionsCommand`: for `select` it finds the target select by a derived child `data-drupal-selector` (from the parent selector), then several id/name fallbacks, rebuilds `element.options` via `new Option(value, key)`, and dispatches `change`; for `radios`/`checkboxes` it rebuilds inputs, preserving any still-valid checked values, writing labels with `label.textContent`.

## Validation helpers
Because filtering can leave a chosen value out of `#options`, two callbacks call `_dependent_list_augment_options_for_validation()`:
- `dependent_list_process_dependent_options` (process, `restoreValue = TRUE`) — runs in the build phase before `FormValidator::performRequiredValidation`; adds the submitted value back to `#options` when it is valid per `value_map`, restores a selection core stripped during IEF rebuilds, and only filters when a parent value actually resolved (empty allowed set => leave value intact, avoiding spurious NotNull errors).
- `dependent_list_validate_dependent_value` (element_validate, `restoreValue = FALSE`) — backup that augments `#options` only, never rewrites the already-transposed value.

`_dependent_list_filter_value_for_parent()` drops keys not in the allowed set (checkboxes: filter the map; radios/select: blank a disallowed scalar, keeping `_none`/empty as-is).
