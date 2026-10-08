<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Item Limit — agent index

Caps how many links a menu may hold. You set a per-menu maximum on the menu's edit form;
a validation constraint blocks adding a **new** `menu_link_content` once the menu is full.
No settings page (`configure` is `null`), no permission, no Drush, no config schema.

- **Set / read a menu's item limit (the "Item Limitation" field and its config key)** →
  [configure/limits.md](configure/limits.md)
- **How the cap is enforced (the `MenuItemOverLimit` constraint, when it fires)** →
  [api/enforcement.md](api/enforcement.md)

Key facts: limits live in the `menu_item_limit.settings` config object, one key per menu
machine name (`menu_item_limit.settings:<menu> = <int>`); `0`/empty = unlimited. The cap is
enforced by a `MenuItemOverLimit` constraint added to the `menu_link_content` entity type,
which only validates **new** items. Depends on core `menu_ui`.
