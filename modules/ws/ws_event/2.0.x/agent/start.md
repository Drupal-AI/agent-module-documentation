<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Website Services Event (ws_event) — agent index

Event content type + Layout Builder integration for YMCA Website Services.
Version **2.0.1**. Core **`^11`**. Requires **`ycloudyusa/y_lb ^4.0 || ^5.0`** and
`layout_builder_restrictions`.

Tension worth naming: **structured event data** makes listings and calendars work; a **freely
composed page** makes an individual event compelling. Be clear which fields are authoritative — a
date typed into a text block is invisible to the calendar that should show it.

**Unlike its siblings this module constrains `y_lb`**, so it failed at **composer** time with a
resolvable explanation rather than at enable time with a confusing one. Packagist publishes only
`y_lb` 0.1, so the constraint cannot be satisfied without the YMCA repository. **The stricter module
gave the better error** — worth remembering when writing constraints.