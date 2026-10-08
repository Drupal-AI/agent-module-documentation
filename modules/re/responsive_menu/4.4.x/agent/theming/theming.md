<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# responsive_menu — theming & hooks

## Blocks

| Plugin ID | Admin label | Purpose |
|---|---|---|
| `responsive_menu_toggle` | Responsive menu mobile icon | The burger icon/text that toggles the off-canvas panel. |
| `responsive_menu_horizontal_menu` | Horizontal menu | The desktop-width horizontal menu (menu from `horizontal_menu` config, visible past the breakpoint). |

Place both in a region via Block layout. The toggle is what opens the mmenu panel; the
horizontal block is only shown when `use_breakpoint` is on and the viewport is past
`horizontal_breakpoint`.

## Templates (override in your theme)

Copy any of these from the module's `templates/` dir into your theme and clear cache:

- `responsive-menu-off-canvas.html.twig` — the off-canvas mmenu panel markup.
- `responsive-menu-horizontal.html.twig` — the horizontal menu markup.
- `responsive-menu-block-toggle.html.twig` — the burger toggle block.
- `responsive-menu-block-wrapper.html.twig` — wrapper around the menu block.
- `responsive-menu-page-wrapper.html.twig` — the page-wrapper div injected when
  `wrapper_admin` / `wrapper_theme` is enabled.

## CSS

The bundled `css/responsive_menu.css` loads when `include_css` is true. To style from your
theme, set `include_css` to false and provide your own. Note the mmenu 8.x class change: target
`.mm-wrapper_opening` (not the old `html.mm-opening`).

## Alter hooks (`responsive_menu.api.php`)

All are procedural `hook_*` implementations in a `.module` file. Signatures:

| Hook | Alters |
|---|---|
| `hook_responsive_menu_off_canvas_menu_names_alter(&$menus)` | Comma-separated menu machine names feeding the off-canvas panel (per request/page). |
| `hook_responsive_menu_horizontal_menu_name_alter(&$menu_name)` | The single menu machine name used by the horizontal menu. |
| `hook_responsive_menu_off_canvas_tree_alter(array &$rendered_tree)` | The built off-canvas menu render array (`$tree['#items']`). |
| `hook_responsive_menu_horizontal_tree_alter(array &$rendered_tree)` | The built horizontal menu render array. |
| `hook_responsive_menu_off_canvas_manipulators_alter(array &$manipulators)` | Menu-tree manipulator callables applied to the off-canvas tree. |
| `hook_responsive_menu_horizontal_manipulators_alter(array &$manipulators)` | Manipulator callables applied to the horizontal tree. |
| `hook_responsive_menu_off_canvas_output_alter(bool &$output)` | Boolean (default TRUE) — set FALSE to suppress the off-canvas menu on a page/theme. |

Example — use a different off-canvas menu on the front page:

```php
function mymodule_responsive_menu_off_canvas_menu_names_alter(&$menus) {
  if (\Drupal::service('path.matcher')->isFrontPage()) {
    $menus = 'frontpage-menu';
  }
}
```
