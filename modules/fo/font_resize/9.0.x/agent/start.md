<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Font Resize (font_resize) — agent index

A visitor-facing text-zoom widget delivered as a single **Block plugin**. Renders three links
A- / A / A+ that decrease, reset, and increase page `font-size` via a jQuery plugin, entirely
client-side. Version `9.0.3` (version-dir `9.0.x`). Core `^10 || ^11`. Package Custom.
License GPL-2.0-or-later. No dependencies.

## Dependencies
- Drupal modules: none.
- Libraries: `core/jquery` (declared by both shipped libraries).
- No external/CDN assets — JS is local under `js/`.

## What it provides
- **Block plugin** `resize_block` — `src/Plugin/Block/ResizeBlock.php`
  (`ResizeBlock extends BlockBase`), admin label "Resize block". No config form / no settings.
- **Asset libraries** (`font_resize.libraries.yml`):
  - `font_resize/font_resize` — `js/font_resize.js`, the jQuery plugin `$.fn.font_resize`.
  - `font_resize/font_resize_example` — `js/example-font_resize.js`, initializer applying the
    plugin to `$('html')`.
- **hook_help** for `help.page.font_resize` (`font_resize.module`) — a short About blurb.
- No routes, no settings/config route (`configure` is null), no permissions, no services,
  no config schema, no Drush, no submodules, no templates.

## Key behavior
- Block `build()` returns fixed markup (`#type => markup`) and `#attached.library` for BOTH
  libraries above. There are no per-instance block settings.
- The default initializer resizes the `<html>` element, so the **theme must use relative units
  (em/rem)** for the change to reach page text. This is the module's stated requirement.
- +1px per A+ click / -1px per A- click, capped at 10 steps each way; A resets; limit buttons get
  a `font_resize-disabled` class; Enter activates a focused button.

## Solution docs
- [agent/configure/block.md](configure/block.md) — place the "Resize block", the markup it emits,
  the two attached libraries, the plugin's click/keyboard behavior and step limits.
- [agent/theming/customize.md](theming/customize.md) — the em/rem requirement, targeting a
  specific class/id instead of `<html>`, and styling the A-/A/A+ buttons.
