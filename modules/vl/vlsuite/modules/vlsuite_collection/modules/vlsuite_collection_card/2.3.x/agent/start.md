<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# VLSuite Collection: Card (vlsuite_collection_card) — agent index

Nested submodule of **vlsuite_collection**. **Card grid** component.
Version **2.3.3**. Core `^10.3 || ^11`.

Settles the questions otherwise decided per page: cards per row at each breakpoint, odd-number
behaviour, whether the whole card or only the heading is the link.

**The accessibility mistake card grids make most:** if the whole card is clickable, the link's
accessible name must be the **heading**, not the card's whole text — otherwise a screen reader
announces a paragraph as a link name. And a second link nested inside a clickable card is invalid
markup with unpredictable behaviour.