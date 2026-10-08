# Commerce Shipping Order Percentage — manual setup guide

**Commerce Shipping Order Percentage** (`commerce_shipping_order_percentage`)
adds a Drupal Commerce shipping method that charges shipping as a **percentage of
the order subtotal**, with optional **minimum** and **maximum** limits. Set a
rate of 15% and a 50 order is charged 7.50 for shipping; add a minimum of 10 and
that same order pays 10 instead. It is a clean way to make shipping scale with
cart value rather than weight or a flat fee.

It plugs into Commerce Shipping as a shipping-method plugin
(`percentage_of_order_value`), so it is configured like any other rate. It
depends on **Commerce** — specifically `commerce`, `commerce_order` and
`commerce_price` (plus Commerce Shipping for the shipping framework) — and adds
no permissions, routes or access role of its own. It supports **Drupal 9.5, 10,
and 11**. The rate is computed only when the shipment has a shipping address, is
priced in the current store's default currency, and is rounded with Commerce's
standard rounding.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add a percentage shipping method and
   set the percentage plus optional min/max, field by field.

## Where it lives in the admin menu

You configure it as a shipping method under **Administration → Commerce →
Configuration → Shipping methods** (`/admin/commerce/shipping-methods`): add a
shipping method that uses the **Percentage of Order value** plugin. See
[Configuration](configuration/index.md).
