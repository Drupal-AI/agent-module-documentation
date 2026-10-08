<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tour link block (tour_link_block) — agent index

**Block with a link that starts the core Tour for the current page, shown only where a matching tour exists.**

- **Version:** 2.1.x
- **Core:** ^8 || ^9 || ^10 · **Depends:** block, tour
- **Block plugin:** `TourLinkBlock` (id `tour_link`) — `blockAccess()` requires `access tour` and a `tour` entity matching the current route/params; `build()` renders a `?tour=1` link via the `tour-link` template.

**Security:** access is delegated to core Tour's `access tour` permission; no routes, config, or custom permissions — no additional security surface.
