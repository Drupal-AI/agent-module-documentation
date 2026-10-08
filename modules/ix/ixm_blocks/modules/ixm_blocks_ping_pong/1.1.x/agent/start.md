<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Ping-Pong (ixm_blocks_ping_pong) — agent index

Nested submodule of **ixm_blocks**. Alternating image/text zigzag.
Version **1.1.3**. Core `^10 || ^11`.

**What goes wrong is reading order on mobile.** When columns stack, whether image or text comes
first depends on the implementation — CSS row reversal leaves DOM order intact, so a row reading
image-then-text on desktop may read text-then-image when stacked, or every row may stack the same
way regardless of the visual alternation.

Neither is wrong, but it should be a **decision**, consistent across rows. Check at mobile width
with real content, and with a screen reader — which follows DOM order, not the visual
arrangement.