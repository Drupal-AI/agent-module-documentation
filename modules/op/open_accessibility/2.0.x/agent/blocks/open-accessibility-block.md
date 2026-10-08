<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block: Open Accessibility (`open_accessibility_block`)

Source: `src/Plugin/Block/OpenAccessibilityBlock.php`. This block is the **only** thing that
renders the widget on the front end — enabling the module alone does nothing until the block is
placed.

## Placement
- Admin UI: Structure → Block layout → place "Open Accessibility" in a region (any region;
  the init JS binds to the page `header`, not the block's own markup, so region choice mainly
  affects where the block wrapper sits).
- The block outputs no visible markup of its own beyond the render array; the toolbar UI is
  built by the bundled jQuery plugin (`$('header').openAccessibility(...)`).

## What `build()` does
- Attaches library `open_accessibility/open-accessibility`.
- Sets `drupalSettings.openAccessibility` from `open_accessibility.settings`:
  `menu_opened`, `highlighted_links`, `mobile_enabled`, `text_selector`, `icon_size`.
  (`highlighted_links` has no config screen and is always null.)
- `getCacheMaxAge()` returns `0` — the block is not cached.

## Notes
- Constructor injects `config.factory` → `open_accessibility.settings` (via
  `ContainerFactoryPluginInterface::create`).
- No block-level configuration form beyond core defaults; all behavior comes from the
  module's global settings form (see `../config/`).
