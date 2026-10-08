<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — templates, theme hooks & suggestions

`hook_theme()` (`field_group_layout_theme()`) registers:
- `field_group_layouts` — the generic wrapper (render element `content`, template `field-group--layout-twocol`).
- `field_group__layout_onecol`, `field_group__layout_twocol`, `field_group__layout_twocol_bricks`,
  `field_group__layout_threecol_25_50_25`, `field_group__layout_threecol_33_34_33` — per-layout templates in
  `templates/` (each uses `templates/theme.inc`).
- Plus one theme hook per **discovered** theme layout (`getThemeImplementations()`), pointed at this module's
  `templates/theme.inc`.

## Render wrappers
`hook_field_group_pre_render_alter()` sets, for a `layouts` group:
```php
$element['#theme_wrappers'] = ['field_group__' . $group->field_layout, 'field_group_layouts'];
```
so the group first renders through the layout-specific template, then the generic one.

## Theme suggestions
`hook_theme_suggestions_alter()` for `field_group_layouts` adds suggestions (most specific last) built from
`#field_layout`, `#wrapper_element`, `#entity_type`, `#bundle`, and `#group_name`, e.g.:
- `field_group__<layout_id>`
- `field_group_layouts__<entity_type>`
- `field_group_layouts__<entity_type>__<bundle>`
- `field_group_layouts__<entity_type>__<bundle>__<group_name>`

Override any of these in your theme's `templates/` to customize a specific group's layout markup.

## Libraries
- `field_group_layout/layouts` — front-end layout CSS (attached by `LayoutFormatter::process()`).
- `field_group_layout/layouts_admin` — Field UI admin CSS (attached on the display edit forms).
