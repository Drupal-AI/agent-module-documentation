<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Navigation Menu Role adds menu blocks for Drupal 11's Navigation (left sidebar) whose visibility can be restricted to selected user roles, so different roles see different menus in the navigation.

---

The module provides one derived block plugin, `navigation_menu_role`, that extends core's `SystemMenuBlock` and is derived per menu (via `SystemMenuNavigationBlockDeriver`), giving one block per site menu (`navigation_menu_role:main`, `:admin`, `:account`, `:footer`, `:tools`, etc.). Its block settings add a **Roles** checkboxes element on top of the usual menu level/depth controls; the chosen roles are stored in the block configuration as `roles` (plus `level` and `depth`, capped at depth 3 for Navigation). `blockAccess()` grants access when the block's `roles` list is empty (visible to everyone) or when the current user has at least one of the selected roles. A `hook_block_alter()` implementation marks these plugins with `allow_in_navigation` (so they can be placed in the Navigation region) and hides them from the generic Block UI. The block builds the menu tree itself with role-aware access and strips the `route.menu_active_trails` cache contexts. There is no admin settings page (`configure: null`), no permissions of its own, and no Drush; configuration lives entirely in the `block.block.<id>` config entities you create. Requires core `navigation`, `block` and `system`; it is experimental (declared `final` for now).

---

- Show the admin menu in the Navigation sidebar only to editors, not to authenticated users at large.
- Give the `content_editor` role its own Navigation menu block while other roles see a different one.
- Place a role-restricted "Tools" menu in the left navigation for administrators only.
- Expose the main menu in Navigation to everyone by leaving the block's roles empty.
- Build per-role navigation experiences without writing a custom block access plugin.
- Restrict a footer or account menu block in the Navigation to a single membership role.
- Provide different navigation depth/levels per role using separate blocks.
- Hide sensitive menu links from the Navigation for non-privileged roles by role-gating the block.
- Show a moderation menu in Navigation only to users with a reviewer role.
- Give anonymous users a minimal Navigation menu and logged-in users a richer one.
- Configure a menu block that starts at level 2 for a specific role's Navigation.
- Combine several role-scoped Navigation menu blocks so each role sees the right set.
- Replace duplicate menu setups with one role-aware Navigation block per menu.
- Limit a custom menu placed in Navigation to a project-specific role.
- Deploy per-role Navigation menus as config (`block.block.*`) between environments.
- Present a support/help menu in the Navigation only to staff roles.
- Ensure administrators keep full Navigation access while restricting others.
- Show a "Content" menu in Navigation to content-producing roles only.
- Cap Navigation menu depth to 3 levels (module default) for a role's block.
- Use role visibility on Navigation menus without touching global block visibility conditions.
- Grant a menu to multiple roles at once by checking several roles on one block.
- Keep menu blocks out of the standard Block layout UI while managing them for Navigation.
