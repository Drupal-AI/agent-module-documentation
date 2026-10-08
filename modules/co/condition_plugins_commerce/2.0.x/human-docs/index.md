# Condition Plugins Commerce — manual setup guide

**Condition Plugins Commerce** (`condition_plugins_commerce`) is the Drupal
Commerce companion to the *Condition Plugins* collection. It adds a set of
condition plugins that inspect a **Commerce order**, so you can make decisions —
show a block, grant access, apply a business rule — based on the order in
context. It works anywhere Drupal's condition system is evaluated.

The conditions it provides include:

- **Order type** — the order's bundle (e.g. "default", "subscription").
- **Order has payment gateway** — the payment gateway attached to the order.
- **Order has product variation** — whether the order contains a given product
  variation.
- **Order has base field value** — whether an order base field holds a specific
  value.
- **Order has product variation with base field value** — a combination of the
  two above.

To make these work on order pages, the module also ships an **order route
context provider** (which supplies the current `commerce_order` as context on
order routes) and a matching **cache context**, so conditioned output caches
correctly per order.

This is a *pure plugin/library module* — it has no settings page, adds no admin
menu items, and defines no permissions of its own. It requires the **Commerce
Order** module (part of Drupal Commerce). You never configure the module itself;
you select its conditions from a host UI such as block visibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Commerce Order dependency, and enable the module.

There is **no configuration page** for this module. You use its conditions from a
condition-aware host UI (for example a block's **Visibility** settings) on
Commerce order routes.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Place or edit a block via **Structure → Block layout**, or use any other
   feature that evaluates Drupal conditions on a Commerce order route.
3. In the **Visibility** settings you will find the new order conditions listed
   above. Configure the one you need (choose an order type, a payment gateway, a
   product variation, or a base-field value) and save.
