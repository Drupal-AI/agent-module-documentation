# Commerce Wishlist — manual setup guide

**Commerce Wishlist** (`commerce_wishlist`) gives Drupal Commerce stores a
save-for-later / favorites feature. It adds an **"Add to wishlist"** button
alongside the usual "Add to cart" button, gives every customer a wishlist page
at `/wishlist`, and lets shoppers move items back and forth between their cart
and their list. Anonymous visitors can build a wishlist that follows their
session, and when they log in that guest list is automatically claimed and
merged into their account.

Out of the box each customer has a single default wishlist, but you can turn on
multiple named lists per person (for example "Birthday" and "Home"), let people
email a copy of a list to friends, and define your own wishlist *types* with
their own fields — handy for gift-registry-style lists. A **Wishlist block**
shows an item count in your header, with an optional drop-down of the list's
contents.

Because it is built on Drupal Commerce, it reuses the platform you already have:
it needs Commerce, the Cart, Store, Inline Entity Form and Profile modules, and
it plugs "Move to cart", "Move to wishlist", "Edit quantity" and "Remove"
actions into Views so you can build custom reports and displays.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the Commerce modules it needs,
   installing with Composer, and enabling it.
2. [Configuration](configuration/index.md) — the global settings form, wishlist
   types, the "Add to wishlist" button, the block, and permissions.

## Where it lives in the admin menu

Once enabled, the module adds two admin pages under Commerce:

- **Global settings** — **Commerce → Configuration → Wishlist settings**
  (`/admin/commerce/config/wishlist-settings`): whether people can have multiple
  lists, anonymous sharing, and the default wishlist type.
- **Wishlist types** — **Commerce → Configuration → Wishlists**
  (`/admin/commerce/config/wishlists`): manage the wishlist bundle(s) and their
  fields.

The customer-facing wishlist lives at `/wishlist` (and `/user/{user}/wishlist`),
and the Wishlist block is placed from **Structure → Block layout** like any
other block.
