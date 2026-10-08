<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Branch Menu (branch_menu) — agent index

Single-block Drupal 11 module that renders a chosen menu as a D3.js polygonal tree graph.
No routes, permissions, services, config schema, install hooks, or module dependencies
(core ^11 only). Package: Custom. Security coverage: not-covered.

## What it provides
- **Block plugin** `branch_menu_block` — `src/Plugin/Block/BranchMenuBlock.php`
  (admin label "Branch Menu Graph", category "Custom"). Config: one key `menu_to_render`
  (default `main`). Loads the menu link tree (max depth 6) via `menu.link_tree`, flattens it,
  and outputs `<div id="branch-menu-container"></div>` plus `drupalSettings.branchMenu.treeData`.
- **Library** `branch_menu/branch_graph` — `branch_menu.libraries.yml`. Loads D3 v7 from the
  jsDelivr CDN (external), `js/branch_menu.js` (layout + SVG), `js/branch_animations.js` (hover),
  `css/branch_menu.css`; depends on `core/drupalSettings`.
- **hook_help** — `branch_menu.module` (`help.page.branch_menu`).

## Configuration
Per block instance only. Place the "Branch Menu Graph" block in Structure > Block layout and
pick a menu from the "Select Menu" dropdown. There is no global settings form or config object.

## Docs
- Block plugin, build pipeline, config, and JS data contract: [agent/blocks/branch_menu_block.md](blocks/branch_menu_block.md)
