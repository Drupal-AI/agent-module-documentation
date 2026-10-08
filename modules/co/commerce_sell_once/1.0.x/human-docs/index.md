# Commerce Sell Once — manual setup guide

**Commerce Sell Once** (`commerce_sell_once`) is a **Commerce Stock service** that
caps a product to a **single sale**. Once its one unit is sold, the product
becomes unavailable — no further orders can be placed for it. It is built for
genuinely unique items: one-off artworks, a single event ticket, a
one-of-a-kind piece of inventory, anything where the stock is strictly one and
overselling must be impossible.

It plugs into the **Commerce Stock** framework and does its work through that
framework's stock checks — there is nothing bespoke happening at checkout beyond
Commerce Stock deciding the product is no longer available. The module depends on
`commerce_stock` and supports **Drupal 10.2+ and 11**. It has no permission,
configuration form, or admin settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   select it as the stock service.

There is **no configuration page** for this module. Once it is enabled and chosen
as the stock service (see below), the single-sale rule applies automatically.

## Where it lives in the admin menu

Commerce Sell Once adds no settings page of its own. It becomes available as a
**stock service** within Commerce Stock's configuration
(**Administration → Commerce → Configuration → Stock**). Which stock service
applies is a Commerce Stock setting; select the Sell Once service there for the
store or product types that should be limited to a single sale.

## How to use it

1. Enable **Commerce Stock** and this module.
2. In Commerce Stock's configuration, set the **stock service** to the Sell Once
   service for the relevant store or product type.
3. From then on, each product governed by that service can be purchased only
   once — after the sale it drops out of availability, preventing any oversell of
   your unique items.
