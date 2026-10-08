# Auctioneer — manual setup guide

**Auctioneer** (`auctioneer`) is a configurable auctions and bidding system for
Drupal. It provides **auction** and **bid** entity types, lets you define your own
auction and bid *types* with their own fields, and drives bidding behaviour through
pluggable **handlers** and **conditions** that fire when auction events occur. It
ships Views integration so you can surface auctions as listings.

Rather than being a one‑size‑fits‑all auction feature, Auctioneer is built to be
shaped: you create `auction_type` and `bid_type` configuration entities, manage
their fields per type, and attach handlers (with conditions) that run when an
auction meets a configured state — event‑driven business rules for your bidding
logic. Bids are stored as entities and evaluated against the conditions you set up.
It also provides Drush commands for auction maintenance tasks. It depends on core
**System** (8.8.8+), core **Views**, and the contrib **Entity** module, and supports
Drupal 8.8.8+, 9, and 10.

Type administration is deliberately restricted: the `administer auction_type` and
`administer bid_type` permissions are marked restricted, and there are per‑bid‑type
permissions as well — keep these with trusted roles.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies
   with Composer, then enable it.
2. [Configuration](configuration/index.md) — define auction and bid types, attach
   handlers and conditions, and surface auctions through Views.

## Where it lives in the admin menu

Auctioneer's administration lives under **Structure → Auctioneer**
(`/admin/structure/auctioneer`), gated by *administer site configuration*. From
there you manage auction and bid types and their handlers.

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. Define your auction and bid types and attach handler/condition logic (see
   [Configuration](configuration/index.md)).
3. Build Views listings to present active auctions to visitors, and let bids flow
   through the entity/condition machinery you configured.
