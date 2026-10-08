<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Cards (ixm_blocks_cards) — agent index

Nested submodule of **ixm_blocks**. **Card grid** — the workhorse component.
Version **1.1.3**. Core `^10 || ^11`.

Settles per-breakpoint counts, odd-number behaviour, and whether the whole card or only the heading
is the link.

**Check the accessibility mistake card grids make most:** a clickable card whose link accessible
name is the card's whole text (a screen reader announces a paragraph as a link name), and a second
link nested inside it (invalid markup, unpredictable behaviour).