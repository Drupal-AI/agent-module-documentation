# Auctions — manual setup guide

**Auctions** (`auctions`) adds auction functionality to Drupal **nodes**: content
becomes an auctionable item that users can bid on, with a bidding workflow. It is
built as a small family of modules — a core submodule plus optional Commerce and
mail integrations — so you enable only the pieces you need. It suits sites running
auctions, such as charity auctions or marketplaces. This version targets Drupal 11.

The module is organised into submodules:

- **Auctions Core** (`auctions_core`) — the foundation the main module builds on
  (and its dependency).
- **Auctions Commerce** (`auctions_commerce`) — integrates auctions with Drupal
  Commerce so winning bids can be paid for through a real payment gateway.
- **Auctions Mail** (`auctions_mail`) — sends auction notifications to bidders.

Because bids are **user‑submitted data that affect outcomes and money**, treat the
security of the bidding flow seriously. Make sure bid submission is properly
access‑controlled and validated server‑side, so a user cannot place bids as someone
else or manipulate a bid amount. If you use the Commerce integration, the money is
handled by Commerce — rely on a proper, configured payment gateway. Verify the
bidding access model and, where Commerce is involved, the payment flow, before going
live.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose the submodules you need.

## Where it lives in the admin menu

Auctions works through node content and the submodules you enable rather than a
single settings screen. You configure the auction content type and bidding workflow
where you manage content types and fields, place any auction blocks/views through
the normal layout tools, and configure payment under **Commerce** if you use the
Commerce submodule.

## How to use it

1. Install and enable the module and the submodules you need (see
   [Installation](installation/index.md)).
2. Set up the auction content type and bidding workflow, so nodes can be auctioned
   and users can place bids.
3. If you enabled **Auctions Commerce**, configure a Commerce payment gateway to
   collect payment from winning bidders. If you enabled **Auctions Mail**, confirm
   your site's outbound email is working so bidder notifications are delivered.
4. **Verify the security of bidding before launch:** confirm bid submission is
   access‑controlled and server‑side‑validated, and that the payment flow is handled
   by a properly configured gateway.
