# Commerce From Price — manual setup guide

**Commerce From Price** (`commerce_from_price`) adds field formatters that display
the **lowest** price among a product's variations — the "from £30" or "starting
at $300" price you see on product listings. When a product has several variations
at different prices, these formatters show the cheapest one, optionally wrapped in
a prefix or suffix label of your choosing.

It solves a small but common storefront problem: by default a multi-variation
product has no single price to show in a catalog or teaser, so listings look empty
or confusing. This module computes the minimum published-variation price and
renders it, so a "Laptop" product with variations at $300, $500 and $700 can
simply display "Starting at $300". When all variations share one price (or there
is only one), you can choose whether the label still appears.

There is no settings page and nothing to configure globally. Everything happens on
a product type's **Manage display**, where you switch the *Variations* field to
one of the "from" price formatters. The output uses a template you can override in
your theme if you need to. It depends on Drupal Commerce (Product) and runs on
Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set it up on a product type's display, described in "How to use it" below.

## Where it lives in the admin menu

Commerce From Price adds no admin page of its own. You use it from **Structure →
Content types**… actually, for Commerce products, from **Commerce → Configuration
→ Product types → *(your product type)* → Manage display**, where you change the
formatter on the product's *Variations* field.

> **Tip:** Make sure your product listing renders **commerce products** (not
> product *variations*) — the "from" price is a property of the product as a
> whole, so the formatter is applied to the product's variations field.

## How to use it

1. Go to **Commerce → Configuration → Product types**, pick the product type you
   want (for example *Default*), and open **Manage display**.
2. Find the **Variations** field in the list.
3. Change its **Format** to one of the *from* price formatters this module
   provides. They mirror Commerce's own price formatters but show the lowest
   variation price instead of a single variation's price.
4. Click the format's gear/settings icon to add an optional **before** and/or
   **after** label — for example a prefix of "Starting at " — and to choose
   whether to show the label when every variation has the same price.
5. **Save** the display.

Now any place that renders that product's variations field — a catalog View, a
teaser, the product page — shows the "from" price. If you need to change the
markup, the formatter renders through a template you can override in your theme.
