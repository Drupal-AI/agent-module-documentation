<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toolbar Menu (toolbar_menu) — agent index

Adds any custom menu (Structure > Menu) to the Drupal admin **Toolbar** as its own tab,
whose tray holds that menu's links. Each toolbar tab is a `toolbar_menu_element` **config
entity** (config prefix `toolbar_menu.toolbar_menu_element.<id>`). Rendered by
`hook_toolbar()`. Depends only on core Toolbar. Managed at
`/admin/config/user-interface/toolbar-menu/elements` (route
`entity.toolbar_menu_element.collection`, the module's `configure` route), gated by the
`administer toolbar menu` permission.

- **Configure / add a menu to the toolbar** (the `toolbar_menu_element` config entity, its
  fields, the admin routes/permissions, `rewrite_label`, the dynamic per-element
  `view <id> in toolbar` permission, create via drush/PHP) →
  [configure/toolbar-menus.md](configure/toolbar-menus.md)
- **Programmatic API** (the `toolbar_menu.manager` service, entity accessor methods, the
  `toolbar_menu` cache tag) → [api/manager.md](api/manager.md)
