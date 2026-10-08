Menu Per Role restricts the visibility of individual menu links by user role, adding "show to" and "hide from" role selectors to content menu links.

---

Menu Per Role adds two entity_reference base fields (`menu_per_role__show_role` and `menu_per_role__hide_role`) to `menu_link_content` entities, so each editable menu link can be shown only to, or hidden from, specific user roles. It enforces these choices by decorating core's `menu.default_tree_manipulators` service: during menu tree access checking it forbids a link when the account lacks a required "show" role or holds a "hide" role. A global settings form (`/admin/config/system/menu_per_role`) controls which of the two checkbox sets appear on menu-link forms, whether the fields are hidden on links that point to nodes (useful with Node Access modules), and whether administrators bypass the checks in the front and/or admin contexts. Three permissions gate the admin form and let non-admin users bypass access enforcement separately for the front and admin contexts. Access results carry cache contexts (`user.roles`, `user.is_super_user`, `route.is_admin`) and the module ships a custom `route.is_admin` cache context so filtered menus cache correctly. Its scope is limited: it only affects content menu links (the `menu_link_content` content entity) — links defined in configuration (e.g. Views) or in `*.links.menu.yml` files cannot be managed. Leaving all role checkboxes empty preserves the link's default access.

---

- Show a menu link only to authenticated users while hiding it from anonymous visitors.
- Hide an "Admin dashboard" menu link from every role except a specific staff role.
- Restrict a "Members area" link so only users with the `member` role see it.
- Present role-tailored primary navigation without cloning menus per audience.
- Hide promotional or upsell links from roles that already purchased.
- Show editorial/workflow links (e.g. "Moderate content") only to editor roles.
- Keep a link visible to `editor` and `administrator` but hidden from `subscriber`.
- Combine show and hide rules on the same link for fine-grained visibility.
- Build a single shared main menu whose items appear differently per role.
- Hide beta-feature links from the general public but show them to testers.
- Restrict footer links (legal/internal) to internal staff roles.
- Configure the module to display only the "Show" checkboxes to simplify the editor UI.
- Configure the module to display only the "Hide" checkboxes for a hide-by-default workflow.
- Automatically hide the role fields on menu links that point to nodes when Node Access modules are enabled.
- Let editors set link visibility inline while editing a node's menu settings.
- Grant a non-admin support role the "bypass access front" permission to preview all links on the site front end.
- Grant a QA role the "bypass access admin" permission to see all admin-menu links regardless of restrictions.
- Configure administrators to still be subject to Menu Per Role checks on the front end (disable admin front bypass) for accurate previews.
- Delegate management of the settings form to a trusted role via the "administer menu_per_role" permission.
- Set role visibility programmatically by writing to the two base fields on a `MenuLinkContent` entity.
- Migrate role-based menu visibility from another site by populating the `menu_per_role__show_role`/`__hide_role` fields.
- Ensure per-role menus stay cache-correct across front/admin routes via the module's cache contexts.
- Reduce navigation clutter by hiding links that a role has no permission to act on.
- Provide different quick-links for `vendor`, `customer`, and `staff` roles from one menu.
- Hide language- or region-specific links from roles that shouldn't see them.
