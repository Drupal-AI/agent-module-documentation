# Commerce Combine Carts — manual setup guide

**Commerce Combine Carts** (`commerce_combine_carts`) makes sure a Drupal Commerce
customer only ever has a **single active cart per order type**. When a shopper ends up
with more than one cart — the classic case being an anonymous cart from before they
logged in, plus an existing cart on their account — this module automatically merges
them into one.

It solves a common source of confusion and lost sales: a visitor adds items to a cart
while logged out, then signs in, and their earlier items seem to vanish because they're
in a different cart. With this module enabled, those carts are combined so everything
the shopper added ends up in one place, ready for a single checkout.

The best part is there's nothing to set up. The module has **no configuration, no
settings page, no permissions, and no Drush commands** — enable it and it just works. It
reacts to two moments: when a user logs in, and when a cart is assigned to a customer.
In both cases it consolidates that customer's carts, merging like items together
(respecting your product variations' "combine" display setting so identical items stack
instead of duplicating), all inside a safe database transaction. If the customer is in
the middle of checking out a cart, that cart is kept as the surviving one so their
checkout isn't disrupted.

This guide is written for a **human**. If you want terse, token-cheap references for an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

Nowhere — the module adds no admin pages, settings, or menu items. Its behaviour is
entirely automatic once enabled.

## How to use it

There is nothing to configure. Once you install and enable the module (see
[Installation](installation/index.md)), cart merging happens automatically:

- **On login** — all of the logging-in user's carts are consolidated, and the emptied
  leftover carts are deleted.
- **On order assignment** — when a cart is assigned to a customer (for example an
  anonymous session cart being adopted at login), it is merged into that customer's
  main cart, and the emptied cart is saved.

Merging is done **per order type**, so if your store uses several order types, the
customer keeps one main cart for each type — quote or marketing carts of a different
type are not accidentally merged into the shopping cart. Developers who need to trigger
a merge from custom login or order-assignment flows can call the
`commerce_combine_carts.cart_unifier` service directly (`CartUnifier::combineUserCarts()`
and related methods).
