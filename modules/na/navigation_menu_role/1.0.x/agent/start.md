<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Navigation Menu Role — agent index

Provides one derived block plugin, `navigation_menu_role`, for Drupal 11's **Navigation**
sidebar: a per-menu menu block whose visibility can be limited to selected user **roles**.
No settings page, no permissions, no Drush. Config lives in `block.block.<id>` entities.
Requires core `navigation`, `block`, `system`.

- **Place a role-restricted navigation menu block; block settings keys (`roles`, `level`,
  `depth`); how access is decided** → [configure/role-block.md](configure/role-block.md)
- **The `navigation_menu_role` block plugin, its deriver, and `hook_block_alter`** →
  [plugins/block.md](plugins/block.md)

Key facts:
- One derivative per menu: `navigation_menu_role:main`, `:admin`, `:account`, `:footer`,
  `:tools`, … (deriver `SystemMenuNavigationBlockDeriver`).
- Block settings: `level` (start level), `depth` (0–3), `roles` (array of role ids).
- Access: allowed if `roles` is empty (everyone) OR the user has one of the listed roles
  (`NavigationMenuRoleBlock::blockAccess()`).
- Config schema: `block.settings.navigation_menu_role:*` (`level`, `depth`, `roles`).
