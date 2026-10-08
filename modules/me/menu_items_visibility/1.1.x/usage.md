Menu Item Visibility adds a per-menu-link "Visibility settings" fieldset to the menu link edit form, letting you show a link only to selected user roles, with an optional node-access check that can forbid access to the linked node itself.

---

The module is a small procedural `.module` (no config UI route — `configure` is null). It implements `hook_form_menu_link_content_menu_link_content_form_alter()` to add a **Visibility settings** fieldset with a *roles* checkboxes element and a *Path Access* checkbox to every custom menu-link edit form (`/admin/structure/menu/…`). A submit handler saves the choices into the `menu_items_visibility.settings` config object, keyed by the link's plugin ID: `mlid.<plugin_id>.roles` (array of role IDs) and `mlid.<plugin_id>.access_check` (bool). At render time, `hook_preprocess_menu()` walks the menu tree recursively and removes any link whose stored roles do not intersect the current user's roles (a link with no roles configured stays visible to everyone). Separately, `hook_node_access()` enforces the *Path Access* option: for links whose `access_check` is on, it reads the link's `route_param_key` from the `menu_tree` table, and if the link points at a node the current user cannot see (per the same role check), it returns `AccessResult::forbidden()` for that node. Depends only on core `menu_ui`. Note that the menu-item hiding is a **display filter** (`preprocess_menu`) — it removes the link from rendered menus but does not by itself protect the target route; only the optional `access_check` (node links) actually blocks access to content.

---

- Show an "Admin dashboard" menu link only to the administrator role.
- Hide a "Members area" link from anonymous users while showing it to authenticated users.
- Restrict a footer menu link to a specific editor or manager role.
- Display different main-menu links to different roles from a single menu.
- Keep a link visible to everyone by leaving all role checkboxes unticked.
- Show a "Staff intranet" link only to internal roles.
- Hide promotional menu links from privileged roles that don't need them.
- Restrict a menu link pointing to a node so unauthorized roles are also denied access to the node (Path Access).
- Combine role-based link hiding with node access denial for a linked landing page.
- Curate role-specific navigation without cloning menus per role.
- Hide a "Register" link once a user is authenticated.
- Show beta-feature links only to a tester role.
- Limit a "Reports" link to analytics-role users.
- Present a simplified menu to anonymous visitors and a fuller one to logged-in users.
- Gate a "Billing" link to an account-manager role.
- Hide submenu (child) links per role — the preprocessor recurses into nested items.
- Restrict a documentation link to a support role.
- Show a partner-portal link only to a partner role.
- Keep menu structure in one place while varying visibility by audience.
- Deny direct node access for a menu-linked page to roles that shouldn't reach it, via the access-check option.
