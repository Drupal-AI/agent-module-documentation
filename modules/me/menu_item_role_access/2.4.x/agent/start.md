# menu_item_role_access — agent start

Adds a per-menu-link "visible to roles" setting: a `menu_item_roles` base field on
`menu_link_content` so a link only shows for chosen roles. Enforced by overriding the core
`menu.default_tree_manipulators` service (`MenuItemRoleAccessLinkTreeManipulator`). Depends on
core `menu_link_content` + `menu_ui`. This is menu-link **visibility, not page security**.
Behavior settings at **Admin → Config → System → Menu Item Role Access Behaviour**
(`/admin/config/menu-item-role-access`); route `menu_item_role_access.config`.

- Set per-link roles, behavior settings, inheritance, and how visibility is enforced →
  [configure/menu_item_role_access.md](configure/menu_item_role_access.md)
- Two permissions (edit the roles field / administer config) →
  see the permissions section in the configure doc.
