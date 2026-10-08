# Commerce Variation Add On — manual setup guide

**Commerce Variation Add On** (`commerce_vado`, "Vado") attaches product
**variations** to other variations as children: you pick a base variation and its
permitted add-ons are offered in the Add to Cart form. Where its sibling
[Commerce Product Add On](../../../commerce_pado/1.4.x/human-docs/index.md) works
at product level, Vado works at variation level — the right granularity when a
specific size or colour has its own compatible extras (a colour-specific accessory,
a subscription tied to one hardware variation).

Each ticked add-on remains an ordinary purchasable variation, so its price, stock
and tax behave normally. On top of that, Vado ships a dedicated **`vado_discount`
adjustment type**, so a bundled add-on can be discounted as a distinct, reportable
adjustment on the order — separate from your promotions. Variations are collected
into reusable **add-on groups**, which is how you define which extras go with which
base variation, and the module exposes add-on data in Views so you can report on
attach rates. It also guards against adding the same add-on twice to one order.

Administration is split by two permissions: **Access vado administration pages** for
the module's admin screens, and the restricted **Administer commerce_vado_group**
for managing the add-on groups. The module requires Commerce's **Cart**,
**Product** and **Price** modules. If you're upgrading from an earlier 2.x version,
run database updates afterwards — the module ships post-update steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add-on groups, the discount adjustment
   type, permissions and Views reporting.

## Where it lives in the admin menu

Vado adds its own administration screens (reached via action links) gated by the
**Access vado administration pages** permission, where add-on groups are managed.
There is no single settings page registered in the module's info file — the admin
surface is the group-management screens plus the `vado_discount` adjustment type,
which appears wherever order adjustments are shown.

## How to use it

At a high level: enable the module, create one or more **add-on groups** to define
which variations are offered as add-ons of which base variations, and — if you want
to discount bundles — use the **`vado_discount`** adjustment. On the storefront, the
base variation's Add to Cart form then offers its add-on variations, and each ticked
add-on is added to the order as its own item. See
[Configuration](configuration/index.md) for details.
