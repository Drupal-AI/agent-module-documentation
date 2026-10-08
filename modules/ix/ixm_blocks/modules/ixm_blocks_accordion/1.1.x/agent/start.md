<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IXM Blocks: Accordion (ixm_blocks_accordion) — agent index

Nested submodule of **ixm_blocks**. Collapsible panels — the FAQ pattern.
Version **1.1.3**. Core `^10 || ^11`.

Suits **independent** items (FAQs, policy sections); suits narrative badly, because collapsing
prose hides the thread.

**Accessibility requirements, specific and frequently missed:** headers must be real **buttons**,
not styled divs; `aria-expanded` reflecting state; `aria-controls` pointing at the panel; keyboard
operable; content reachable without JS. A click-only accordion is content a keyboard user cannot
open.

Decide whether the first panel starts open — everything closed hides content from scanners and from
search snippets.