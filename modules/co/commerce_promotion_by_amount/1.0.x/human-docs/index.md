# Commerce Promotion by amount — manual setup guide

**Commerce Promotion by amount** (`commerce_promotion_by_amount`) adds two new
Commerce promotion *offers* that discount only a **single** product in the order —
either the single cheapest or the single most expensive matching item — instead of
every matching line at once. Plain Commerce offers apply to all matching items, so
they cannot express deals like "your cheapest product is half price" or "money off
your most expensive item." This module fills that gap.

Under the hood it ships two offer plugins: a **fixed amount off** offer and a
**percentage off** offer. Each one sorts the qualifying items in the cart, picks the
first one (cheapest or most expensive, depending on how you set it), and discounts
only that item — carefully clamping the discount so the item total never drops below
zero. That single-item targeting is what makes it the standard building block for
"buy one get one free," "cheapest item free," and "20% off your priciest product"
style campaigns.

There is nothing to configure globally — the module has no settings form of its own.
You use it entirely through Commerce's normal Promotions screen: create a promotion,
choose one of the two new offers, and set a few options. It requires Commerce (and
its Promotion submodule), which you almost certainly already run if you are reading
this.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how to build a promotion that uses one
   of the two offers, option by option.

## Where it lives in the admin menu

The module adds no admin page of its own. Its two offers appear inside the standard
promotion form at **Commerce → Promotions → Add promotion**
(`/promotion/add`), in the **Offer** selector. Manage existing promotions at
**Commerce → Promotions** (`/promotion`).

## How to use it

1. Go to **Commerce → Promotions → Add promotion**.
2. Fill in the usual promotion fields (name, store, dates, and so on).
3. Under **Offer**, choose **Fixed amount off for cheapest or most expensive
   matching product** or **Percentage off for cheapest or most expensive matching
   product**.
4. Enter the amount or percentage, then pick the cheapest-vs-most-expensive,
   ranking, and scope options (see [Configuration](configuration/index.md)).
5. Optionally add **Conditions** so only certain products count as candidates.
6. Save. The discount now lands on exactly one line item in qualifying carts.
