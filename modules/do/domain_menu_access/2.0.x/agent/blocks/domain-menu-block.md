<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# "Domain Menu" block

Per-domain menu filtering is produced by a block plugin, not globally. To get domain-aware
output for a menu you must place the module's block for that menu; rendering the same menu with
the core "System Menu" block gives the unfiltered menu.

## Plugin

- Class: `Drupal\domain_menu_access\Plugin\Block\DomainMenuAccessMenuBlock`
- Base id: `domain_access_menu_block`, admin label **"Domain Menu"**, category **"Domain Menu"**
- Extends core `SystemMenuBlock` (so it keeps the standard *Starting level* / *Maximum levels* /
  *Expand all items* settings).
- Deriver: `Drupal\domain_menu_access\Plugin\Derivative\DomainMenuAccessMenuBlock` — publishes one
  derivative per menu that is listed in `domain_menu_access.settings:menu_enabled` (derivative id
  = menu machine name, admin label = menu label). Menus not in `menu_enabled` get no block.

## Runtime (`build()`)

1. `isDomainRestricted($menu_name)` re-checks that the menu is in `menu_enabled`; if not it falls
   straight back to `parent::build()` (plain core menu, no filtering).
2. Otherwise it loads the tree and transforms it with, in order:
   - `menu.default_tree_manipulators:checkAccess`
   - `domain_menu_access.default_tree_manipulators:checkDomain` ← the domain filter
   - `menu.default_tree_manipulators:generateIndexAndSort`
3. `checkDomain` replaces any link not available on the active domain with an
   `InaccessibleMenuLink` and empties its subtree, so hidden links (and their children) drop out
   of the rendered menu. See [../api/tree-manipulator.md](../api/tree-manipulator.md) for the
   exact rule.
4. `getCacheContexts()` adds `url.site` so the block's output varies per domain.

## Placement

Place the "Domain Menu" block for the menu you enabled (Block layout, category *Domain Menu*)
instead of that menu's default block. The submodule **Domain Menu Access (Menu Block)** adds an
equivalent block (`domain_access_menu_menu_block`, category *Domain Menu (Menu Block)*) that
extends the contrib Menu Block plugin — see the submodule's own docs.
