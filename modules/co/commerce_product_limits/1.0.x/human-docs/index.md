# Commerce Product Limits — manual setup guide

**Commerce Product Limits** (`commerce_product_limits`) adds per-variation
**minimum**, **maximum**, and **step** order-quantity limits to Drupal Commerce.
With it you can require customers to buy at least a certain number of a product,
cap how many they can buy in one order, or sell an item only in fixed multiples
(for example packs of six). It is handy for wholesale minimums, protecting scarce
stock, and B2B "minimum order" style rules.

Limits are set per product variation, so different sizes or colors within the same
product can have different rules. The module enforces them in two ways. On the
server, an availability checker plugs into Commerce's normal availability system
and rejects any add-to-cart or cart update that would fall below the minimum or
above the maximum — counting anything already in the cart — showing a clear message
such as "You must order at least 2…" or "You cannot order more than 4…". On the
front end, it also sets the HTML min, max, and step attributes on the quantity
fields (and pre-fills the add-to-cart quantity to the minimum) so shoppers see the
limits right away.

You turn each limit on by enabling a small "trait" on a product variation **type**,
which adds a matching field to that type. You then fill in a value on individual
variations; leaving a value empty means "no limit" for that variation. There is no
central settings page — configuration is done on the variation types and
variations themselves.

> **Compatibility note:** this module is **not compatible with Commerce Cart
> Flyout**, because it modifies the core shopping-cart form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable the traits on a variation type
   and set the limit values on variations.

## Where it lives in the admin menu

There is no dedicated settings page. You enable the limit traits on a product
variation type at **Commerce → Configuration → Product variation types**
(`/admin/commerce/config/product-variation-types`), then set the values when
editing individual product variations.

## How to use it

In short: edit the product variation type you want limits on and tick the
**Minimum**, **Maximum**, and/or **Step** quantity traits. That adds the
corresponding fields to that type. Then edit a product's variations and fill in the
minimum, maximum, or step you want. See [Configuration](configuration/index.md) for
the step-by-step.
