<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessibility Tools block (accessibility_block) — agent index

A visitor-facing accessibility widget delivered as a single **Block plugin**. Renders a floating
toolbar for font resize (Small/Medium/Large/X-Large) and a colored/grayscale appearance toggle.
All switching is client-side JS; choices persist in the browser's `localStorage`. Version `1.0.7`
(version-dir `1.0.x`). Core `^10 || ^11`. License GPL-2.0-or-later.

## Dependencies
- Drupal modules: none.
- Libraries: `core/jquery`, `core/drupalSettings` (declared by `accessibility_block/accessibility`).
- No external/CDN assets — all CSS, JS and SVG icons are local under `assets/`.

## What it provides
- **Block plugin** `accessibility_block` — `src/Plugin/Block/AccessibilityTools.php`
  (`AccessibilityTools extends BlockBase`), admin label "Accessibility Tools Block".
- **Theme hook** `accessibility_block` — `accessibility_block.module`
  (`accessibility_block_theme()`), template `templates/accessibility-block.html.twig`.
- **Asset library** `accessibility_block/accessibility` — `accessibility_block.libraries.yml`
  (`assets/css/style.css`, `assets/js/main.js`).
- No routes, no permissions, no services, no config schema, no drush, no submodules.
- No settings/config route — configuration is per block instance in the block form.

## Config (per block instance)
Six values on the block config: `dark_mode` (bool, "Disable Dark Mode"), `font_resize`
(bool, "Disable Font Resize"), and four font sizes `accessibility_small` / `accessibility_medium`
/ `accessibility_large` / `accessibility_very_big` (pixel numbers). See
[agent/plugins/block.md](plugins/block.md).

## Solution docs
- [agent/plugins/block.md](plugins/block.md) — the Block plugin, its config form, the render
  array / drupalSettings contract, the Twig template, and the client-side behavior in main.js.
