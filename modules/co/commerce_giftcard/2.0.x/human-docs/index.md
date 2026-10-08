# Commerce Gift Card — manual setup guide

**Commerce Gift Card** (`commerce_giftcard`) adds a complete gift-card system to
Drupal Commerce. You can define gift-card types, issue or bulk-generate coded cards
that each carry a monetary balance, sell them as products, and let customers redeem
a code at checkout to knock money off their order total.

The building blocks are three entities. A **gift-card type** is a configurable
"bundle" — its main setting is the length of the codes generated for it, and it has
both an admin label and a customer-facing display label. A **gift card** is an
individual card with a unique code, a balance (a Commerce price), an owner, an
enabled/disabled status, and an optional restriction to specific stores. Every change
to a card's balance is recorded as a **transaction**, giving you a full audit trail
with comments — so top-ups, spends and refunds are all traceable.

Redemption happens at checkout through a dedicated **checkout pane**: the customer
types in a gift-card code, and a low-priority order processor applies the gift-card
amount as an *adjustment* — deliberately last in the pricing pipeline, so the card
discounts the fully-adjusted total. Cards can be applied across multiple orders until
exhausted, and part of an order can be refunded back onto a card from the order's
admin page. You can also **sell** gift cards: enable the gift-card purchase trait on a
product variation type so that buying the product issues or tops up a real card. A
bulk **Generate gift cards** form produces batches of guaranteed-unique codes for
promotions or launches, and a set of granular permissions controls who can create,
view, generate and administer cards.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer alongside
   Drupal Commerce, and enable it.
2. [Configuration](configuration/index.md) — create gift-card types, issue and
   generate cards, set up checkout redemption, sell cards, and grant permissions.

## Where it lives in the admin menu

- **Gift-card types:** **Commerce → Configuration → Gift card types**
  (`/admin/commerce/config/giftcard_types`).
- **Gift cards & transactions:** **Commerce → Gift cards**
  (`/admin/commerce/giftcards`), with a **Generate gift cards** form at
  `/admin/commerce/giftcards/generate`.
- **Redemption:** added as a pane to your checkout flow under **Commerce →
  Configuration → Checkout flows**.
