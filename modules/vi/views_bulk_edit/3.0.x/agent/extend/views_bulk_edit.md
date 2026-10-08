# Control affected fields & extend the action

VBE defines **no alter hook and no `*.api.php`**. The supported way to control *which* fields
are bulk-editable and *how* is the `bulk_edit` form mode plus the two Action plugin classes.

## Control the editable fields — the `bulk_edit` form mode

The edit form for each bundle is rendered from that bundle's **`bulk_edit`** entity form-mode
display, via `EntityFormDisplay::collectRenderDisplay($entity, 'bulk_edit')`.

- Define a form mode with machine name **`bulk_edit`** at
  `/admin/structure/display-modes/form`, enable it per bundle, and arrange the fields you want
  editable in bulk. Only those fields appear in the action's form.
- If no `bulk_edit` display exists for a bundle, the **default** form display is used.
- Fields whose widget is not display-configurable on the form (`isDisplayConfigurable('form')`
  returns FALSE) are always removed, even if present.

This is the intended extension point in place of a form-alter hook: shape the `bulk_edit`
form mode to add/remove bulk-editable fields.

## The two Action plugins (subclassing)

`src/Plugin/Action/`:

- **`ModifyEntityValues`** (id `views_bulk_edit`, `type = ""` → all entity types) — the VBO
  action. Extends `Drupal\views_bulk_operations\Action\ViewsBulkOperationsActionBase` and
  implements `ViewsBulkOperationsPreconfigurationInterface`
  (`buildPreConfigurationForm` → the `get_bundles_from_results` option). Uses
  `BulkEditFormTrait` for `buildConfigurationForm` / `submitConfigurationForm` / `execute`.
  `access()` = entity `update` access. Subclass this to build a specialized VBO edit action.
- **`EditAction`** (id `entity:edit_action`, deriver
  `EntityEditActionDeriver`) — a core Action extending `EntityActionBase`. The deriver
  (`EntityActionDeriverBase`) creates one derivative per entity type implementing
  `FieldableEntityInterface`. `executeMultiple()` records the selection in the
  `entity_edit_multiple` private tempstore keyed by user; its `confirm_form_route_name` is
  `views_bulk_edit.edit_form`.

## Change-method logic (in `BulkEditFormTrait::execute`)

Reference when overriding: `replace` sets the value; `append` concatenates onto
`current_value[0]['value']`; `new` does `array_unique(array_merge(current, new), SORT_REGULAR)`
for multi-value fields. Values and per-field methods are stored under
`$this->configuration[$entity_type_id][$bundle]['values' | 'change_method']`.
