<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu & Views-menu icon integration

Out of the box, Icons lets editors attach an icon prefix/suffix to **menu link content** items and to
a **Views display's menu tab/link**, and renders them in the menu. All hooks live in
`Drupal\icons\Hook\IconsHooks` (thin `#[LegacyHook]` wrappers remain in `icons.module`).

## Form alters (add the picker)

- `hook_form_menu_link_content_form_alter` — adds an "Icons" details group with two `icon_select`
  elements, `icon_prefix` and `icon_suffix`, populated from `icons.manager::getIconOptions()`.
  A submit handler (`menuLinkContentFormSubmit`) stores the chosen ids into the link item's
  `options['icons']` (`icon_prefix` / `icon_suffix`) and re-saves the menu link entity.
- `hook_form_views_ui_edit_display_form_alter` — for menu-type displays only, adds the same
  `icon_prefix`/`icon_suffix` `icon_select` elements under `options.menu.icons` (`#tree`). Values are
  saved into the Views display's `menu` options by Views itself.

Both need at least one Icon Set defined; otherwise `getIconOptions()` yields nothing.

## Rendering into the menu

- `hook_preprocess_menu` → `IconsManager::processMenuItems($variables['items'])` walks the menu tree
  (recursing into `below`).
- For each item, `getMenuItemIcons()` reads the stored icons: for `menu_link_content:*` links it loads
  the entity by UUID and reads `link.options['icons']`; for `views_view:*` links it reads the display's
  `menu` options.
- `formatMenuIconItem()` wraps the title as
  `icon_prefix` (`Icon::buildRenderArray($id)`) + `<span class="menu-icon-label">title</span>` +
  `icon_suffix`, renders it, and replaces `item['title']`. Icons resolve to CSS classes via their
  set's plugin `build()`.

## Storage shape

Menu link content: `link` field → `options['icons'] = ['icon_prefix' => 'set:name', 'icon_suffix' => 'set:name']`.
Views menu display: `display_options['menu']['icons']['icon_prefix'|'icon_suffix']`.

The stored value is always an icon id `"<icon_set_id>:<icon_name>"`.
