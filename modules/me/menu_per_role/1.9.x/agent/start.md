<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Per Role (menu_per_role) — agent index

Restricts visibility of **content** menu links (`menu_link_content` entities) by user role.
Adds "show to roles" / "hide from roles" fields to menu links and enforces them by
decorating core's menu tree access manipulator.

- Version dir: `1.9.x` (release `8.x-1.9`, the maintained 1.x branch).
- Core: `^10.2 || ^11`. Dependency: `drupal:menu_link_content`. No Composer/library deps.
- Provides: 2 base fields, 1 config object + schema, 3 permissions, 1 settings route,
  1 decorator service, 1 custom cache context. No entities, plugins, or Drush commands.

Scope limit: only `menu_link_content` entities. Config-defined links (Views) and
`*.links.menu.yml` links are NOT affected. Visibility only — it does not restrict access to
the destination pages themselves (documented module behavior).

- **Configure** the global settings and the per-link role fields → [configure/menu_per_role.md](configure/menu_per_role.md)
- **Permissions** (admin form + front/admin bypass) → [permissions/menu_per_role.md](permissions/menu_per_role.md)
- **API**: the base fields, access logic, decorator service, cache contexts → [api/menu_per_role.md](api/menu_per_role.md)
