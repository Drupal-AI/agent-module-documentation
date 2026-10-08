<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Civic Accessibility Toolbar — agent index

A single Block plugin (`accessibility_toolbar_block`) that renders front-end text-resize and
color-contrast controls; the JS toggles CSS classes on `<html>`/`<body>` and persists each choice in a
cookie. No global config (`configure` null), no permissions, no dependencies beyond core. All settings
live on the block instance.

- **Block settings, placement, and the config keys** → [configure/block.md](configure/block.md)
- **The CSS classes it toggles, the cookies, the rem/em requirement, and how to restyle it** →
  [theming/customize.md](theming/customize.md)

Key facts:
- Block config keys: `text_resize` (bool), `color_contrast` (bool), `text_resize_label`,
  `color_contrast_label` (defaults: on/on, "Text"/"Color").
- Font size → `font__1` / `font__125` / `font__15` on `<html>`; contrast →
  `theme__blue` / `theme__hivis` / `theme__soft` on `<body>`.
- Cookies `fontSize` and `colorContrast` (`SameSite=Strict`, path `/`, 365 days) restore the selection.
- Text resizing only works if the active theme uses `rem`/`em` font units.
