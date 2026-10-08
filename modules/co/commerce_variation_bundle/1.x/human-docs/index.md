# Commerce Variation Bundle — manual setup guide

**Commerce Variation Bundle** (`commerce_variation_bundle`) lets you sell a set of
product variations together as a single **bundle** — a kit or combined package —
in Drupal Commerce. You reference the component product variations and their
quantities, price the bundle as a unit, and (optionally) split it back into its
separate items when an order is placed. It builds on Commerce core's own Product
and Product Variation entities, so there's no parallel product model to learn.

Its main features:

- **Create bundles** by referencing product variations and the desired quantity of
  each.
- **Flexible pricing** — price by percentage, or use the default price field / a
  price‑list module.
- **Split on order** — optionally break a bundle into its separate line items at
  order placement, configurable per referenced variation.
- **Show savings** — display a saving amount or percentage via a new
  `bundle_saving` adjustment type.
- **Stock integration** — with `commerce_stock`, dynamically set a bundle's stock
  based on its contents (the companion *Commerce Variation Bundle Stock* project
  uses the lowest quantity among referenced items).
- **Attributes (experimental)** — an `attributes` submodule
  (`commerce_variation_bundle_attributes`) can use attributes dynamically from the
  referenced bundle items. It is experimental — use at your own risk.

It depends on **Commerce** and **Commerce Product**, and works on Drupal 10.3+ and 11.
It is a product‑modelling feature with no unusual security surface; the main thing
to confirm is that a bundle's **pricing and stock** behave as you intend, since a
bundle's availability depends on its component variations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, if wanted, the experimental attributes submodule).

There is **no standalone settings page** for this module. You turn a product
variation type into a bundle using a variation‑type **trait**, described under
"How to use it" below.

## How to use it — post‑installation setup

1. Go to **Commerce → Configuration → Product types**
   (`/admin/commerce/config/product-types`) and create a new product type and
   product variation type for your bundles. (Using an *existing* variation type as
   a bundle is not recommended.)
2. Go to **Commerce → Configuration → Product variation types**
   (`/admin/commerce/config/product-variation-types`) and edit your new variation
   type.
3. Under **Traits**, select **Variation bundles** and save. The variation type is
   now treated as a bundle, and you'll get a field to reference the bundle items
   (the component variations and their quantities).
4. Create products of this type, reference the component variations with quantities,
   choose your pricing model, and set the split‑on‑order option per variation as
   needed.

## Verify

Create a test bundle, add it to a cart, and confirm the price, any saving
adjustment, and (if you use `commerce_stock`) the stock behavior all match your
intent. Place a test order and confirm the split‑into‑items behavior works as
configured.

> **Known issue:** if you use Commerce core tax, be aware of a reported
> tax‑calculation bug with bundles
> ([issue #3407999](https://www.drupal.org/project/commerce_variation_bundle/issues/3407999)).
> Verify tax on a test order before go‑live.
