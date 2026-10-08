<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Back to top with progress scrollbar (back_to_top_with_pi) — agent index

A single **Block plugin** that renders a floating "back to top" control ringed by a **circular SVG
scroll-progress indicator**. Package `Back to top with progress scrollbar`. Depends only on core
**`block`**. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.3.

- **The block, every setting, how it renders, and the JS behavior** →
  [blocks/back_to_top_block.md](blocks/back_to_top_block.md)

## What it actually is

- One plugin: `BackToTopBlock` (id **`back_to_top_with_pi`**, admin label *"Back to top with progress
  scrollbar"*), in `src/Plugin/Block/BackToTopBlock.php`, extending core `BlockBase`. It provides a
  per-placement config form (`blockForm`/`blockSubmit`), and `build()` emits a render array.
- One theme hook: **`back_to_top_with_pi`** (registered in `back_to_top_with_pi_theme()`), template
  `templates/back-to-top-with-pi.html.twig`, single variable `back_to_top_data` (array).
- One asset library: **`back_to_top_with_pi/back_to_top_with_pi`** (`back_to_top_with_pi.libraries.yml`)
  — `css/unicons.css` (bundled icon font), `css/custom.css`, `js/custom.js`; depends on core
  jquery, drupal.ajax, drupal, drupalSettings, once.
- `back_to_top_with_pi_help()` provides help text on `help.page.back_to_top_with_pi`.
- **No** routes, permissions, services, config schema, install/update hooks, submodules, or Drush.

## Mechanism (from source)

- Config is stored in normal **block config** (set on the standard *Place block* form, gated by core
  **`administer blocks`**). `build()` reads it, converts `#RRGGBB` shadow colors to `rgba(...)` via
  `sscanf`, assembles `$back_to_top_data`, and renders `#theme => 'back_to_top_with_pi'` with library
  attached.
- The Twig template writes the computed CSS into a **`data-attr`** attribute on the container and draws
  the SVG circle path. `js/custom.js` (`Drupal.behaviors.backtotop_scrollbar`) reads `data-attr`,
  injects it as a `<style>` element, computes `getTotalLength()` on the path, and on `scroll` sets
  `strokeDashoffset` proportional to scroll position. Past ~500px it adds `.active-progress`; on click
  it `animate({scrollTop:0})`. In `percentage` mode it writes the live `NN%` into `data-before`.

## Settings (block config, `blockForm`)

`circle_stroke_color`, `progress_box_shadow`, `icon_color`, `icon_hover_color` (all `#type color`),
`scroll_bar_position` (`left`/`right`, default right), `has_shadow` + `shadow_color` (#212121),
`has_fill_color` + `fill_color` (#000000), `scrollbar_type` (`icon`/`percentage`, default icon), and a
hidden `created_at` timestamp (used to build unique element ids). Details in
[blocks/back_to_top_block.md](blocks/back_to_top_block.md).
