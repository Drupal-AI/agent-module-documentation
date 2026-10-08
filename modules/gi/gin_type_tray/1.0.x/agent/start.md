<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gin Type Tray — agent index

Presentation-only bridge that restyles the **Type Tray** `/node/add` screen for the **Gin**
admin theme (with dark mode). No config, no permissions, no schema, no Drush, no entities
(`configure: null`). Requires the `type_tray` module and the `gin` theme.

- **Templates, theme-hook overrides, library/CSS swap, icon preprocessing** →
  [theming/overrides.md](theming/overrides.md)
- **Route subscriber + controller override that repoints `node.add_page`** →
  [extend/route-controller.md](extend/route-controller.md)

Key facts:
- `hook_theme_registry_alter()` repoints Type Tray's `type_tray_teaser` and `type_tray_page`
  theme hooks at this module's `templates/`.
- `hook_library_info_alter()` replaces `type_tray/type_tray` CSS with `css/gin_type_tray.css`.
- `GinTypeTrayRouteSubscriber` sets `node.add_page`'s `_controller` to
  `\Drupal\gin_type_tray\Controller\GinTypeTrayController::addPage`.
- All content-type grouping/icons still come from the parent **type_tray** config
  (node-type third-party settings `type_tray.*`); this module only themes the output.
