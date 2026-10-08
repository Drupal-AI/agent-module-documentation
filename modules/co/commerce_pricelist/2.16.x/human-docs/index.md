# Commerce Pricelist — manual setup guide

**Commerce Pricelist** (`commerce_pricelist`) lets a Drupal Commerce store give
the same product *different* prices depending on who is buying, where, when, and
how many. Instead of one fixed price per product variation, you build **price
lists** — named sets of prices with matching conditions — and the module quietly
picks the right one at add‑to‑cart and display time.

A price list can be limited to specific stores, specific customers (individual
users), whole customer roles (for example everyone in a "wholesale" role), and a
start/end date window. Inside each list you add **prices**: one row per product
variation, each with a minimum quantity (so you can offer a cheaper unit price at
quantity ≥ 10), the actual price, and an optional list price (an MSRP / crossed‑out
"was" price). When several lists could apply, each list's **weight** decides which
one wins.

Under the hood the module registers a high‑priority Commerce *price resolver*, so
whenever a matching price list is found it overrides the variation's normal base
price — no theming or custom code required. For bulk work, every price list has
**CSV import and export** forms, so you can load or update thousands of prices from
a spreadsheet. It depends on Drupal Commerce along with its Store and Price
components, and adds a single `administer commerce_pricelist` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce.
2. [Configuration](configuration/index.md) — create and manage price lists and
   their prices, set matching conditions, and import/export via CSV.

## Where it lives in the admin menu

There is no single "settings" form. Everything happens under
**Commerce → Price lists** (`/admin/commerce/price-lists`), where you create price
lists, open each list's **Prices** collection, and reach the add / import / export
forms. The bundle (type) admin lives under
**Commerce → Configuration → Price lists** if you need to manage price‑list types.

## How to use it

The short version: create a price list, give it conditions (store, customers,
roles, dates), then add one or more prices to it — each tied to a product
variation, a minimum quantity, and an amount. Enable the list and it takes over
pricing for the products and shoppers it matches. The full walkthrough is in
[Configuration](configuration/index.md).
