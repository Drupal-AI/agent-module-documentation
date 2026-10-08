# Commerce Promotion Giveaway — manual setup guide

**Commerce Promotion Giveaway** (`commerce_promotion_giveaway`) adds a new
promotion **offer type** to Drupal Commerce: a "giveaway" that automatically adds
a configured product variation to a qualifying order — either completely free, or
at list price with the price subtracted as a visible order adjustment. It is the
building block for "buy X, get a free item", gift-with-purchase, and free-sample
campaigns.

The problem it solves is that Commerce's built-in promotion offers discount what
is already in the cart; they don't *add* a product. This module fills that gap
with an offer plugin called **Giveaway** that you attach to a normal Commerce
Promotion. When the promotion's conditions match, the giveaway item is added
once; if the order later stops qualifying, the item is removed again
automatically. It depends on `commerce` and `commerce_promotion`, and this project
is **covered by Drupal's security advisory policy**.

There is nothing to switch on beyond enabling the module — the feature appears as
an offer option when you create or edit a promotion. Reassuringly for a "free
stuff" feature, the giveaway product and quantity are fixed by the promotion's
admin configuration, applied server-side inside Commerce's promotion engine; a
customer cannot pick the item, change the quantity, or stack it beyond the
promotion's own usage limits through any request they control. The enforcement
point is the promotion's conditions, coupons, and usage limits — set them
deliberately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Promotion.
2. [Configuration](configuration/index.md) — create a promotion that uses the
   Giveaway offer, field by field.

## Where it lives in the admin menu

The module adds no page of its own. You use it when creating a promotion at
**Commerce → Promotions → Add promotion** (`/promotion/add`) by choosing the
**Giveaway** offer type. See [Configuration](configuration/index.md).
