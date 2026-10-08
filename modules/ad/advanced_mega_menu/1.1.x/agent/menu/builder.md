<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The mega-menu entity, layout builder & rendering

## The `megamenu_content` config entity

`src/Entity/MegaMenuContent.php` — `@ConfigEntityType(id="megamenu_content")`, config prefix
`megamenu_content`, `admin_permission = "administer menus"`, `list_cache_tags = {"rendered"}`.
Entity keys: `id`/`form_id` (the menu-link **UUID**, prefix stripped), `label`, `status`.
`config_export`: `form_id`, `menu_id`, `label`, `rows`, `display_settings`, `uuid`. Handlers:
list builder `MegaMenuContentListBuilder`, forms `MegaMenuContentForm` (add/edit — note: the
*rendered* edit form is actually `MegaMenuLayoutBuilderForm` via the controller, see below) and
`MegaMenuContentDeleteForm`. Interface `MegaMenuContentInterface`.

Stored data:
- `rows` — array of `{column_layout_mode, single_row_class, columns[]}`; each column
  `{col_class, blocks[]}`; each block `{category, content_id|view_id|theme_id, show_label,
  row_id, column_id, weight}`. `category` is one of `content_id` (Block Content), `view_id`
  (a Views `view:display` string), `theme_id` (a placed theme/system block id).
- `display_settings` — `{menu_display_mode, menu_items_position, menu_items_layout,
  wrapper_class, row_class, column_class}`. `getDisplaySettings()` runs the three class values
  through `Html::cleanCssIdentifier()`.

Schema `advanced_mega_menu.megamenu_content.*` types `rows` and `display_settings` as `ignore`.

## Building a layout — `MegaMenuLayoutBuilderForm`

Reached via `AdvancedMegaMenuController::action($menu_id, $menu_link_content)` (route
`advanced_mega_menu.action`). The controller validates the requested UUID against the menu's links
(`MenuLinkHelper::getMenuLinksWithTitles()`, 404 on mismatch), loads or `MegaMenuContent::create()`s
the entity, and returns `MegaMenuLayoutBuilderForm` (`src/Form/MegaMenuLayoutBuilderForm.php`, form
id `advanced_mega_menu_settings_form`). The builder links themselves are injected into every menu
row by `hook_form_menu_edit_form_alter`: a **gear/modal** link (AJAX dialog, 97%×610) and a
**new-tab** full-screen link.

Canvas mechanics (all AJAX, wrapper `#mega-menu-canvas`, callback `::refreshAjax`):
- `::addRow` / `::removeRow`, `::addColumn` / `::removeColumn`, `::addBlock` / `::removeBlock`
  mutate `$form_state->get('layout')` and `setRebuild()`. `refreshAjax()` replaces the canvas and
  issues a `ScrollToCommand` to the new element.
- Per row: **Column Width Mode** select — options `auto, equal, fraction, wrap, minmax,
  proportional, rfrac, dynstack, fauto, adapt, columns-2 … columns-6`, plus **custom** (which
  reveals a `single_row_class` textfield and per-column `col_class` textfields).
- Per block: a **Block Category** select (`content_id`/`view_id`/`theme_id`) with three source
  selects populated by `prepareSourceOptions()` — Block Content grouped by bundle, Views `block`
  displays as `view_id:display_id`, and placed blocks of the **default theme** grouped by region —
  plus a **Show Label** checkbox and hidden `row_id`/`column_id`/`weight` drag fields.
- **Menu display settings** (`display_settings`): `menu_display_mode`
  (`menu_only`/`menu_and_mega`/`mega_only`, default `mega_only`), `menu_items_position`
  (`top`/`bottom`), `menu_items_layout`, and common `wrapper_class`/`row_class`/`column_class`.

Hard limits enforced in `submitForm()`/`validateForm()`: **30 rows**, **24 columns/row**,
**16 blocks/column**. CSS-class fields are validated with `advanced_mega_menu_are_valid_classes()`.
`submitForm()` sorts blocks by `weight`, trims to the limits, then
`setRows()/setStatus()/setDisplaySettings()/save()`.

## Rendering path

1. `hook_preprocess_menu` (in `.module`): for a menu in `enabled_menus`, adds class
   `mega-nav-links`, sets `theme_hook_original = menu__advanced_mega_menu`, generates the
   `submenu_icon`, and for each item calls
   `MegaMenuRowBuilder::buildMenuItemMegaRows($menu_name, $plugin_id, $item)`.
2. `Service\MegaMenuRowBuilder` (`advanced_mega_menu.mega_menu_row_builder`): loads the
   `megamenu_content` entity by `form_id`(UUID)+`menu_id`; returns `NULL` if missing or
   `status = FALSE`. Honors `menu_display_mode` (loads mega rows unless `menu_only`; extracts the
   item's two-level children via `advanced_mega_menu_get_child_items()` and clears `$item['below']`
   to avoid duplicates when `menu_only`/`menu_and_mega`). Re-sanitizes `row_class`/`column_class`
   with `advanced_mega_menu_sanitize_classes()`. Returns a `#theme => 'advanced_mega_menu'` array
   with `#mega_menu_contents`, `#menu_link_contents`, `#display_settings`, `#has_children`.
3. `MegaMenuContent::getRowsData()` builds the per-row/column `Attribute` objects (applying
   `column_layout_mode`, cleaned classes) and, per block, calls the block renderer via a `match`
   on `category`.
4. `Service\MegaMenuBlockRenderer` (`advanced_mega_menu.block_renderer`):
   - `renderThemeBlock($block_id, $show_label)` → loads a `block` entity, `getViewBuilder('block')->view()`.
   - `renderViewBlock(['view_id','display_id'], $show_label)` → `Views::getView()`, checks
     enabled/display exists, `$view->render()`.
   - `renderContentBlock($block_id, $show_label)` → loads `block_content`, `getViewBuilder(...)->view()`.
   - Each catches `\Throwable`, logs to the `advanced_mega_menu` channel, and returns a fallback
     "Unable to render…" markup so one bad block never breaks the menu.
5. Templates: `menu--advanced-mega-menu.html.twig` (recursive `menu_links` macro; wraps mega items
   in `.advanced-mega-menu-panel` with `wrapper_class`) renders `item.mega_menu_rows`, which is the
   `advanced-mega-menu.html.twig` panel (rows → `row_attributes`, columns → `column_attributes`,
   blocks, and the optional parent/child/grandchild menu-link section positioned top or bottom).

## Admin list & delete

`MegaMenuContentListBuilder` (route `advanced_mega_menu.megamenu_content.collection`,
`/admin/structure/advanced-mega-menu/list`) shows label, linked menu + enabled/disabled state,
per-entity status, and Edit (→ `advanced_mega_menu.action`) / Delete
(→ `entity.megamenu_content.delete_form`, a `ConfirmFormBase`) operations.
