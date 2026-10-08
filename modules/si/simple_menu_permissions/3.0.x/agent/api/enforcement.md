<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How enforcement works

The module has **no public service or API to call** — it wires the per-menu
permissions into core's menu UI through entity handlers, a route subscriber, and
a service decorator. Useful to know when debugging why a role can/can't reach a
menu screen.

## Entity handler swaps — `hook_entity_type_build()`

In `simple_menu_permissions.module`, `simple_menu_permissions_entity_type_build()`
overrides handlers on two core entity types:

- `menu` → access handler `MenuAccessControlHandler`, list builder
  `MenuListBuilder`, and add/edit form class `MenuForm`.
- `menu_link_content` → access handler `MenuLinkContentAccessControlHandler`.

- **`MenuAccessControlHandler`** — maps entity ops to permissions:
  `view` → `view <id> menu in menu list`, `update`/`edit` → `edit <id> menu`,
  `delete` → `delete <id> menu` (core `administer menu` still allowed).
- **`MenuLinkContentAccessControlHandler`** — `update` → `edit links in <id>
  menu`, `delete` → `delete links in <id> menu` (id = the link's `menu_name`).
- **`MenuListBuilder`** — filters the menus overview to menus the user has
  `view <id> menu in menu list` for.

## Route access — `RouteSubscriber` + `MenuRoutesAccessChecker`

`src/Routing/RouteSubscriber::alterRoutes()`:

- `entity.menu.add_form` → requirement `_permission: 'create new menu'`.
- `entity.menu.edit_form`, `entity.menu.delete_form`, `entity.menu.add_link_form`
  → `_custom_access:
  \Drupal\simple_menu_permissions\Access\MenuRoutesAccessChecker::checkAccess`.

`MenuRoutesAccessChecker::checkAccess()` reads the `menu` route parameter and
allows: edit form if `edit <id> menu`, delete form if `delete <id> menu`, add
link form if `add new links to <id> menu`; otherwise neutral.

## Parent-menu dropdown — decorator

`simple_menu_permissions.menu_parent_form_selector` (class
`MenuParentFormSelectorDecorator`, `public: false`) **decorates** the core
`menu.parent_form_selector` service (`decoration_priority: 1`) so the parent-menu
`<select>` on menu-link and node forms only offers menus the current user may
manage.

## Node form fields — `hook_form_node_form_alter()`

`simple_menu_permissions_form_node_form_alter()`: when the selected parent menu
is `#restricted`, it disables the menu "enabled" checkbox, hides the link title
/ description / weight, and shows a "you do not have the correct permissions"
message — so editors can't move a node into a menu they don't control.

## Practical notes

- Assign permissions on `/admin/people/permissions`; there is no settings form.
- After granting/revoking, a cache rebuild (`drush cr`) makes route + list
  changes take effect reliably.
- Check a role in code with `Role::load($rid)->hasPermission('edit main menu')`.
