<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recursive delete mechanism

All logic lives in `err_delete.module` (procedural helpers), `src/Form/ErrDeleteForm.php`,
and `err_delete.routing.yml`. No services, no plugins, no classes beyond the two forms.

## 1. Adding the button — `err_delete_form_node_form_alter()`

`err_delete.module` implements `hook_form_node_form_alter()`:

- Runs only when `$form_id` contains `edit_form`.
- Iterates the node's `getFieldDefinitions()`; sets `$has_ref_field = true` if any definition is a
  `FieldConfigInterface` whose type is `entity_reference` or `entity_reference_revisions`
  (base fields, being not `FieldConfigInterface`, are ignored).
- If `$has_ref_field` **and** `\Drupal::currentUser()->hasPermission('err delete entities')`:
  - reads config `err_delete.settings` (`replace_delete`, `replace_delete_label`);
  - if `replace_delete` is truthy, `unset($form['actions']['delete'])` (removes core's Delete);
  - adds `$form['actions']['err_delete']` — a `#type => link` (classes `button button-danger`,
    `#weight => 100`) to `Url::fromRoute('err_delete.ref_delete', ['node' => $entity->id()])`.
    Label defaults to `Recursive Delete` when `replace_delete_label` is empty.

## 2. The route

`err_delete.ref_delete` → path `/node/{node}/ref_delete`, form `ErrDeleteForm`,
`requirements: _permission: 'err delete entities'`, `options._admin_route: TRUE`,
`node` param typed `entity:node`. A local task (`err_delete.links.task.yml`) exposes it under
`entity.node.delete`.

## 3. Building the checklist — `getFormElement()` / `getRecursiveFormElement()` / `getChildren()`

`ErrDeleteForm::buildForm(array $form, FormStateInterface $form_state, EntityInterface $node)`
merges in `getFormElement($node)` and adds a hidden `delete_node_id` (the node id) plus a
primary `Delete` submit button.

- `getFormElement($entity, $parent = true, &$discovered_entities = [])` — for a
  `FieldableEntityInterface`, loops its `entity_reference` / `entity_reference_revisions`
  FieldConfig fields that have items (`$field->count() > 0`) and calls
  `getRecursiveFormElement()` per field, merging results under `$form['recursive']`. For the
  top-level (`$parent`) call it prepends an explanatory `description` markup element.
- `getRecursiveFormElement($field_definition, $field_id, $field, &$discovered_entities)` — builds
  a `#tree => true` fieldset per field. For each referenced target entity:
  - skips items whose target resolves to a `user` bundle (`return`);
  - if the entity was already discovered, emits a `is_circular` hidden flag + a
    "Circular reference detected" item instead of a checkbox;
  - otherwise emits, keyed by referenced entity id under `references`:
    a `delete` **checkbox** (shown when the user can view the entity's label),
    hidden `target_entity_type_id` and `target_bundle`, and — for a `ContentEntityInterface` —
    a nested `children` element from `getChildren()`.
- `getChildren($referenced_entity, &$discovered_entities)` — records the entity in
  `$discovered_entities[type][id]` (this is how circular refs are caught), then recurses via
  `getFormElement($referenced_entity, false, $discovered_entities)`.

## 4. Performing the delete — `ErrDeleteForm::submitForm()` + `deleteRefEntities()`

- `submitForm()` takes `$form_state->cleanValues()->getValues()`, reads `delete_node_id`, calls
  `deleteRefEntities($values)`, then loads the node (`entityTypeManager()->getStorage('node')
  ->load($node_to_delete)`) and calls `$node->delete()`. Redirects to `/admin/content`.
- `deleteRefEntities($values)` — walks `$values['recursive']`; for each `references` item whose
  `delete == 1`, loads the entity via
  `entityTypeManager()->getStorage($ref_values['target_entity_type_id'])->load($ref_id)` and calls
  `$entity->delete()` if it exists; then recurses into `$ref_values['children']`.

## Notes

- Only **nodes** get the button (the alter targets `hook_form_node_form_alter`), but referenced
  entities of any type can appear in and be deleted through the checklist.
- User-bundle references are always excluded from deletion.
- There is no confirmation step beyond this form's own `Delete` submit button; deletion is
  permanent (`$entity->delete()`), not a soft delete.
