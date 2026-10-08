# tb_megamenu — configure

## Routes (from tb_megamenu.routing.yml)

All require permission `administer tb_megamenu`.

| Route | Path | Purpose |
|---|---|---|
| `entity.tb_megamenu.collection` | `/admin/structure/tb-megamenu` | List mega menus (**the `configure` route**) |
| `entity.tb_megamenu.add_form` | `/admin/structure/tb-megamenu/add` | Add a mega menu (pick menu + theme) |
| `entity.tb_megamenu.edit_form` | `/admin/structure/tb-megamenu/{tb_megamenu}` | Drag-and-drop layout builder |
| `entity.tb_megamenu.delete_form` | `/admin/structure/tb-megamenu/{tb_megamenu}/delete` | Delete |
| `tb_megamenu.admin.save` | `/admin/structure/tb-megamenu/save/{tb_megamenu}` | AJAX save (CSRF-protected) |

## Workflow

1. Structure → TB Mega Menu → **Add a Mega Menu**: choose an existing core menu and a theme.
   The config entity id is `{menu}__{theme}` (e.g. `main__olivero`).
2. On the edit form, drag menu items into rows/columns, drop blocks into columns, and set
   options in the item/column/submenu toolboxes. Save (AJAX).
3. Place the block: **Structure → Block layout**, add the block named after the menu in the
   *TB Mega Menu* category. Each configured menu/theme becomes a derivative
   (`tb_megamenu_menu_block:{menu}`).

## Config entity

- Entity type id: `tb_megamenu`; config prefix `menu_config` → config names
  `tb_megamenu.menu_config.{menu}__{theme}`.
- `config_export` / schema fields: `id`, `menu`, `theme`, `block_config`, `menu_config`.
- `block_config` and `menu_config` are **JSON-encoded strings**, not nested config. Read them
  via the entity's `getBlockConfig()` / `getMenuConfig()` (which HTML-escape item classes,
  captions, xicons, labels for XSS safety), and write via `setBlockConfig()` / `setMenuConfig()`.

## Block-level settings (block_config, defaults)

| Key | Default | Notes |
|---|---|---|
| `animation` | `none` | one of: `none`, `fading`, `slide`, `zoom`, `elastic` |
| `style` | `''` | one of: `''` (Default), `black`, `blue`, `green` |
| `auto-arrow` | `TRUE` | show arrow on items with children |
| `duration` | `400` | animation duration (ms, integer) |
| `delay` | `200` | animation delay (ms, integer) |
| `always-show-submenu` | `TRUE` | keep submenu visible |
| `off-canvas` | `0` | off-canvas mobile presentation |
| `number-columns` | `0` | force fixed column count (0 = auto) |

## Per-item settings (menu_config → item_config, defaults)

`xicon` (Font Awesome icon), `class`, `caption`, `alignsub`, `group` (0), `hidewcol` (0),
`hidesub` (0), `label`.

## Per-column settings (col_config, defaults)

`width` (12, Bootstrap 12-grid), `class`, `hidewcol` (0), `showblocktitle` (0).

## Per-submenu settings (submenu_config, defaults)

`width`, `class`, `group`.

## Notes

- The block disables render caching by default (config form sets `cache.max_age` to 0) and
  declares cache tags `config:system.menu.{menu}` and `config:tb_megamenu.menu_config.{id}`,
  varying by `route.menu_active_trails:{menu}`.
- Blocks provided by tb_megamenu itself are excluded from the "add block to column" picker.
- No `config/install` defaults ship — nothing exists until you create a mega menu.
