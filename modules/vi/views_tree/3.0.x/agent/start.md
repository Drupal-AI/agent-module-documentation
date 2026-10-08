<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Tree — agent index

Adds Views **style plugins** that render rows as a nested hierarchy (adjacency model). No
settings form, no configure route (`configure: null`), no permissions, no Drush. All state
lives in the view's own config entity (`views.view.<id>`) under the display's `style` options.

- **Set a view's style to a tree and configure main/parent fields (list, table, ER select)** →
  [configure/tree-style.md](configure/tree-style.md)
- **How the tree is built at runtime, the `TreeHelper` service, and the entity-reference selection plugin** →
  [api/tree-helper.md](api/tree-helper.md)

Key facts:
- Three style plugin ids: `tree` (Tree list), `tree_table` (Tree table),
  `tree_entity_reference_selection` (label "TreeHelper (Adjacency model)", for reference widgets).
- Every tree style needs `main_field` (row's unique id) and `parent_field` (id of its parent);
  `tree_table` also needs `display_hierarchy_column`. The list style has `collapsible_tree`
  (`0` | `expanded` | `collapsed`).
- Config path: `views.view.<id>` → `display.<display>.display_options.style.type` = `tree` /
  `tree_table`, with the fields under `...style.options`.
