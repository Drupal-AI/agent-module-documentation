# Commerce Price formatter — manual setup guide

**Commerce Price formatter** (`commerce_price_formatter`) renders a product's
price **with its promotions applied**, so a discounted item can show both the
original ("was") price and the reduced ("now") price, along with the percentage
saving — cleanly, without cluttering the display.

The problem it solves is a real commercial gap. Commerce correctly resolves
promotions at the *order* level (a promotion can depend on the cart, the customer,
the quantity, or the date), which means a product listing showing the plain price
is telling the truth about the product but the wrong thing about what the customer
will actually pay. "£40, was £50" is one of the most persuasive pieces of
information on a listing page — a shop showing £40 with no reference price has
effectively spent the discount without getting the benefit. This module closes
that gap by formatting the calculated, promoted price at display time.

It does **not** create a brand-new formatter type; it enhances the **Calculated
(Format)** price formatter with a "was / now / % off" presentation. It depends on
**Commerce**, **Commerce Product**, and **Commerce Promotion**, and supports
Drupal 9, 10, and 11. There is no central settings form — you turn it on where it
matters, in a product variation type's display settings (see "How to use it").

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no central settings
form. You enable the discount formatting on a price field's display, described in
"How to use it" below.

## Where it lives in the admin menu

Commerce Price formatter adds no admin page of its own. You use it from
**Administration → Commerce → Configuration → Product variation types → (your
type) → Manage display** (`/admin/commerce/config/product-variation-types`), where
you configure the price field's formatter.

## How to use it

1. Go to **Commerce → Configuration → Product variation types**, pick the relevant
   variation type, and open its **Display** (Manage display) tab.
2. For the **price** field, set the format to **Calculated (Format)**.
3. In that formatter's settings, tick **Enable Discount Format to Calculated
   Price**.
4. Save, then view a product page to confirm the original price, discounted price,
   and discount percentage now appear.

> **Tip:** After changing any promotion or related pricing configuration, clear
> the cache so the new prices are reflected on the frontend.

> **Important — reference-price claims are regulated.** In many markets (including
> the UK and EU) a struck-through "was" price must reflect a price that was
> genuinely charged for a defined period. A strikethrough figure is a claim your
> business must be able to justify — treat it as a compliance matter, not just a
> display choice. Also remember that promoted prices vary by context (customer,
> quantity, date, store), so this output is not a single shared cacheable value.
