<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Accessible Back To Top (accessible_back_to_top) — agent index

A placeable "back to top" button: a floating scroll-to-top control that appears after ~800px of
scroll and smooth-scrolls the window to the top on click or Enter/Space. Keyboard-focusable and
screen-reader oriented. Version **1.1.0** (dir `1.1.x`), core `^8 || ^9 || ^10 || ^11`.

- **Dependencies:** none beyond Drupal core. No Composer requirements, no PHP constraint.
- **Provides:** one Block plugin `back_to_top_block` (`BackToTopBlock`) and one asset library
  `accessible_back_to_top/back-to-top` (CSS + vanilla JS).
- **No** routes, permissions, services, hooks, config objects, config schema, install hooks, or
  settings form. Nothing to configure — enable, then place the block.
- **Operate it:** place "Back to top block" in a theme region (Block Layout); restyle via the
  `.back-to-top` CSS class.

Solution docs:
- [Block & library](blocks/back-to-top.md) — the block plugin, its markup, the JS behavior, and CSS hooks.
