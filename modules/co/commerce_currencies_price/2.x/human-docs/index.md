# Commerce Currencies Price — manual setup guide

**Commerce Currencies Price** (`commerce_currencies_price`) provides a Commerce
price **field type** that stores a separate price for **every enabled currency**
inside one field — instead of making you create a separate price field per
currency.

The problem it solves is manual multi‑currency pricing. Automatic currency
conversion does not always give you the prices you want: you may prefer round
numbers, or market‑specific pricing that does not track exchange rates. This field
lets a product hold a hand‑set price in each currency, all in a single field whose
values are stored serialized.

It is a pricing/data feature with no payment role and no unusual security surface.
The one thing to watch is completeness: **a currency with no price set has no
price in that market**, so confirm every enabled currency has a value. The field
has no cardinality limit, and developers can read the values in code via
`$entity->field_name->prices`.

It depends on **Drupal Commerce** (`commerce`) and **Commerce Price**
(`commerce_price`) and supports Drupal 10.3 and 11. (For Drupal 9, use the 2.0
release: `drupal/commerce_currencies_price:2.0`.) A future release is planned to
integrate with `commerce_currency_resolver` for multi‑currency resolution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
use it by adding its field to an entity, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You add its field on any fieldable entity's
**Manage fields** screen — for a product variation, that is **Commerce →
Configuration → Product variation types → *(type)* → Manage fields**.

## How to use it

1. Go to the **Manage fields** screen of the entity that should carry per‑currency
   prices (typically a product variation type).
2. Add a new field and choose the **Commerce Currencies Price** field type.
3. On the entity's edit form you can now enter a price for each **enabled
   currency**. Set a value for every currency you sell in — a missing currency
   price means the product has no price in that market.
4. Save.

> **Tip:** which currencies appear depends on which currencies you have enabled in
> Commerce (**Commerce → Configuration → Currencies**). Enable the currencies you
> need first, then fill in their prices.
