<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# auctioneer

Auctions + bidding platform with pluggable handlers/conditions.

- Config entities `auction_type`, `bid_type`; plugin managers for auction_type/handler/condition (`auctioneer.services.yml`).
- Admin under `/admin/structure/auctioneer` (`administer site configuration`); perms `administer auction_type`, `administer bid_type` (restricted) + per-bid-type callback.
- Deps: `views`, contrib `entity`. Drush commands, Views + templates. `Auction` entity uses internal `accessCheck(FALSE)` queries for listings.

See [../usage.md](../usage.md).
