<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Type Tray restyles the Type Tray module's `/node/add` content-creation screen to match the Gin administrative theme, including full dark-mode support.

---

The module is a pure presentation-layer bridge between the Type Tray module (which turns the plain `/node/add` list into a categorized "tray" of content-type cards) and the Gin admin theme. It carries no configuration, permissions, entities, schema, or Drush commands. It works by (1) overriding Type Tray's `type_tray_teaser` and `type_tray_page` theme hooks via `hook_theme_registry_alter()` to point at its own Twig templates (`templates/type-tray-teaser.html.twig`, `type-tray-page.html.twig`); (2) swapping Type Tray's stylesheet for Gin-aware CSS built on Gin's CSS custom properties (`hook_library_info_alter()` replaces the `type_tray/type_tray` library CSS with `css/gin_type_tray.css`); (3) a `hook_preprocess_type_tray_teaser()` that normalises icon/thumbnail URLs and inlines SVG icons (using Twig's `source()`) so their colors can follow Gin's dark/light variables; and (4) a route subscriber (`GinTypeTrayRouteSubscriber`) that repoints the `node.add_page` route controller to `GinTypeTrayController::addPage`, a subclass of Type Tray's controller that swaps the default content-type icon for its own `file-text.svg`. The result is a Type Tray screen that visually belongs to Gin. It requires both `type_tray` and the `gin` theme.

---

- Make the Type Tray `/node/add` screen visually match a site that uses the Gin admin theme.
- Add dark-mode support to the Type Tray content-creation screen via Gin CSS variables.
- Render Type Tray content-type icons as inline SVG so they recolor with Gin's theme.
- Replace Type Tray's default content-type icon with a Gin-styled document icon.
- Give editors a polished, on-brand "choose a content type" experience under Gin.
- Keep the Type Tray teaser cards (grid/list) styled consistently with Gin's design tokens.
- Provide Gin-themed grid and list layout toggles on the node-add page (`teaser_grid` / `teaser_list` libraries).
- Ship a Gin-native override of Type Tray's Twig templates without patching Type Tray.
- Ensure SVG content-type icons pick up Gin's foreground color in both light and dark modes.
- Fix icon/thumbnail URLs so they resolve correctly under subdirectory installs (base-URL handling).
- Adopt Type Tray on a Gin-based admin without the default (Claro-oriented) styling clashing.
- Present marketing/editorial teams a categorized, branded content-creation launcher.
- Maintain a single admin look-and-feel across Gin and the node-add tray.
- Override the `node.add_page` route rendering purely through a route subscriber (no config).
- Serve as a reference for theming a contrib module's output for a specific admin theme.
- Let type-specific thumbnails and extended descriptions display cleanly inside Gin cards.
- Improve accessibility/contrast of the node-add screen by inheriting Gin's accessible palette.
- Roll out a consistent content-authoring entry point for a multisite platform standardized on Gin.
- Avoid custom theme code by delegating the node-add styling to a dedicated module.
- Keep Type Tray upgrades painless because styling lives in gin_type_tray, not in a custom theme.
