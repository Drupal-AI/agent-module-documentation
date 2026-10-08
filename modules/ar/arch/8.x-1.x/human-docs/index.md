# Arch dashboard — manual setup guide

**Arch dashboard** (`arch`) is the store‑management dashboard for **Arch**, a
Drupal‑native e‑commerce platform. Where Arch itself provides the underlying
commerce building blocks, this module gives store operators a place to manage the
storefront — bringing together management views for **products** and **orders** so
the day‑to‑day running of the shop happens from one dashboard.

Arch is built out of several cooperating modules. This dashboard depends on the
core **Entity** module and on Arch's own **Arch Product** (`arch_product`) and
**Arch Order** (`arch_order`) modules, which supply the product and order entities
the dashboard displays. In other words, you install this module as part of the
wider Arch commerce suite rather than on its own — it is the operator‑facing front
end for functionality those companion modules provide.

Access to the dashboard is gated by the **Administer store** permission, so only
trusted store operators can manage products and orders. The module supports
Drupal 9.4, 10, and 11. Note that this is an **alpha release**
(8.x‑1.0‑alpha26) — treat it as early‑stage software and test thoroughly before
relying on it for a live shop.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside its Arch companion modules, and grant the store permission.

## Where it lives in the admin menu

Once enabled, the dashboard is available to users with the **Administer store**
permission, giving them the management views for products (from `arch_product`)
and orders (from `arch_order`). Because Arch is a suite, the exact set of screens
you see depends on which Arch modules you have enabled. Grant **Administer store**
(**People → Permissions**) only to the roles that should run the shop.
