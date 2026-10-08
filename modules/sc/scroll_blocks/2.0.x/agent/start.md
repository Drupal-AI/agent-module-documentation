<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scroll blocks (scroll_blocks) — agent index

Adds a per-block option that makes a core **block** slide up from the bottom of the viewport (and
back down) based on the visitor's vertical scroll distance and window width. Package *User
interface*. Depends on core **`block`**. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version **2.0.0-alpha7** (alpha — note this when recommending it).

- **The full mechanism: the five settings, the schema, presave cleanup, the render attributes, the
  library, the JS and CSS behavior** → [config/block-settings.md](config/block-settings.md)

## What it actually is

- **No PHP classes, no plugins, no entities, no routes, no permissions, no services, no Drush.**
  Everything is in the procedural `scroll_blocks.module` (3 hooks) plus a library (JS + 2 CSS files).
- Settings live in each block's **third-party settings** under provider key `scroll_blocks` — not in
  any config object of its own and not on an admin form. `configure` route: none.
- The effect is per **block placement** (a `block` config entity), so the same block placed twice
  can have different thresholds.

## Mechanism (from source)

- `scroll_blocks_form_block_form_alter()` — adds five fields to the core block form under
  `third_party_settings[scroll_blocks]`: `enabled` (checkbox), `min_scroll_distance`,
  `max_scroll_distance`, `min_width`, `max_width` (number inputs, shown/required via `#states` only
  when `enabled`). Saved automatically as third-party settings (`#tree` = TRUE).
- `scroll_blocks_block_presave()` — if `enabled` is empty, **unsets all five** keys so disabled
  blocks store nothing.
- `scroll_blocks_preprocess_block()` — for a block with `enabled` on, adds class `scroll-blocks`,
  five `data-scrollblocks-*` attributes carrying the thresholds, and attaches library
  `scroll_blocks/scroll_blocks`. Blocks without an `#id` (e.g. Page Manager widgets) are skipped.
- `js/scroll-blocks.js` (`Drupal.behaviors.scroll_blocks`) reads the data attributes on each
  `scroll` (rAF-debounced) and toggles class `scroll-blocks--visible` when
  `min_scroll_distance <= pageYOffset <= max_scroll_distance` and the width gates pass. It injects a
  `.scroll-blocks__close-button`; clicking it sets `data-scroll-blocks--disable` to mute the block
  until reload. Fires `scroll_blocks_show_block` / `scroll_blocks_hideblock` CustomEvents.
- CSS fixes the block bottom-center (`position:fixed; translateY(100%)`), animating to
  `translateY(0)` when `.scroll-blocks--visible`.

## Config schema

`config/schema/scroll_blocks.schema.yml` defines `block.block.*.third_party.scroll_blocks`
(booleans/integers for the five keys) — so exported block config validates.

## Two checks before deploying

1. **Reduced motion.** The shipped CSS uses a 1s `transition` unconditionally and does not honor
   `prefers-reduced-motion`; override in the theme if that matters.
2. **Mobile overlap.** The fixed bottom panel can cover content on small screens — use `min_width` /
   `max_width` and test with the block visible.
