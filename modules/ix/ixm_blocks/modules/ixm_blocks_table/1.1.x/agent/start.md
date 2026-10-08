<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Table (ixm_blocks_table) — agent index

Nested submodule of **ixm_blocks**. Tabular data as a block.
Version **1.1.3**. Core `^10 || ^11`.

**Two things determine usability:**

1. **Real table markup with proper headers** — `<th>` with the right `scope`, plus a caption or
   accessible name. That is what lets a screen reader announce "Price, £40" instead of a stream of
   numbers. A div grid is unlabelled values.
2. **The responsive strategy is a design decision with no universally right answer** — horizontal
   scroll keeps structure and hides columns; stacking each row keeps everything visible and loses
   comparison, which is usually the point of a table. Know which the component does.