<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Integration mechanism

How this module hooks into `entity_hierarchy` and `group`. Nothing here defines new plugin types
or permissions; it overrides an existing selection handler and adds one validation constraint.

## Hooks — `src/Hook/EntityHierarchyGroupHook.php`

OOP hooks (`#[Hook(...)]`), bridged procedurally in `entity_hierarchy_group.module`.

- **`entity_reference_selection_alter`** (`entityReferenceSelectionAlter`): for every selection
  plugin whose id starts with `entity_hierarchy:`, swaps its `class` to
  `Drupal\entity_hierarchy_group\Plugin\EntityReferenceSelection\EntityHierarchyGroup`. This makes
  entity_hierarchy's parent picker group-aware without changing field config.
- **`entity_bundle_field_info_alter`** (`entityBundleFieldInfoAlter`): for every field of type
  `entity_reference_hierarchy`, adds the `GroupHierarchyParent` constraint to the field definition.

## Selection plugin — `EntityHierarchyGroup`

`src/Plugin/EntityReferenceSelection/EntityHierarchyGroup.php`, extends entity_hierarchy's
`EntityHierarchy` handler. In `create()` it also grabs `entity_hierarchy.query_builder_factory`
and the `entity_hierarchy_group.helper` service. `getReferenceableEntities()` runs the parent's
`buildEntityQuery()`, loads the results, and for each candidate:

- skips it unless it is a `ContentEntityInterface`;
- skips it unless `helper->allowedInGroupContext($entity)` returns TRUE;
- builds the label with `generateEntityLabelWithAncestry()` and stores it as
  `Html::escape($label)` keyed by bundle.

So the plugin only ever *narrows* the option list; it never adds candidates beyond what the base
handler's access-checked query returned, and labels are escaped.

## Helper service — `EntityHierarchyGroupHelper`

`src/EntityHierarchyGroupHelper.php` (service `entity_hierarchy_group.helper`), constructed with
`config.factory`, `current_route_match`, `entity_type.manager`, and
`entity_hierarchy.information.parent_candidate`. Key methods:

- **`allowedInGroupContext(ContentEntityInterface $entity): bool`** — returns TRUE immediately if
  neither `limit_group` nor `limit_no_group` is set. Otherwise compares the current route's groups
  (`getCurrentGroups()`) with the candidate's groups (`getGroupIds()`): with no current group and
  `limit_no_group` on, the candidate is allowed only if it has no group connection; with a current
  group and `limit_group` on, allowed only if it shares a group (via `array_intersect`).
- **`getCurrentGroups(): array`** — derives group ids from route parameters: a `group` param → that
  group; a `node` param (or any `ContentEntityInterface` param) → that entity's groups.
- **`getGroupIds(ContentEntityInterface $entity): array`** — group ids from
  `GroupRelationship::loadByEntity($entity)`.
- **`currentHierarchyHasRoot(ContentEntityInterface $entity): bool`** — checks whether the relevant
  hierarchy already has a root, either globally or within the current group's
  `group_relationship` records. Both entity queries use `->accessCheck(TRUE)`.
- Getters `getLimitGroup()`, `getLimitNoGroup()`, `getLimitGroupCount()` read the three config
  booleans (default FALSE).

## Validation constraint — `GroupHierarchyParent`

- `src/Plugin/Validation/Constraint/GroupHierarchyParentConstraint.php` — `#[Constraint(id:
  'GroupHierarchyParent', ...)]`, message `rootExists` ("This selection would create an additional
  hierarchy with an additional root. Please choose a parent.").
- `GroupHierarchyParentConstraintValidator.php` — injects `entity_type.manager`,
  `entity_hierarchy.query_builder_factory`, and the helper. `validate()` adds the `rootExists`
  violation only when the submitted parent value is empty, `getLimitGroupCount()` is on, and
  `currentHierarchyHasRoot()` is TRUE — i.e. it blocks creating a second root in a group when the
  one-hierarchy-per-group setting is enabled.

## Where it plugs into the ecosystem

`entity_hierarchy` supplies the `entity_reference_hierarchy` field type and the base
`EntityHierarchy` selection handler + `QueryBuilderFactory`; `group` supplies `GroupRelationship`
and group context. This module sits between them, layering group scoping onto the parent picker and
save-time validation. The submodule `entity_hierarchy_widgets_group` does the same for the nested
tree widget from `entity_hierarchy_widgets`.
