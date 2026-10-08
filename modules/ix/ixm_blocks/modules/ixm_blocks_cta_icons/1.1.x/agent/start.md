<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: CTA Icons (ixm_blocks_cta_icons) — agent index

Nested submodule of **ixm_blocks**. Row of **icon-and-label calls to action**.
Version **1.1.3**. Core `^10 || ^11`.

**Icons carry meaning here, so the accessibility bar is higher.** Decorative icons beside
equivalent text should be hidden from assistive technology; where the icon **is** the distinction
between one CTA and the next, the link needs an accessible name that conveys it. *A row of links
all announced as "Learn more" is the common failure.*

Decide whether the whole tile or only the label is the link — the tile is a better touch target,
but only if its accessible name is the label rather than everything inside it.