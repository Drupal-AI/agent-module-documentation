<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Tabs (ixm_blocks_tabs) — agent index

Nested submodule of **ixm_blocks**. Several panels, one visible at a time.
Version **1.1.3**. Core `^10 || ^11`.

**State the trade:** tabs hide content. Past the first tab it is unseen by most visitors and
historically weighted less by search engines. The pattern is for **alternatives**, not for fitting
more in.

**Verify the ARIA tab pattern** — arrow keys between tabs, Tab into the panel, `aria-selected` on
the active tab, panels associated with their tabs. This is among the patterns most often shipped as
styled divs with a click handler, which is not accessible.