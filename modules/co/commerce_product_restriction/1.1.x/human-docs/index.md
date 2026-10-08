# Commerce Product Restrictions — manual setup guide

**Commerce Product Restrictions** (`commerce_product_restriction`) lets you attach
pluggable purchase rules to products and product variations, so a product can be
bought only under conditions you define. Out of the box it ships restriction plugins
to limit a purchase to:

- a **specific date period** (available only between a start and end date),
- **selected user roles**,
- **specific named users**,
- entering a **password**,
- a **maximum quantity** counted across all of a customer's orders,
- and whether the customer has (or has not) **already purchased** another product or
  variation.

When a rule fails, the add-to-cart button is replaced by a message you configure,
explaining why the product cannot be purchased right now. You can combine several
restrictions on one product, and because it is a plugin type you (or a developer)
can add your own restriction rules.

Rather than a global settings screen, restrictions are attached through a **field**.
You add a "Product restriction" plugin field to a product type or product variation
type, and then, when editing an individual product or variation, you pick which
conditions apply. Restrictions can be set at the product level, the variation level,
or both.

It depends on **Commerce** (`commerce`) and **Commerce Cart** (`commerce_cart`).

**An important limitation to understand before you rely on this.** In this release
the restrictions are enforced at the **add-to-cart form** step only — the module's
server-side availability check is not wired up (its availability-checker service is
not registered). In practice that means the restriction hides or disables the
add-to-cart button in the normal storefront UI, but a crafted or programmatic
add-to-cart request (including "add to cart" links in some cases) can bypass the
rule, **password restriction included**. Treat these restrictions as a
merchandising/UX control, not as hard, server-enforced access control for sensitive
or paid-gated products. If you need guaranteed enforcement, verify it independently
before going live.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce and Commerce Cart.

There is **no global configuration form** — you set restrictions up per product type
using a field, described below.

## Where it lives in the admin menu

The module adds no central settings page. You work with it in two places:

- **Structure → (product/variation type) → Manage fields** — add the "Product
  restriction" field and set its widget.
- **Commerce → Products → (edit a product or variation)** — choose the restrictions
  that apply to that item.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On a product type or product variation type, add a field of type
   **Plugin → Product restriction**.
3. **Important:** on that type's **Manage form display**, make sure the field uses
   the **"Product restrictions"** widget — without it the restriction options will
   not appear on the edit form.
4. Edit a product or variation of that type and configure one or more restriction
   plugins, giving each a custom message shown when the rule blocks a purchase.
5. Test the storefront, keeping in mind the enforcement caveat above.
