<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Parent Selector (menu_parent_selector) — agent index

**A field that lets editors pick a menu and a parent link, then displays that link's children; a widget-backing AJAX endpoint returns parent options per menu.**

- **Version:** 1.0.x — core `^10 || ^11`
- **Field:** menu + parent-link selector with a matching formatter that renders the parent's children
- **Route:** `GET /menu-parent-selector/parents/{menu_name}` → `ParentOptionsController::getParents` returns JSON `{plugin_id: title}` for links with children
- **Security:** the parents route is `_access: 'TRUE'` (menu_parent_selector.routing.yml) and loads the menu tree **without access manipulators** (ParentOptionsController.php:20-32), so it exposes menu link titles for any `menu_name` — including admin/management menus — to anonymous callers (info exposure of menu structure). No mutation, no protected-content leak.
