Menu Item Role Access adds a "visible to roles" setting to each menu link so the link only appears for users in the chosen roles.

---

The module adds two base fields to the `menu_link_content` entity: `menu_item_roles` (an unlimited entity-reference to `user_role`, rendered as checkboxes on the menu link edit form) and `menu_item_override_children` (a boolean for inheritance). When a menu link has roles selected, only users holding at least one of those roles see the link; a link with no roles selected is unaffected and shows normally. Enforcement happens by overriding Drupal's `menu.default_tree_manipulators` service with `MenuItemRoleAccessLinkTreeManipulator`, which extends the core `DefaultMenuLinkTreeManipulators` and adds a role check inside `menuLinkCheckAccess()`. This is menu-link **visibility**, not page security: by default the core access check of the link's target route still applies, so a role that lacks permission to view the target will not see the link even if allowed here, and a role granted the setting still cannot reach a page it has no route access to. The settings form at `/admin/config/menu-item-role-access` (route `menu_item_role_access.config`) has two options — `overwrite_internal_link_target_access` (ignore the target's own access check and rely solely on the role setting) and `inherit_parent_access` (let a parent link with "Override children" checked impose its roles on descendants). Editing the roles field is gated by the `edit menu_item_role_access` permission; the settings page by `administer menu_item_role_access`. Users with the core `link to any page` permission bypass the role check entirely.

---

- Show an "Admin dashboard" menu link only to the administrator role.
- Hide a "Members area" link from anonymous visitors.
- Reveal an "Editor tools" link only to content editor roles.
- Restrict a "Billing" link to an authenticated customer role.
- Keep a "Staff intranet" menu item out of the public main menu for guests.
- Limit a footer "Partner portal" link to a partner role.
- Show different primary-menu items to different roles from one shared menu.
- Gate a "Beta features" link to a testers role.
- Restrict a "Reports" link to a manager role.
- Hide a "Moderate content" link from everyone except moderators.
- Select multiple allowed roles on a single menu link (unlimited cardinality).
- Leave a link's roles empty so it stays visible to everyone.
- Apply a parent link's role restriction to all its children via "Override children" + inherit setting.
- Let a specific child link override its parent's inherited role restriction.
- Turn on "Overwrite internal link target access check" so the role setting alone decides visibility, ignoring the target route's access.
- Show a `<nolink>` or `<front>` menu item conditionally by role (special-cased for checking).
- Delegate menu-link role editing to trusted editors via the `edit menu_item_role_access` permission without giving them full config access.
- Restrict who can change the module's behavior with `administer menu_item_role_access`.
- Let super-editors with `link to any page` always see every menu link regardless of role settings.
- Build a single navigation menu that adapts per role instead of maintaining separate menus.
- Export the two behavior flags as configuration between environments.
- Hide external-link menu items (no route) from certain roles.
- Show onboarding links only to a "new user" role.
- Restrict a "Danger zone" settings link to an ops role.
- Present role-specific quick links in a custom menu block.
