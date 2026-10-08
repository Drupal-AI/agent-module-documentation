# Commerce Product Tax — manual setup guide

**Commerce Product Tax** (`commerce_product_tax`) lets a store choose the
applicable tax rate **per product variation**, instead of relying only on Drupal
Commerce's automatic rate resolution. It adds a **"Tax rate"** field type whose
widget shows the rates of a chosen Commerce tax type as a simple dropdown (for
example *Standard (20%)*, *Reduced*, or *No tax*), and a resolver that applies the
selected rate when an order is calculated.

This is the module you want when some products need a hand-picked rate — reduced
VAT on books or food, zero-rated items, or category-specific rates — rather than a
rate derived purely from tax rules. The tax choice lives with the product data, on
the variation itself, so editors control it right where they manage the product.

You configure it by attaching the Tax rate field to a product variation type and
telling it which **tax type** (a Commerce *Local* tax type, such as European Union
VAT or a custom local tax type) and which of that type's **zones** the editor may
choose from. At checkout, the module's tax-rate resolver reads the variation's
chosen value and hands that rate to Commerce's tax calculation, overriding the
default resolver. There is no settings page — all configuration is the field on the
variation type. The module requires **Commerce Tax** (part of Drupal Commerce,
`drupal/commerce` ^2.16 or ^3).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Tax rate field to a variation
   type and choose its tax type and zones.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure the **Tax rate** field
on a product variation type under **Commerce → Configuration → Product variation
types → (type) → Manage fields**. The tax types it draws rates from are the ones
you set up under **Commerce → Configuration → Tax → Tax types**.
