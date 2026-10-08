# Commerce Order Item SKU — manual setup guide

**Commerce Order Item SKU** (`commerce_order_item_sku`) stores each purchased
entity's **SKU** directly on the order item. In stock Drupal Commerce, an order
item references the product *variation* that was bought, and the SKU is read from
that variation on demand. That's fine until the variation's SKU is later edited —
or the variation is deleted — at which point your order history no longer reflects
what was actually sold.

This module fixes that by **persisting the SKU at purchase time**. Once enabled and
switched on for an order item type, the SKU is copied onto the order item and kept
there, so historical orders always show the SKU as it was when the customer bought
it, regardless of what happens to the product afterwards. It's a small
data-integrity feature with no access-control role of its own.

It depends on **Commerce** and **Commerce Order** (`commerce`, `commerce_order`,
3.x or newer). The behavior is opt-in per order item type via a Commerce **trait**,
and there's a short settings form for your preferences — both covered below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — save your preferences on the settings
   form and turn on the SKU-storage trait per order item type.

## Where it lives in the admin menu

The behavior is controlled from two places under Commerce configuration: the
module's **settings form** (where you save your preferences) and the **order item
type** edit screen (**Commerce → Configuration → Order item types**), where you
enable the *"Store purchased entity SKU"* trait for the types you care about.
