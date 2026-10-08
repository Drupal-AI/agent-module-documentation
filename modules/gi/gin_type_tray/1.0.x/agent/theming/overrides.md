<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: template, library and icon overrides

All hooks live in `gin_type_tray.module`; templates in `templates/`; CSS in `css/`.

## Theme-hook / template overrides — `hook_theme_registry_alter()`
Repoints two Type Tray theme hooks at this module's templates:
- `type_tray_teaser` → `templates/type-tray-teaser.html.twig` (a content-type card).
- `type_tray_page` → `templates/type-tray-page.html.twig` (the whole tray page). It also adds
  `node_add_page_url_grid` / `node_add_page_url_list` variables (URLs to `node.add_page` with
  `layout=grid` / `layout=list`) for the layout toggle.

## Library / CSS swap — `hook_library_info_alter()`
When `$module === 'type_tray'`, replaces the `type_tray` library's `css.theme` with
`/<module_path>/css/gin_type_tray.css` (weight 1). This is the file that maps onto Gin's CSS
custom properties for dark-mode support. The module also declares its own libraries in
`gin_type_tray.libraries.yml`: `teaser`, `teaser_list` (depends on `teaser`),
`teaser_grid` (depends on `teaser`).

## Icon / thumbnail preprocessing — `hook_preprocess_type_tray_teaser()`
- Computes `icon_filetype` from the icon URL extension.
- For **SVG** icons: strips the base URL so the path is root-relative, letting the SVG be
  inlined (Type Tray uses Twig `source()`), so `fill`/`color` follow Gin's theme variables.
- For non-SVG icons: prepends scheme+host+base URL to make an absolute URL.
- Thumbnails beginning with `/module` get the origin URL prepended (subdirectory-install fix).

Net effect: Type Tray's markup is unchanged structurally, but rendered through Gin-aware
templates and CSS. There is nothing to configure — enabling the module (with Gin active) is
the whole setup.
