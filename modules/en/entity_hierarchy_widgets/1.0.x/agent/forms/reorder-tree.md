<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Whole-tree reorder form

Lets an editor re-parent and reorder an entire Entity Hierarchy tree in one drag-and-drop table,
instead of editing children one entity at a time.

## Wiring (how the tab/route appear)

`hook_entity_type_build()` via `Hook\EntityHierarchyWidgetsHook::entityHierarchyWidgetsEntityTypeBuild()`
(bridged from `entity_hierarchy_widgets.module`). For every `ContentEntityType` that has a `canonical`
link template it:

- adds route provider `entity_hierarchy_tree_edit` = `Routing\EntityHierarchyWidgetsTreeRouteProvider`;
- sets form handler `entity_hierarchy_widgets_tree_edit` = `Form\EntityHierarchyWidgetsTreeForm`;
- sets the `entity_hierarchy` handler to `EntityHierarchyHandler` (node → `NodeEntityHierarchyHandler`);
- adds link template `entity_hierarchy_widgets_tree_edit` = `{canonical}/hierarchy`.

**Route** (`EntityHierarchyWidgetsTreeRouteProvider::getRoutes()`, extends
`entity_hierarchy`'s `EntityHierarchyRouteProvider`): id `entity.{type}.entity_hierarchy_widgets_tree_edit`,
path `{canonical}/hierarchy`, `_entity_form: {type}.entity_hierarchy_widgets_tree_edit`. Requirements:
`_entity_access: {type}.view`, `_permission: 'reorder entity_hierarchy_widgets hierarchy'`, and the
`entity_hierarchy` "has field" requirement; `_admin_route: FALSE`; loads the default (non-latest)
revision.

**Local task** ("Hierarchy" tab, weight 30/100): `Plugin\Derivative\HierarchyLocalTasks` derives one
tab per entity type found via `getFieldMapByFieldType('entity_reference_hierarchy')` that has a canonical
link, base route `entity.{type}.canonical`. Task plugin base is `entity_hierarchy_widgets.links.task.yml`
`entity_hierarchy_widgets.reorder_hierarchy`.

**Permission** (`entity_hierarchy_widgets.permissions.yml`): `reorder entity_hierarchy_widgets hierarchy`
(title/description "Reorder hierarchy").

## The form — `Form\EntityHierarchyWidgetsTreeForm`

`ContentEntityForm`; `getFormId()` = `entity_hierarchy_widgets_tree_form`; `getBaseFormId()` returns
NULL (no parent entity form); title "Edit hierarchy".

- `form()`: gets candidate hierarchy fields via `ParentCandidate::getCandidateFields($entity)`; throws
  `NotFoundHttpException` if none. If exactly one field → hidden `fieldname` value; if several → a
  `select` (`fieldname`) plus an **Update** submit (`::updateField`) to switch fields. Builds a `#type
  => table` with `#tabledrag` (match `parent` on group `entity-parent`, order `sibling` on group
  `entity-weight`, source `entity-id`), fetches the tree with `TreeBuilder::getTrees($entity)`, stashes
  it in `$form_state` temporary value `tree`, and fills rows via `buildTreeRows()`. Adds a **Save
  hierarchy** submit.
- `buildTreeRows()`: for each `Record` in each tree, loads the entity, skips non-`ContentEntityInterface`,
  and builds `$table[$entity_id] = $formHelper->buildTableRow($record)`; plugin/malformed exceptions are
  logged to the `entity_hierarchy` channel.
- `validateForm()`: counts rows with `parent == 0`; if more than one root, sets an error
  ("Positioning multiple elements on root level would split the hierarchy…").
- `submitForm()`: iterates the stashed tree records; for each entity resolves the hierarchy field with
  `TreeBuilder::getHierarchyFieldname()` and calls `addEntityToBatch()`. If any operations, `batch_set()`;
  otherwise a "No changes were made" status.
- `addEntityToBatch()`: reads submitted `table[$id]['weight']` and `['parent']` (0 → NULL parent) and
  queues a `reorderBatch` op **only if** the parent target_id or weight differs from the stored value.
- `reorderBatch()` (static batch op): loads the entity by type+id and, if found,
  `set($fieldName, ['target_id' => $new_parent_id, 'weight' => $new_weight])` then `save()`.
- `batchFinished()`: status/error message.

## Row rendering — `FormHelper` (`entity_hierarchy_widgets.form_helper`)

`buildTableRow(Record)` returns a draggable row: title cell (`buildTitleCell` — core `indentation` theme
sized to `Record::getDepth()` + a `Link::fromTextAndUrl($entity->label(), $entity->toUrl())` rendered to
markup); operations cell (`buildOperationsCell` — adds **Edit** only if `$entity->access('update')` and an
`edit-form` template, **Delete** only if `$entity->access('delete')` and a `delete-form` template); hidden
`weight` (`#type weight`), `entity_id` (hidden, class `entity-id`) and `parent` (hidden, class
`entity-parent`, default target id or 0) fields that drive the tabledrag JS.

## Operate

1. `drush en entity_hierarchy_widgets` (pulls in `entity_hierarchy`).
2. Add an `entity_reference_hierarchy` field to a bundle (via Entity Hierarchy).
3. Grant "Reorder hierarchy" to the roles that should reorder.
4. Visit the entity's **Hierarchy** tab (`/…/{id}/hierarchy`), drag rows, **Save hierarchy**.
