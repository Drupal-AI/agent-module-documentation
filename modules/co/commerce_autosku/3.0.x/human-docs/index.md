# Commerce AutoSKU — manual setup guide

**Commerce Automatic Product Variation SKU** (`commerce_autosku`) generates
Drupal Commerce product-variation SKUs automatically from a token pattern,
instead of making editors type them by hand. You configure it per **product
variation type**, so each type of product can have its own SKU strategy. A
typical pattern such as
`[commerce_product_variation:product_id]-[commerce_product_variation:variation_id]`
produces predictable, consistent SKUs across your whole catalog, and the module
guarantees each one is unique.

Three modes are available per variation type. **Enabled** always generates the
SKU and hides the SKU field from the editor entirely. **Optional** keeps the SKU
field visible but fills it in automatically only when the editor leaves it
blank. **Disabled** turns automation off for that type. When a token pattern
resolves to an empty string, the module falls back to a SKU built from the
bundle label and entity ID; and if two variations would collide, it appends a
numeric suffix (`_0`, `_1`, …) until the SKU is unique, trimming to the 255-
character limit.

Under the hood, SKU generation is a plugin — the shipped **token** generator
resolves a Token pattern — so developers can add their own generator (a
sequential counter, a hashed value, and so on). Configuration is stored in the
variation type's third-party settings, which means it exports and deploys with
the rest of your Commerce configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Commerce and Token.
2. [Configuration](configuration/index.md) — the per-variation-type "Automatic
   SKU" form: modes, generator, and token pattern.

## Where it lives in the admin menu

There is no global settings page. SKU automation is configured per product
variation type, on an **Automatic SKU** tab reached from **Commerce →
Configuration → Product variation types**
(`/admin/commerce/config/product-variation-types`) — edit a type and open its
Automatic SKU local task. The tab is gated by an **Administer … SKU** permission
per entity type.
