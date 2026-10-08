<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Hero (ixm_blocks_hero) — agent index

Nested submodule of **ixm_blocks**. Full-width **hero** introduction block.
Version **1.1.3**. Core `^10 || ^11`.

**Two properties of heroes generally, worth checking against this implementation before site-wide
use:** it is almost always the page's **largest contentful paint** (so responsive configuration
matters most here, and preloading is often the highest-value performance change); and **text over a
photograph is a contrast problem** — legible over one image, illegible over the next, and the image
is what editors change. Overlay, scrim or constrained text area is what makes it reliable.