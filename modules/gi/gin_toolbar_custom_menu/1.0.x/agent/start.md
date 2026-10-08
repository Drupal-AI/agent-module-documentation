<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Toolbar Custom Menu — agent index

Swaps the **Gin admin toolbar's menu** for a menu of your choice, **per user role**. Depends on
`toolbar` + `gin_toolbar` (Gin theme). Config UI: `gin_toolbar_custom_menu.settings` route at
`/admin/config/system/gin-toolbar-custom-menu`.

- **Settings config object, the per-role rules, keep_admin_menu, drush examples** →
  [configure/settings.md](configure/settings.md)
- **Permission `configure gin toolbar custom menu` (+ the required core "Use toolbar")** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `gin_toolbar_custom_menu.settings` (FullyValidatable) with
`keep_admin_menu` (int) and `settings` — a sequence of rules, each `{menu, role[], excluded_role[],
icons[], admin_menu, actions[]}`. A rule matches when the current user has one of its `role`s (and
none of its `excluded_role`s), then the toolbar's `admin` menu is replaced with the rule's `menu`.
Assigned roles must ALSO have the core `access toolbar` ("Use toolbar") permission. No plugins, no
Drush.
