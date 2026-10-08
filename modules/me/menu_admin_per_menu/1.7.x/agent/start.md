# menu_admin_per_menu — agent start

Generates a per-menu `administer <menu> menu items` permission so roles can
manage individual menus without core's global `administer menu`. No config UI —
assign the permissions on People → Permissions. Needs `menu_ui` +
`menu_link_content`.

- The dynamic permissions & what they gate → [permissions/permissions.md](permissions/permissions.md)
- `allowed_menus` service (check access in code) → [api/allowed-menus.md](api/allowed-menus.md)
- Alter a user's granted menus via hook → [hooks/hooks.md](hooks/hooks.md)
