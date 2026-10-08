<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stand with Ukraine (stand_with_ukraine) — agent index
**A block that displays a #StandWithUkraine banner linking to war.ukraine.ua.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 · **Package:** Content
- **Block plugin:** `stand_with_ukraine_block` (`StandWithUkraine::build`) — static markup overlay
- **Libraries:** `stand_with_ukraine.libraries.yml` (css/js)
- No routes, permissions, or services of its own.

**Security:** Static markup block gated by the standard `access content` permission; no forms, no external data fetch, no mutating endpoints.
