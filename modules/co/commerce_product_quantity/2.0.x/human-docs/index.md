# Commerce Product Quantity — manual setup guide

**Commerce Product Quantity** (`commerce_product_quantity`) lets you set purchase
quantity limits for Commerce products — both for individual products and for whole
product types — so customers cannot order more than you allow. It sets a maximum
per order only (there is no minimum and no step); reach for it when a product is
limited stock or you want to cap how many of something a customer can buy in one
order, for example for fairness during a sale.

You configure it from a small settings area under Commerce: one form for
per-product limits and one for per-product-type limits. When a customer adds an
item to the cart, the module enforces the configured quantity so the order stays
within your rules. When you have set a limit on *both* a specific product and its
product type, the **product-specific limit wins**.

The quantity a customer chooses still flows through Commerce's normal order
handling and access checks — this module simply adds the limit-setting and
validation layer on top. It has no access-control role of its own, needs no API
keys, and (beyond Commerce itself) has no extra dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set per-product and per-product-type
   quantity limits.

## Where it lives in the admin menu

The module's settings sit under **Commerce → Configuration → Product** — one page
for **Product Quantity** (per individual product, at
`/admin/config/system/commerce_product_quantity`) and one for **Product Type
Quantity** (per product type, at
`/admin/config/system/commerce_product_type_quantity`).
