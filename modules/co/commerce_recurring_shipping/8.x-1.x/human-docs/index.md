# Commerce Recurring Shipping — manual setup guide

**Commerce Recurring Shipping** (`commerce_recurring_shipping`) is an add-on to the
Commerce Recurring framework that makes **subscriptions shippable** — so each
recurring order can include and charge shipping according to the customer's
shipping preferences. It's the bridge between **Commerce Recurring** and
**Commerce Shipping**.

The problem it solves is that Commerce Recurring, on its own, renews an order but
has no concept of shipping; Commerce Shipping handles shipping on ordinary orders
but doesn't know about subscription renewals. If you sell a physical product on
subscription — a monthly box, a replenished consumable — you need shipping applied
and charged on every renewal, and that's exactly what this module adds. Once you
mark a subscription type as shippable, its subscription bundles gain shipping
fields and all new recurring orders receive shipments and shipping adjustments. It
depends on both **Commerce Recurring** (`commerce_recurring`) and **Commerce
Shipping** (`commerce_shipping`), and this project is **covered by Drupal's
security advisory policy**.

This is not a works-on-enable module: you must tell it which subscription types
should be shippable, and ensure the related order types and product variations are
themselves shippable. See the configuration guide.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Recurring and Shipping.
2. [Configuration](configuration/index.md) — choose which subscription types are
   shippable.

## Where it lives in the admin menu

You enable shipping per subscription type under **Commerce → Subscriptions →
Settings** (the subscription-type settings). It works within Commerce's normal
order and pricing flow and adds no access-control role of its own.
