<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hooks and suggestions

The module defines one theme hook and enriches core's `menu` theme hook so a field-rendered
tree can be themed distinctly from other menus.

## Theme hooks (`field_menu_theme()`)

- `field_menu_item` — variables `title`, `tree`. Template `field-menu-item.html.twig`
  (prints an `<h2 class="menu-title">` when `title` is set, then `{{ tree }}`).

## `menu` hook variable (`hook_theme_registry_alter()`)

Adds a `field_menu_configuration` variable (default `[]`) to the `menu` theme hook. The
formatter populates it with the providing entity, view mode, and label.

## Suggestions (`hook_theme_suggestions_menu()`)

When `field_menu_configuration` is present, these `menu__…` suggestions are added (later =
higher priority), letting you override `menu.html.twig` for field-embedded menus only:

- `menu__<menu_name>`
- `menu__field_menu`, `menu__field_menu__<menu_name>`
- With a providing entity of type `<type>` and bundle `<bundle>`:
  - `menu__<type>__field_menu`, `menu__<type>__field_menu__<menu_name>`
  - `menu__<type>__<bundle>__field_menu`, `menu__<type>__<bundle>__field_menu__<menu_name>`
  - With a view mode `<vm>`: `menu__<type>__<bundle>__<vm>__field_menu`
    and `menu__<type>__<bundle>__<vm>__field_menu__<menu_name>`

(`<menu_name>` has hyphens converted to underscores.) Create e.g.
`menu--node--page--field-menu.html.twig` to theme sitemap menus embedded on Basic pages.
