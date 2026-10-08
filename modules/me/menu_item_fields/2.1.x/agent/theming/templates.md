<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Rendering & theming

How Menu Item Fields turns menu links into rendered entities, and the templates involved.

## Theme hooks & template override

`Theme` (hook class):

- `hook_theme()` registers a **`menu_link_content`** theme hook (render element `elements`,
  template `menu-link-content.html.twig`) with an initial preprocess that copies element children
  into `content`.
- `hook_theme_registry_alter()` **repoints the core `menu` theme hook's template path** from
  `core/modules/system/templates` to this module's `templates/` dir (so its
  `menu.html.twig` is used) and adds two variables to the `menu` hook:
  `view_mode` (default `default`) and `view_mode_override_field` (default `''`).

Because it overrides the `menu` template path, a theme that ships its **own** `menu.html.twig`
keeps control — you then must adapt that template to render the fields (see migration below).
Themes without their own `menu.html.twig` inherit this module's version. (Olivero ships one, so
it needs adapting.)

## The rendering pass — `hook_preprocess_menu()`

`PreprocessMenu::preprocess()` (ordered after `ui_icons_menu`) walks `variables['items']`
recursively and, for every item id starting with `menu_link_content:`, loads the
`menu_link_content` entity by UUID and renders it with the entity view builder:

- view mode = `variables['view_mode']` (from the block), default `default`;
- if `variables['view_mode_override_field']` is set and the menu link's value in that field names
  an existing `entity_view_display` (`menu_link_content.<bundle>.<value>`), that per-item view
  mode wins;
- the rendered entity is placed at `$item['content']` with a `#pre_render` callback
  (`\Drupal\menu_item_fields\Render\Callback::preRenderMenuLinkContent`).

## `Callback::preRenderMenuLinkContent()` (trusted `#pre_render`)

Bridges the menu-item data into the rendered `link` field: copies the menu item's title into the
link field title, carries over the `title` attribute (description), `set_active_class`, and
handles `ui_icons_menu` markup. So the link the theme renders is the field, populated from the
menu item.

## Migrating a theme 1.x → 2.x

- 8.x-1.x used a separate `menu__field_content` theme hook; 2.x drops it and alters the plain
  `menu` hook instead.
- If your theme had `menu--field-content.html.twig`, rename it to `menu.html.twig`.
- If your theme already overrides `menu.html.twig`, adapt it using this module's
  `templates/menu.html.twig` as the reference so additional fields (not just the link) render.

## Files to copy from when overriding

- `templates/menu.html.twig` — the menu tree, rendering `item.content` when present.
- `templates/menu-link-content.html.twig` — a single rendered menu link entity.
