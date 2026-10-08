<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nested entity-reference selection handler

Plugin: `Plugin\EntityReferenceSelection\EntityHierarchyNested` — an
`EntityReferenceSelection` handler that shows referenceable entities as an **indented tree**, like core's
hierarchical taxonomy term select, instead of a flat autocomplete/list.

- **Attribute**: id `entity_hierarchy_nested`, label "Entity Hierarchy nested", group
  `entity_hierarchy_nested`, weight 0, deriver
  `Drupal\entity_hierarchy\Plugin\Derivative\EntityHierarchySelectionDeriver` (so it derives per
  hierarchy-capable target type/bundle, reusing Entity Hierarchy's own deriver).
- **Extends** core `DefaultSelection`; uses `entity_hierarchy`'s `AncestryLabelTrait`. Injects
  `entity_hierarchy.query_builder_factory` and `entity_hierarchy_widgets.tree_builder` in `create()`.

## `getReferenceableEntities($match, $match_operator, $limit)`

1. Runs the normal `DefaultSelection::buildEntityQuery($match, $match_operator)` (inherits core's access
   filtering and match handling), optionally `range(0, $limit)`, and `execute()`; returns `[]` if empty.
2. Loads the matched entities, then for each finds its hierarchy root via
   `TreeBuilder::getHierarchyFieldName()` + `QueryBuilderFactory::get(...)->findRoot($entity)`, collecting
   unique root records.
3. For each root, expands the full tree with `TreeBuilder::getTrees($rootEntity)` and, per record, adds
   an option keyed by bundle: `$options[$bundle][$id] = str_repeat('-', $record->getDepth()) .
   Html::escape($entity->label())`.

So a substring match pulls in the entity's whole hierarchy branch (rooted), rendering each option prefixed
by `-` per depth level. Labels are passed through `Html::escape()`. `TreeBuilder::getTrees()` filters
descendants with Entity Hierarchy's `RecordCollectionCallable::viewLabelAccessFilter`, so only
label-view-accessible entities appear as options.

## Use it

On *Manage form display* (or the field's storage/instance settings), set the reference field's selection
handler to **"Entity Hierarchy nested"**. Config schema for `entity_reference_selection.entity_hierarchy_nested:*`
inherits `entity_reference_selection.default` (`config/schema/entity_hierarchy_widgets.schema.yml`), so the
usual target-type/handler settings apply.
