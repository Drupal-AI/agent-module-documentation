<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime mechanism, services, and the entity-reference selection plugin

## How rows become a tree (adjacency model)

1. In `template_preprocess_views_tree()` / `template_preprocess_views_tree_table()` the module
   calls the `views_tree.tree` service (`Drupal\views_tree\TreeHelper::buildRenderTree()`).
2. `ViewsResultTreeValues::setTreeValues()` (`views_tree.views_tree_values`) copies the
   configured `main_field`/`parent_field` values onto each `ResultRow` as `views_tree_main`
   and `views_tree_parent` (and a computed `views_tree_depth`).
3. `TreeHelper::groupResultByParent()` buckets rows by `views_tree_parent`.
   `getTreeFromGroups()` starts from group **`'0'`** (the roots) and recurses, so any row whose
   parent id is `0`/absent becomes a top-level item.
4. The result is a `Drupal\views_tree\TreeItem` (a node plus `getLeaves()` children) mapped back
   onto the rendered rows and passed to the template as `items`.

So the parent field must contain the **same id space** as the main field (e.g. both are entity
ids), and roots must use `0` (or a value that no row's main field holds).

## Services

| Service id | Class | Purpose |
|---|---|---|
| `views_tree.tree` | `TreeHelper` | build the render tree; `addDataAttributes()` adds `data-hierarchy-level` to table rows |
| `views_tree.views_tree_values` | `ViewsResultTreeValues` | populate `views_tree_main` / `views_tree_parent` / `views_tree_depth` on rows |

Key `TreeHelper` methods: `buildRenderTree(ViewExecutable $view, array $rows): TreeItem`,
`getTreeFromResult(array $result): TreeItem`, `applyFunctionToTree(TreeItem, callable): TreeItem`.

## Templates & libraries (theming)

- Templates: `views-tree.html.twig` (variable `items`, `options`, `list_type`) and
  `views-tree-table.html.twig` (extends core table preprocessing). Override per normal Twig
  suggestion rules.
- Libraries (`views_tree.libraries.yml`): `views_tree/views_tree` (collapsible CSS+JS, jQuery)
  attached only when `collapsible_tree` is set; `views_tree/views_tree_table` (table layout CSS)
  always attached for the table style.

## Entity-reference selection plugin

`Drupal\views_tree\Plugin\EntityReferenceSelection\TreeViewsSelection` (id `views_tree`, group
`views_tree`, label "TreeHelper (Adjacency model)") extends core's `ViewsSelection`. It runs a
view whose display is of type `entity_reference` and returns referenceable entities **indented**
by depth (`str_repeat('-', $row->views_tree_depth) . $label`). To use it: create a view with an
**Entity Reference** display styled with `tree_entity_reference_selection`, then on a reference
field set the reference method to "TreeHelper (Adjacency model)" / that view+display. This gives
a hierarchically-indented autocomplete/select for choosing a parent.
