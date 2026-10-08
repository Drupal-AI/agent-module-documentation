# Commerce Product Variations Table — manual setup guide

**Commerce Product Variations Table** (`commerce_pvt`) displays all of a Commerce
product's variations as a **table**, with a per-row **add-to-cart** control, so a
shopper can add several variations in different quantities at once. It's aimed at
wholesale-style buying, where someone stocking up needs to add many sizes or packs
in a single action rather than clicking through each variation separately.

Each row shows a variation (its attributes and price) with a quantity field. The
module can work as simple quantity fields with one big submit button below, or as
an **enhanced quantity widget** with Plus / Minus buttons that update the cart via
AJAX — optionally debounced, so you can click several times to build a quantity
before the update fires. Pricing and add-to-cart always go through Commerce, so the
server remains authoritative; the module has no access-control role of its own. It
depends on core **Views** plus Commerce **Product**, **Order**, and **Cart**.

> **Important:** this module requires a patch to Drupal Commerce (issue
> [#3017662]) to work — even on a stock site without custom order-type or
> role logic. See [Installation](installation/index.md) for how to apply it with
> `cweagans/composer-patches`. Without the patch the module will not function.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, apply the
   required Commerce patch, and enable the module.

This module has no dedicated settings page, so there is no separate configuration
guide — you set it up on a product's display, described below.

## Where it lives in the admin menu

Commerce Product Variations Table adds no admin page of its own. You enable the
table on a product's **Manage display** and (for the enhanced widget) tune its
behaviour there. The rendering is powered by a **View**.

## How to use it

1. Make sure the required Commerce patch is applied (see Installation).
2. Edit the product type's **Manage display** and enable the **Product Variations
   Table** display component that this module adds. It renders the shipped
   `commerce_pvt_form` View, showing each variation as a table row with a quantity
   field and add-to-cart control.
3. Choose between the **simple** widget (quantity fields with a single submit
   button) and the **enhanced** widget (Plus / Minus buttons with AJAX updates,
   optionally debounced).
4. View a product with several variations and confirm the table renders and that
   adding rows puts the right variations and quantities into the cart.
