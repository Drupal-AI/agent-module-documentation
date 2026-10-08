# Commerce Tax Washington — manual setup guide

**Commerce Tax Washington** (`commerce_tax_wa`) calculates **Washington State
(US) sales tax** for Drupal Commerce. Washington uses *destination‑based*
sourcing — the seller charges tax based on where the product is delivered, not
where the store is — and there are hundreds of possible local rates, so a simple
flat sales‑tax setup in Commerce won't work. This module solves that by looking up
the correct rate for each order's address.

Tax is calculated from the purchaser's **shipping address** (or billing address
for non‑shippable products), and the rate is fetched by an address lookup on the
**Washington State Department of Revenue's public web service**, so it always uses
the most current rate. The module provides both a tax resolver and a **tax type**
you add through Commerce. The tax type can be limited to specific taxable product
variations (so you can mix taxable and non‑taxable variations) and to specific
stores.

It depends on Drupal Commerce with the **Commerce Tax** submodule
(`commerce_tax`). Tax is applied server‑side through Commerce Tax, which is the
authoritative calculation — the module has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce Tax.
2. [Configuration](configuration/index.md) — add and configure the Washington
   State tax type, field by field.

## Where it lives in the admin menu

You configure this module by adding a **tax type** at **Commerce → Configuration
→ Tax types** (`/admin/commerce/config/tax-types`) and choosing **Washington
State tax service**. See [Configuration](configuration/index.md) for the details.
