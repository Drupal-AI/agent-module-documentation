# Menu Per Role — agent index

Restricts visibility of **content** menu links (`menu_link_content` entities) by user role.
Adds "show to roles" / "hide from roles" fields to menu links and enforces them by
decorating core's menu tree access manipulator.

Scope + guarantee: acts only on `menu_link_content` entities, and only on the **menu tree**.
Config-defined links (Views) and `*.links.menu.yml` links are NOT affected, and hiding a
link does NOT protect its target page (the route is still reachable by direct URL).

Requires Drupal 11.2+ or 12 (2.0 dropped Drupal 10).

- **Configure** the global settings and the per-link role fields → [configure/menu_per_role.md](configure/menu_per_role.md)
- **Permissions** (settings form + role-assignment + front/admin bypass) → [permissions/menu_per_role.md](permissions/menu_per_role.md)
- **API**: the base fields, access logic, decorator service, cache contexts → [api/menu_per_role.md](api/menu_per_role.md)
