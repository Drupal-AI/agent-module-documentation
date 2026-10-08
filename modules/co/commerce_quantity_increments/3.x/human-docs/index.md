# Commerce Quantity Increments — manual setup guide

**Commerce Quantity Increments** (`commerce_quantity_increments`) is a small
module on top of Drupal Commerce that lets you **set and validate quantity
increments and minimums on a per-product-variation basis**. Some products only
sell sensibly in packs or multiples — a case of 6, a minimum order of 10 — and
this module enforces exactly that, validating the quantity in the cart.

The problem it solves is that Commerce, by default, lets a customer buy any whole
quantity. If a product must be sold in multiples of six, or never below ten, you
need something to hold that rule and reject anything that breaks it. This module
adds that per-variation, checking the quantity at add-to-cart. It depends strictly
on Commerce **Product** (`commerce_product`), with a soft relationship to
Commerce **Cart**, and this project is **covered by Drupal's security advisory
policy**.

There is no unusual security surface here — it's a validation feature. The main
thing to get right is that the increment and minimum rules actually match how the
products are sold, so confirm those on real products before relying on them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce.

This module has no dedicated settings page; you set the increment and minimum
values on each product variation, described below.

## Where it lives in the admin menu

Commerce Quantity Increments adds no central admin page. The increment and minimum
values are configured **per product variation**, so you set them where you edit
your product variations (via the fields the module adds to the variation).

## How to use it

1. Enable the module (see Installation).
2. Edit a product variation and set its **quantity increment** (the step size, for
   example 6) and/or its **minimum quantity** (for example 10).
3. Add the product to the cart and confirm that quantities which break the rule are
   rejected, and that valid multiples are accepted.
4. Repeat for each variation that needs a rule; variations without a rule behave as
   normal.
