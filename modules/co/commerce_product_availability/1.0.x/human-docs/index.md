# Commerce Product Availability — manual setup guide

**Commerce Product Availability** (`commerce_product_availability`) adds
availability logic to Drupal Commerce **product variations** — controlling when a
variation can actually be purchased, and communicating its availability to
shoppers. It provides a new **"Product Availability" field type**, a formatter to
display it, and the enforcement that stops unavailable items from being ordered.

The problem it solves is expressing more than a plain in-stock/out-of-stock flag.
The Product Availability field is multi-value and holds: **Orderable** (whether
the product can be purchased at all — this alone decides purchasability),
**Availability Status** (for example `in_stock` / `out_of_stock`, and the options
are alterable through a provided hook), **Available from** (a date the product
becomes available), and **Min / Max Delivery Period** (how long delivery takes).
On top of that it ships a Commerce **Availability Checker** that blocks adding a
non-orderable product to the cart, and an **Order Processor** that removes an
unavailable item from the cart — plus an optional field setting to alter the "Add
to Cart" button based on the availability values.

It has a small **settings form**, provides its own **permissions**, and includes
an optional **Webform Request** submodule (add an "Order request" button next to
Add to Cart that links to a webform). It supports Drupal 10 and 11. It governs
purchasability, not content access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the Webform Request submodule.
2. [Configuration](configuration/index.md) — the settings form, adding the
   Product Availability field to a variation type, and the field/widget/formatter
   options.

## Where it lives in the admin menu

The module's own settings live at **`commerce_product_availability.settings`**.
The bulk of the setup, though, is on your **product variation type** — you add the
**Product Availability** field there (**Commerce → Configuration → Product
variation types → (your type) → Manage fields**) and then adjust its widget and
formatter. See [Configuration](configuration/index.md).
