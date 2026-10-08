<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the Jumper block

Place the **Jumper** block (category "Jumper") via `/admin/structure/block`. Block settings (schema `block.settings.jumper_block`):

| Setting | Meaning |
| --- | --- |
| `target` | Single CSS selector to scroll to (e.g. `#header`, `#main`). Numeric value is treated as a pixel target. |
| `duration` | Scroll animation time in ms (default 1000). |
| `offset` | Pixel offset when jumping to an element (negative stops above it). |
| `icon` | Custom icon class (FontAwesome/Icon API), e.g. `fa fa-angle-up`. |
| `color` | Provided background color (grey/dark/purple/orange/blue/lime/red) or empty. |
| `style` | Rounded style (round / round-2 / round-8 / round-12) or empty for square. |
| `no_text` | Visually hide the title (icon-only). |
| `text` | Button text (only `<span>` allowed) shown when `no_text` is off. |
| `visibility` | Activation point in px; button appears after scrolling this far (debounced ~250ms). |
| `selectors` | Extra comma-separated CSS selectors that also act as jumpers. |
| `ootb` | "Out of the block" — render as direct body child to avoid fixed-position conflicts. |
| `autovlm` | Auto-trigger a View's Load More on reaching the jumper. |

In-body usage: add `class="jumper"` to any link/button with an `[href="#id"]` or `[data-target="#id"]` and the `jumper/load` library (present when the block is placed) handles the smooth scroll. Optional: install Jump.js to `/libraries/jump/dist/jump.min.js`.
