<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A field that lets editors pick a menu and a parent link, then displays that link's children; an AJAX endpoint returns parent options per menu.

---

Menu Parent Selector provides a field that lets editors choose a menu and a parent link within it, then renders that parent's child links — useful for placing a contextual sub-navigation onto content.

The field's widget uses an AJAX endpoint, `GET /menu-parent-selector/parents/{menu_name}`, that loads the given menu's link tree and returns a JSON map of parent plugin IDs to titles for the links that have children, so the parent dropdown updates when the editor changes the selected menu. A field formatter then displays the children of the chosen parent link on the entity.

Note: the parents endpoint is declared `_access: 'TRUE'` (`ParentOptionsController::getParents`, menu_parent_selector.routing.yml) and loads the tree without applying menu access manipulators, so it will return link titles (including for administrative/management menus) to anonymous callers for any `menu_name` passed — an information exposure of menu structure/titles, though not of protected content. Typical setup: add the Menu Parent Selector field to a content type, configure its widget and formatter, and editors then select a menu + parent per entity.
---
- Add a menu/parent picker field to a content type.
- Let editors choose which menu to draw from.
- Let editors choose a parent link within that menu.
- Display the children of the selected parent link.
- Build contextual sub-navigation on nodes.
- Update the parent dropdown via AJAX when the menu changes.
- Return parent options as JSON per menu.
- Show only links that actually have children as parents.
- Reuse core menu link trees for navigation.
- Place section navigation without custom code.
- Configure the field widget and formatter per bundle.
- Drive a sidebar menu from an editor's selection.
- Fetch parent options for any menu via the JSON route.
- Let an author swap the source menu per page.
- Render a child-link list block from a chosen parent.
