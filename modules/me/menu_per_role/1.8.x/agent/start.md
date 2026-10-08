# Menu Per Role — agent index

Restricts visibility of **content** menu links (`menu_link_content` entities) by user role.
Adds "show to roles" / "hide from roles" fields to menu links and enforces them by
decorating core's menu tree access manipulator.

Scope limit: only `menu_link_content` entities. Config-defined links (Views) and
`*.links.menu.yml` links are NOT affected.

- **Configure** the global settings and the per-link role fields → [configure/menu_per_role.md](configure/menu_per_role.md)
- **Permissions** (admin form + front/admin bypass) → [permissions/menu_per_role.md](permissions/menu_per_role.md)
- **API**: the base fields, access logic, decorator service, cache contexts → [api/menu_per_role.md](api/menu_per_role.md)
