<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov menu link group lets you gather existing menu links under a new grouping link — typically to tidy a crowded admin menu — using a config entity that describes the group and which links belong in it, with the group hidden automatically when the user cannot reach any of its children.

---

A `localgov_menu_link_group` config entity records a group label, its weight, the parent menu and parent menu link it hangs from, and the list of child menu link plugin ids to move under it. At menu build time `hook_menu_links_discovered_alter()` loads every enabled group and hands the discovered link array to `MenuLinkGrouper`, which inserts a derived group link (from the `MenuGroups` deriver) and re-parents the listed children onto it. `hook_module_implements_alter()` deliberately pushes this module's implementation to the **end** of the hook order so it sees links contributed by every other module. Because the group link is synthetic it has no route of its own and no access check, which would leave an empty group visible to users who cannot use any of its children — so `hook_preprocess_menu()` walks the rendered tree, and for every item whose key starts with `localgov_menu_link_group` it loads that subtree via the menu tree service (max depth 1, enabled links only), runs `checkNamedRoute()` on each child, and unsets the group when none are accessible. The three entity CRUD hooks all rebuild the menu link plugin manager, so changes take effect immediately. Everything is managed at `/admin/structure/menu/localgov_menu_link_group`; there are no permissions or routes of the module's own beyond the entity's admin routes.

---

- Tidy a crowded admin menu into logical groups.
- Group all content-related admin links under one parent.
- Give editors a shorter, task-focused admin menu.
- Hide a group automatically from users who cannot use any of its links.
- Reorder admin sections with a group weight.
- Group links contributed by several different modules.
- Place a group under any existing menu link.
- Keep the grouping in configuration so it deploys with the site.
- Present LocalGov-specific admin tasks together.
- Reduce cognitive load for occasional admin users.
- Group menu links without writing a custom menu link plugin.
- Rebuild the menu automatically when a group changes.
- Remove a group and have its children return to their original parents.
- Apply grouping to front-end menus as well as the admin menu.
- Standardise admin navigation across several council sites.
- Avoid patching contrib modules just to move their menu links.
- Create a "Site settings" grouping for scattered config pages.
- Disable a group temporarily via its status flag.
- Export and import menu groupings between environments.
- Keep the grouping logic last in hook order so nothing is missed.
