<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Nested tree selection override

## Install / enable

`drush en entity_hierarchy_widgets_group`. Pulls in `group`, `entity_hierarchy`,
`entity_hierarchy_widgets` and `entity_hierarchy_group`. It has no settings of its own; scoping is
controlled by the parent module's Entity Hierarchy Group settings form.

## Hook — `src/Hook/EntityHierarchyWidgetsGroupHook.php`

`#[Hook('entity_reference_selection_alter')]` `entityReferenceSelectionAlter()` (bridged
procedurally in `entity_hierarchy_widgets_group.module`, service
`entity_hierarchy_widgets_group.hooks`): for every selection plugin whose id starts with
`entity_hierarchy_nested:`, replaces its `class` with
`Drupal\entity_hierarchy_widgets_group\Plugin\EntityReferenceSelection\EntityHierarchyNestedGroup`.

## Plugin — `EntityHierarchyNestedGroup`

`src/Plugin/EntityReferenceSelection/EntityHierarchyNestedGroup.php`, extends
`entity_hierarchy_widgets`' `EntityHierarchyNested`. In `create()` it injects
`entity_hierarchy.query_builder_factory`, `entity_hierarchy_widgets.tree_builder`, and
`entity_hierarchy_group.helper` (the parent module's helper).

`getReferenceableEntities()`:

1. runs the parent's `buildEntityQuery()` and loads the results;
2. resolves each result's hierarchy field via `TreeBuilder::getHierarchyFieldName()` and finds its
   root with `QueryBuilder::findRoot()`, collecting unique root records;
3. for each root, builds its tree(s) with `TreeBuilder::getTrees()` and, per node, **skips any
   entity where `helper->allowedInGroupContext($entity)` is FALSE**;
4. emits allowed nodes as options, label = depth-indentation dashes + `Html::escape($entity->label())`.

So this handler only narrows the tree to group-allowed nodes and escapes labels. The group logic
itself lives entirely in the parent module's `EntityHierarchyGroupHelper` (see
`modules/en/entity_hierarchy_group/1.0.x/agent/api/integration.md`); this submodule just wires that
check into the nested-tree widget's option builder.
