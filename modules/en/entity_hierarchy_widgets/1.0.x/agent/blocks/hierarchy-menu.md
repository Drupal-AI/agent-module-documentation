<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Hierarchy Menu block

Plugin: `Plugin\Block\EntityHierarchyWidgetMenuBlock` — renders the **current entity's** hierarchy as a
nested link list.

- **Attribute**: id `entity_hierarchy_widget_menu`, admin label "Entity Hierarchy Menu", category
  "Entity Hierarchy". Extends `BlockBase`, implements `ContainerFactoryPluginInterface`; injects
  `entity_type.manager` and `entity_hierarchy_widgets.tree_builder`.
- **`build()`**: returns `['#theme' => 'tree_menu', '#tree' => $treeBuilder->getCurrentLinkTree()]`
  with cache metadata.
- **Cache** — `getCacheContexts()`: `['url', 'user', 'route.group']`. `getCacheTags()`: from the current
  entity, `['{entityType}_list:{bundle}']` (empty if no current entity). Note `getBundleEntity()->id()`
  is used for the bundle, so the block expects a bundle that is a config entity.

## Tree data

`TreeBuilder::getCurrentLinkTree()` → `getCurrentEntity()` (first `ContentEntityInterface` route parameter)
→ `getLinkTrees($entity)`. `getLinkTrees()` walks `getTrees()` records and builds, per root record, a nested
array via `createLinkTree(Record)`: `['label' => $entity->label(), 'url' => $entity->toUrl(), 'children' =>
[...]]`. The current entity's URL gets the `in-active-trail` class. Trees are filtered to label-view-accessible
descendants (Entity Hierarchy's `viewLabelAccessFilter`).

## Theme + template

`hook_theme()` (`EntityHierarchyWidgetsHook::entityHierarchyWidgetsTheme()`) registers `tree_menu` with a
single `tree` variable. `templates/tree-menu.html.twig` renders a recursive Twig macro `menu_links(tree,
attributes, menu_level)`: a `<nav><ul class="entity-hierarchy-tree-menu menu-level--N">` with an `<li>` per
item using core's `link(item.label, item.url)` and recursing into `item.children`.

## Use it

Place the **Entity Hierarchy Menu** block (category *Entity Hierarchy*) in a region via
`/admin/structure/block`. It only renders content on routes that resolve to a content entity carrying a
hierarchy field; on other routes the tree is empty.
