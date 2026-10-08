# Theming

## Templates (`templates/`)
- `menu-link-content.html.twig` — renders a single menu link's field content (theme hook
  `menu_link_content`, registered in `menu_item_extras_theme()`).
- `menu--extras.html.twig` — menu wrapper variant for enriched menus.
- `menu-levels.html.twig` — theme hook `menu_levels` for level-aware rendering.

## Theme hook suggestions
`menu_item_extras_theme_suggestions_menu_link_content()` builds granular suggestions from
the view mode, menu name, level, and entity id, e.g. (most specific last):
```
menu-link-content--{view_mode}.html.twig
menu-link-content--{menu_name}--{view_mode}.html.twig
menu-link-content--{menu_name}--menu-level-{n}--{view_mode}.html.twig
menu-link-content--{menu_name}--{entity_id}--{view_mode}.html.twig
```
Similar suggestion providers exist for `menu` (`…_suggestions_menu`), `menu_levels`, and a
`field` suggestion alter. Copy a template into your theme and name it per the suggestion to
override just the menus/levels/view modes you need (see the `mie_demo_base` submodule for
worked examples).

## Cache & preprocess
- Cache context `cache_context.menu_item_extras_link_item_content_active_trails` keeps
  enriched menus cacheable per active trail.
- `hook_preprocess_menu()` / `hook_preprocess_block()` inject the rendered field content and
  view-mode data into menu/block variables.
