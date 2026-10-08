# Commerce Product Alternative — manual setup guide

**Commerce Product Alternative** (`commerce_product_alternative`) lets shoppers
swap a product variation **already in their cart** for an admin-designated
alternative — **without removing and re-adding items**. Store managers define
which variations count as valid alternatives for each other, then expose "swap"
links in a cart view; clicking a link opens a confirmation modal (showing the
current and new price) and replaces the underlying order item in place —
preserving quantity — so the shopper keeps their spot in checkout.

The problem it solves shows up whenever you sell products with meaningfully
different variations — formats, bundles, sizes, or configurations — and want a
customer to change their mind about which one they're buying without the friction
of deleting the line and starting over. Under the hood it adds a Commerce
**entity trait** to variation types plus an AJAX switch flow and a dedicated Views
field for the swap links.

It depends on Commerce's **Commerce**, **Product**, **Order**, **Cart**, and
**Log** modules and requires **Drupal 11**. It has no central settings form and
no role permissions — a shopper may only switch their own cart's items to a
published, available alternative you have configured. Setup is done on the
variation type, on individual variations, and in your cart View (see "How to use
it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — setup happens on your
variation type, your variations, and your cart View, described in "How to use it"
below.

## Where it lives in the admin menu

Commerce Product Alternative adds no settings page. You use it from **Commerce →
Configuration → Product variation types** (to enable its trait and assign
alternatives) and from your cart **View** (to add the swap-links field).

## How to use it

1. Go to **Commerce → Configuration → Product variation types**, edit the relevant
   variation type, and enable the **Alternative Variations** trait.
2. Edit the individual product variations and assign which other variations are
   valid **alternatives** for each one.
3. Open your **cart View** and add the **Alternative variations** field from the
   order-item fields.
4. On the storefront, shoppers now see swap links in the cart and can switch
   between the alternatives via AJAX — no full page reload, no manual
   remove/re-add.

There are no module permissions to grant: a shopper can only switch their own
draft cart's items, and only to a published, available alternative you
configured on the source variation. Configuring alternatives is done by users
who can already edit product variations.
