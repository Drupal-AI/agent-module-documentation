<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simple_menu_permissions — agent start

Replaces core's single `administer menu` with **dynamic per-menu permissions**.
For every menu it generates six permissions plus one global `create new menu`.
No config UI — assign the permissions on People → Permissions
(`/admin/people/permissions`). Needs `menu_ui` + `menu_link_content`.

The six per-menu permissions (with `<id>` = the menu machine name, e.g. `main`):
`view <id> menu in menu list`, `edit <id> menu`, `delete <id> menu`,
`add new links to <id> menu`, `edit links in <id> menu`,
`delete links in <id> menu`. Plus global `create new menu`.

- The generated permissions & exactly what each gates → [permissions/permissions.md](permissions/permissions.md)
- How enforcement works (access handlers, route subscriber, decorator) → [api/enforcement.md](api/enforcement.md)
