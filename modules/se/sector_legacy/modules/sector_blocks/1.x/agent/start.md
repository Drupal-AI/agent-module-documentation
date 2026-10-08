<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector blocks (sector_blocks) — agent index

Submodule of **Sector Legacy**. Ships **five block plugins** for the Sector distribution themes.
Package `Sector`. Core `^10 || ^11`. **No `dependencies:`**, no routes/permissions/config/schema.
GPL-2.0-or-later. Version 1.0.6.

## Block plugins (`src/Plugin/Block/`)

- **`ResponsiveMenuControls`** — id `responsive_menu_controls`, *"Sector blocks - Responsive menu
  controls"*. `build()` returns `#theme => 'responsive_menu_control_block'`. Template renders
  `.control__menu`/`.control__search` with `js-toggle-navigation` / `js-toggle-search` hooks + SR
  labels.
- **`SearchApiBox`** — id `search_api_box`, *"…Search API block"*. `#theme => 'search_api_box'`
  (template expected from the **theme layer**, not shipped here).
- **`SearchApiBoxMobile`** — id `search_api_box_mobile`. `#theme => 'search_api_box_mobile'`
  (template from theme layer).
- **`SearchDesktopFlyOutControl`** — id `search_desktop_fly_out_control`.
  `#theme => 'search_desktop_fly_out_control_block'`. Template renders an `<a href="/search">`
  toggle with `js-toggle-flyout-search`.
- **`SectorReleaseNotes`** — id `sector_release_notes`. Returns an `#markup` announcement banner
  (Sector 9 → 10 upgrade nag) with a link to `sector.nz` news and an inline "x" dismiss link to
  the block's own delete route.

All five extend core `BlockBase`; none override `blockAccess()`/`blockForm()` — placement and
visibility are set on the block config UI.

## hook_theme (`sector_blocks.module`)

`sector_blocks_theme()` registers **two** themes: `responsive_menu_control_block` and
`search_desktop_fly_out_control_block` (both `render element => 'element'`), with templates in
`templates/`. The `search_api_box*` themes referenced by the search blocks must come from the
active Sector/Radix theme.

## Solution docs

- **All five blocks, their ids/themes/templates, and how to place them** →
  [blocks/blocks.md](blocks/blocks.md)

## Operate

- `drush en sector_blocks -y`; place blocks at *Structure → Block layout*. Interactive toggling is
  provided by the **theme's** JS binding to the `js-toggle-*` classes; this module ships no JS/CSS.
