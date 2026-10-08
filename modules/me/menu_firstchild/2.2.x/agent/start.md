<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Firstchild — agent index

Makes a **pathless parent menu link resolve to its first viewable child's URL** at render time.
Depends on core `menu_link_content`. No settings page, no permissions, no Drush, no config
schema — its only state is a per-link option.

- **Enable it on a menu link & where the flag is stored** →
  [configure/first-child.md](configure/first-child.md)
- **The parser service & the alter hook** → [hooks/alter.md](hooks/alter.md)

Key facts:
- Enabling ticks the **"First child"** checkbox on the `menu_link_content` form; the link's URI
  becomes `route:<none>` and the flag is stored in the link field options:
  `options['menu_firstchild']['enabled'] = true`.
- `hook_preprocess_menu()` → `menu_firstchild.menu_item_parser` (`MenuItemParser::parse()`)
  rewrites an enabled item's `url` to its first access-checked child (recursively) and adds the
  `menu-firstchild` CSS class; with no viewable child it stays `route:<none>`.
- Hook: `hook_menu_firstchild_item_alter(&$menu_item, $child)`.
