# Link icons on menu items (configure)

Besides the field formatter, the module can add service icons to a **menu's external links**, toggled
per menu. This is driven by two hooks in `link_icons.module` and stored in one config object per menu.

## Turn it on

Edit a menu at `/admin/structure/menu/manage/<menu>`. `hook_form_menu_form_alter`
(`link_icons_form_menu_form_alter`) adds:

- a checkbox **"Render external links with icons?"** (`render`), and
- a collapsed **"Link icons"** details group exposing the same 8 formatter settings
  (`text`, `hideURLscheme`, `order`, `size`, `width`, `coloured`, `shaped`, `background`) via the shared
  `_link_icons_config_fields()`.

The extra submit handler `_link_icons_menu_edit_submit()` writes these to a config object named
**`link_icons.menu.<menu_id>`**, where `<menu_id>` is the menu machine name with hyphens replaced by
underscores (e.g. menu `main` → `link_icons.menu.main`; `my-menu` → `link_icons.menu.my_menu`). There is
no config-schema file for these objects.

## What it does at render time

`hook_preprocess_menu` (`link_icons_preprocess_menu`) runs for every rendered menu:

1. Skips admin routes (`router.admin_context`->`isAdminRoute()`).
2. Loads editable config `link_icons.menu.<menu_name>`; proceeds only if `render == TRUE`.
3. For each menu item whose `url->isExternal()` is true, replaces `items[i]['title']` with
   `_link_icons_link_markup($title, $url, $settings, $services)` — note **`$link` defaults to FALSE**
   here (the menu system already wraps the title in the anchor), so the helper returns just the icon
   (+ optional text) markup, not its own `<a>`.

Internal/relative menu links are left untouched. Only external items get an icon. The same
`link_icon_service` entities (see [services.md](services.md)) supply the domain → icon mapping.

## Notes for agents

- To enable icons for a menu from code: save `link_icons.menu.<menu_id>` with `render => TRUE` plus the
  8 settings keys, then rebuild caches.
- Because matching reuses the service entities, enable `link_icons_brands` (or add your own services)
  for brand icons to appear on menu links.
