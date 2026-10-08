<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services: TreeBuilder, FormHelper, hooks

`entity_hierarchy_widgets.services.yml` defines three services.

## `entity_hierarchy_widgets.tree_builder` — `TreeBuilder`

Shared tree builder used by the reorder form, the selection handler, and the block. Final class; args:
`entity_field.manager`, `entity_hierarchy.query_builder_factory`,
`entity_hierarchy.information.parent_candidate`, `current_route_match`,
`entity_hierarchy_widgets.form_helper`. Constant `ENTITY_REFERENCE_HIERARCHY_FIELD_TYPE =
'entity_reference_hierarchy'`.

- `getCurrentEntity(): ?ContentEntityInterface` — last `ContentEntityInterface` among current route
  parameters.
- `getCurrentLinkTree(): array` — link tree for the current entity, else `[]`.
- `getHierarchyFieldName(ContentEntityInterface): string` — first field whose type is
  `entity_reference_hierarchy` for the entity's bundle (`''` if none).
- `getTrees(ContentEntityInterface): ?array` — for each candidate field
  (`ParentCandidate::getCandidateFields`): `QueryBuilderFactory::get(field, type)`, `findRoot()`,
  `findDescendants(root)->filter(RecordCollectionCallable::viewLabelAccessFilter(...))->buildTree()`, then
  sets those as the root's children and returns one built `RecordCollection` tree per field. Returns NULL
  if no field or no root.
- `getLinkTrees(ContentEntityInterface): array` — flattens `getTrees()` records into `createLinkTree()`
  results keyed by record id.
- `createLinkTree(Record): array` — `['label', 'url', 'children' => …]`; marks the current entity's URL
  with the `in-active-trail` class.

## `entity_hierarchy_widgets.form_helper` — `FormHelper`

Final class, arg `renderer`. Builds reorder-table rows (see
[../forms/reorder-tree.md](../forms/reorder-tree.md)): `buildTableRow(Record)` and protected cell builders
`buildTitleCell` (indentation + linked label), `buildOperationsCell` (Edit/Delete gated by
`access('update')`/`access('delete')`), `buildWeightField`, `buildEntityIdField`, `buildParentField`.

## `entity_hierarchy_widgets.hooks` — `Hook\EntityHierarchyWidgetsHook`

Autowired OOP hook class. `#[Hook('entity_type_build')]` adds the reorder route provider, form handler,
`entity_hierarchy` handler and `{canonical}/hierarchy` link template to content entity types (node gets
`NodeEntityHierarchyHandler`). `#[Hook('theme')]` registers the `tree_menu` theme hook. Bridged from
`entity_hierarchy_widgets.module` via `#[LegacyHook]` shims.
