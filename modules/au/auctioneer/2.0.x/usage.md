<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: an auctions platform providing auction and bid content entities plus pluggable handlers/conditions that fire on auction events.
- When: you need on-site auctions with configurable bid types, business rules, and Views-based listings.

---

- Enable the module (depends on `views` and the contrib `entity` module; core `system` >= 8.8.8).
- Configure auction/bid types under `/admin/structure/auctioneer` (route `auctioneer.configuration`, `administer site configuration`).

---

- Defines `auction_type` and `bid_type` config entity types with per-type field management.
- Permissions include `administer auction_type`, `administer bid_type` (both restricted), plus per-bid-type permissions via a callback.
- Plugin managers: auction type, handler, and condition plugin managers (`plugin.manager.auctioneer.*`).
- Handlers run when auction conditions are met (event-driven business rules), each with attachable conditions.
- The `Auction` entity queries active/related auctions with `accessCheck(FALSE)` for internal listing logic.
- Provides Drush commands (`drush.services.yml`) for auction maintenance tasks.
- Ships Views integration, templates, CSS, and action/task/menu local links.
- Use auction-type forms to define fields and behavior per auction category.
- Attach handler conditions at `/admin/structure/auctioneer/auction_type/{entity}/handlers/...`.
- Bids are stored as entities and evaluated against configured conditions.
- The path field on an auction respects `access('edit')` for URL alias editing.
- Extend with custom handler/condition plugins for bespoke bidding logic.
- Restricted permissions keep type administration to trusted roles.
- Model timed auctions, then surface them through Views listings.
- Post-update hooks (`auctioneer.post_update.php`) handle schema/config upgrades.
- Version 2.0.x supports Drupal 8.8.8+/9/10.
