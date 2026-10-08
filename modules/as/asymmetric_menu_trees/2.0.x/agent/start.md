<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asymmetric Menu Trees (asymmetric_menu_trees) — agent index

Lets **one translated menu render a different tree per language** — different parent, order,
enabled state and link URL — instead of core's single structure shared across all languages.
Package `Multilingual`. Version **2.0.0**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.

No declared `.info.yml` dependencies, but it only affects **`menu_link_content`** links (core menu
module must provide them). No new entities, no permissions of its own, no Drush, no config schema.

## Solution docs
- **Config form, the three multilingual toggles, what each makes translatable, install/uninstall**
  → [config/settings.md](config/settings.md)
- **How it works: plugin-class swap, tree manipulators, hooks, caching** →
  [architecture/menu-tree-restructuring.md](architecture/menu-tree-restructuring.md)

## What it actually is (from source)
- **Config form** `AsymmetricMenuTreesConfigForm` at route
  `asymmetric_menu_trees.asymmetric_menu_trees_config_form` → `/admin/config/asymmetric_menu_trees`
  (permission **`administer site configuration`**, menu under *Configuration → Regional and
  language*). Writes config object **`asymmetric_menu_trees.settings`** key `multilingual`
  (`checkboxes`: `link`, `order`, `enabled`).
- **Menu link plugin** `AsymmetricMenuLinkContent` (`src/Plugin/Menu/`) extends core
  `MenuLinkContent`; overrides `isEnabled()`, `getWeight()`, `getUrlObject()`, `getParent()` to read
  the **translated entity** values when the site is multilingual (else the plugin-definition value).
  Adds `getMenuLinkEntity()`.
- **Service** `asymmetric_menu_trees.menu_tree_manipulators`
  (`Menu\MenuLinkTreeManipulators`, args `@language_manager`, `@cache.default`) with two callables:
  `restructureTree` (re-parents/re-depths the tree per language, cached) and `removeDisabledLinks`.
- **Hooks** (`.module`): `hook_entity_base_field_info_alter` makes `link`/`weight`/`parent`/`enabled`
  base fields translatable per the chosen toggles; `hook_menu_links_discovered_alter`,
  `hook_entity_insert`, `hook_install`, `hook_update_8101` swap the `menu_tree.class` column to the
  asymmetric plugin; three `*_menu_tree_manipulators_alter` hooks + `hook_superfish_manipulators_alter`
  register the manipulators.

Structure only — core's own access-check manipulator still runs afterward, so access-restricted
links stay hidden. See [usage.md](../usage.md) for use cases.
