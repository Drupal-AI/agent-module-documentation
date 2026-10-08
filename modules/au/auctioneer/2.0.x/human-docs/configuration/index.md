# Configuration

Auctioneer is configured under **Structure → Auctioneer**
(`/admin/structure/auctioneer`, route `auctioneer.configuration`), reachable by
users with *administer site configuration*. Setting it up is mostly about defining
your **auction** and **bid** types and attaching the **handlers** and **conditions**
that give bidding its behaviour.

## Define auction and bid types

Auctioneer stores its structure as two configuration entity types:

- **Auction types** (`auction_type`) — each type describes a category of auction and
  has its own field management, so you can define what data an auction of that type
  carries and how it behaves.
- **Bid types** (`bid_type`) — each type describes a kind of bid, again with its own
  fields.

Use the auction‑type and bid‑type forms to add fields and set behaviour per
category.

## Attach handlers and conditions

The bidding logic is event‑driven:

- **Handlers** run when an auction's configured conditions are met — they are how
  you express business rules (what should happen at a given auction event).
- **Conditions** are attached to handlers to decide when they fire.

Manage these for an auction type under its handlers screen (for example
`/admin/structure/auctioneer/auction_type/{type}/handlers/...`). Bids are stored as
entities and evaluated against the conditions you configure.

Developers can extend the system with custom **handler** and **condition** plugins
(managed by the module's `plugin.manager.auctioneer.*` managers) for bespoke bidding
logic.

## Surface auctions with Views

Auctioneer ships Views integration, templates, and CSS. Build a View to list active
or related auctions and present them to visitors — this is the normal way to turn a
timed auction into a page people can browse and bid on.

## Permissions

- **Administer auction_type** and **Administer bid_type** — both are *restricted*
  permissions; grant them only to fully trusted roles.
- Additional **per‑bid‑type permissions** are provided via a callback, so you can
  control who may act on each kind of bid.

Assign these at **People → Permissions** with care, since they govern who can change
auction structure and place/administer bids.

## Maintenance

Auctioneer provides **Drush commands** for auction maintenance tasks, and its
post‑update hooks handle schema/config upgrades when you update the module.
