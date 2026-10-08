<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Branch Menu Graph block (`branch_menu_block`)

Source: `src/Plugin/Block/BranchMenuBlock.php`. The module's only functional unit.

## Install & place
1. `drush en branch_menu` (or Extend UI). No dependencies beyond core ^11; no config to import.
2. Structure > Block layout > place **"Branch Menu Graph"** in a region.
3. In the block form, pick a menu from **Select Menu**; save.

## Plugin definition
`@Block(id = "branch_menu_block", admin_label = "Branch Menu Graph", category = "Custom")`.
Extends `BlockBase`, implements `ContainerFactoryPluginInterface`. `create()` injects two core
services: `menu.link_tree` (`MenuLinkTreeInterface $menuTree`) and `entity_type.manager`
(`EntityTypeManagerInterface $entityTypeManager`).

## Configuration (per instance)
- `defaultConfiguration()` → `['menu_to_render' => 'main']`.
- `blockForm()` builds one `#type => select` named `menu_to_render`, options = every menu
  entity's `id() => label()` (loaded via `menu` storage `loadMultiple()`).
- `blockSubmit()` saves `$form_state->getValue('menu_to_render')` into
  `$this->configuration['menu_to_render']`.
- Stored in the block config entity like any block plugin setting; no separate config object,
  no config/schema, no permissions. Editing the block requires `administer blocks`.

## build() pipeline
1. `$menu_name = $this->configuration['menu_to_render']`.
2. `$parameters = new MenuTreeParameters(); $parameters->setMaxDepth(6);`
3. `$tree = $this->menuTree->load($menu_name, $parameters);`
4. `$menu_data = $this->buildMenuArray($tree);`
5. Returns render array:
   - `#markup => '<div id="branch-menu-container"></div>'`
   - `#attached['library'] => ['branch_menu/branch_graph']`
   - `#attached['drupalSettings']['branchMenu']['treeData'] => $menu_data`

`buildMenuArray()` recurses over the tree; for each `$element` it emits
`['title' => $link->getTitle(), 'url' => $link->getUrlObject()->toString(),
'has_children' => $element->hasChildren, 'children' => [...]]`, recursing into
`$element->subtree` when `hasChildren`. Note: it reads `$element->link` directly and does not
inspect `$element->access`.

## Frontend / JS data contract
Library `branch_menu/branch_graph` (`branch_menu.libraries.yml`) loads:
- D3 v7 external (`https://cdn.jsdelivr.net/npm/d3@7`), `js/branch_menu.js`,
  `js/branch_animations.js`, `css/branch_menu.css`; dep `core/drupalSettings`.

`js/branch_menu.js` (`Drupal.behaviors.branchMenu`): reads
`settings.branchMenu.treeData`, wraps it under a synthetic root, runs `d3.tree()` +
`d3.hierarchy()`, applies a custom anti-overlap Y-cascade, draws `M…L…L…` polygonal branch paths
and per-node `circle` + `<a xlink:href=url><text>title</text></a>`. Labels are set with D3
`.text(d => d.data.title)` (textContent), and hrefs with `.attr("xlink:href", d => d.data.url)`.
`js/branch_animations.js` handles hover scale/stroke transitions.

## Operating notes
- Set parent links to "Show as expanded" so deep levels populate (see `hook_help`).
- Depth is hard-capped at 6 (`setMaxDepth(6)`); not configurable.
- D3 is fetched from a third-party CDN at render time; offline/air-gapped sites won't render
  the graph. `#markup` is only an empty container — all drawing is client-side.
- The block re-renders per selected menu; place multiple instances for multiple menus.
