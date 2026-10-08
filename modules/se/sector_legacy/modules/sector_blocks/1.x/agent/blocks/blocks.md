<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sector blocks — the five block plugins

All in `src/Plugin/Block/`, all extend core `BlockBase`, all render via `#theme` (except the
release-notes banner which uses `#markup`). No block has a config form or an access override.

| Class | `@Block` id | Admin label | Render |
|---|---|---|---|
| `ResponsiveMenuControls` | `responsive_menu_controls` | Sector blocks - Responsive menu controls | `#theme => responsive_menu_control_block` |
| `SearchApiBox` | `search_api_box` | Sector blocks - Search API block | `#theme => search_api_box` |
| `SearchApiBoxMobile` | `search_api_box_mobile` | Sector blocks - Search API block (mobile) | `#theme => search_api_box_mobile` |
| `SearchDesktopFlyOutControl` | `search_desktop_fly_out_control` | Sector blocks - Search desktop fly-out control | `#theme => search_desktop_fly_out_control_block` |
| `SectorReleaseNotes` | `sector_release_notes` | Sector blocks - Sector Release Notes block | `#markup` (inline HTML) |

## Templates & theme hooks

- `sector_blocks_theme()` (in `sector_blocks.module`) registers **only two** theme hooks:
  `responsive_menu_control_block` and `search_desktop_fly_out_control_block`, each
  `render element => 'element'`.
  - `templates/responsive-menu-control-block.html.twig` → `.control__menu` (`js-toggle-navigation`)
    and `.control__search` (`js-toggle-search`), each with `icon--inline icon--menu/search/close`
    spans and `sr-only` labels.
  - `templates/search-desktop-fly-out-control-block.html.twig` → `<a href="/search" …
    class="… js-toggle-flyout-search">` with search/close icons + SR labels.
- `search_api_box` and `search_api_box_mobile` are **not** registered here — the Sector/Radix
  theme is expected to define those templates (the plugins just name the theme hook). Without a
  theme providing them, those two blocks have no markup.

## SectorReleaseNotes specifics

- `build()` reads `\Drupal::service('path.current')->getPath()` into `$current_path` and returns a
  single `#markup` string: a `messages--status` banner announcing the Sector 9 → Sector 10 upgrade
  path (link to `https://www.sector.nz/news/…`) plus an inline "x" link to
  `/admin/structure/block/manage/sectorblocksreleasenotesblock/delete?destination=<current_path>`
  (the block's own delete form — the intended "dismiss" is to delete the placed block).
- It is a temporary distribution-upgrade nag; place it in an admin-visible region during an upgrade
  window and remove it afterward.

## Enable & place

1. `drush en sector_blocks -y` (no extra deps).
2. *Structure → Block layout* → place the desired blocks; set region/visibility/roles there.
3. Use a Sector/Radix theme that provides the `js-toggle-*` behavior, the icon system
   (`icon--menu/search/close`), and the `search_api_box*` templates. This module ships **no** JS or
   CSS of its own.
