<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Jumper provides a small, dependency-free smooth-scrolling block that jumps the page to the top or to any configured selector, using the browser's native smooth scrolling or the optional Jump.js library when installed.
---
The module exposes a single block plugin, `jumper_block` (category "Jumper"). Its block form configures the scroll target (a CSS selector such as `#header`), animation duration and pixel offset, an optional icon class (FontAwesome/Icon API), a background color and rounded style, the trigger text, the activation-point scroll distance at which the button appears, and additional selectors that should also act as jumpers. Two toggles cover accessibility (visually hide the title) and layout ("out of the block", rendering the jumper as a direct body child to sidestep fixed-positioning conflicts). On build it renders a `<current>` link with `jumper`/`jumper--block` classes plus modifier classes, sets `data-target`, and attaches the `jumper/load` library with all settings passed via `drupalSettings`.

The `load` library (vanilla JS using `requestAnimationFrame` and `core/drupal.debounce`) drives the scrolling; if the optional Jump.js library is present at `/libraries/jump/dist/jump.min.js`, `hook_library_info_alter()` adds it as a dependency, otherwise native scrolling is used. The module depends on Blazy purely to reuse its JS helper utilities (no lazy-load assets are loaded), and on core Block for placement. There are no routes, permissions, services, or server-side data handling — configuration is standard block config, and the only markup handling in `build()` strips tags from the target and text (allowing only `<span>`), so the surface is limited to trusted block-admin input.
---
- Place a "Jump to top" button via the Jumper block in a footer/region.
- Configure the scroll target to any CSS selector (e.g. `#main`, `#top`).
- Set the animation duration in milliseconds.
- Add a pixel offset to stop above/below a fixed header.
- Show the button only after scrolling past an activation point.
- Use an icon-only button by visually hiding the title text.
- Pick a provided background color and rounded style, or DIY with CSS.
- Add a FontAwesome or Icon API class as the button glyph.
- Add extra jumper selectors so other links trigger smooth scroll.
- Render the jumper outside the block wrapper ("out of the block") to fix theme conflicts.
- Use native smooth scrolling with no external library.
- Install Jump.js at `/libraries/jump/dist/jump.min.js` for polyfilled scrolling.
- Add `class="jumper"` with `[href]` or `[data-target]` to in-body links for jump behavior.
- Reposition the block (bottom-left, centered) with simple CSS overrides.
- Exclude the block on specific pages via block visibility.
- Provide a "jump anywhere" single-page-site navigation.
- Auto-trigger a View's Load More when reaching the jumper (autovlm option).
- Reuse Blazy's JS utilities without loading lazy-load assets.
- Keep markup safe (target/text are tag-stripped, only `<span>` allowed in text).