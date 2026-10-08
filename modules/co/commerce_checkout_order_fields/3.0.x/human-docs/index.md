# Commerce checkout order fields — manual setup guide

**Commerce checkout order fields** (`commerce_checkout_order_fields`) lets you
collect extra information *on the order* during Drupal Commerce checkout — order
comments, a preferred delivery date, a PO number, a gift message, a VAT ID — without
writing a custom checkout pane. Any field you add to the order type can be shown and
filled in mid-checkout, and it saves straight onto the order entity.

It does this by shipping a dedicated **Checkout** form-display mode for orders and a
checkout pane that renders that form display. The workflow is entirely
click-through: add fields to your order type, enable and arrange the Checkout form
display, then drop the resulting *Order fields: Checkout* pane into a step of your
checkout flow. At checkout the pane renders exactly the fields you enabled on that
display, validates them, and saves them onto the order — so the data travels with
the order and exports with it (unlike data captured on a customer profile).

The module has no settings form of its own; all setup happens through Commerce's
existing Field UI, form-display UI, and checkout-flow UI. It requires **Commerce**
(version 3+), **Commerce Checkout**, and core's **Field UI**. There are no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the four-step setup: add fields,
   enable the Checkout form display, place the pane, and the pane's own options.

## Where it lives in the admin menu

There is no page called "Commerce checkout order fields." You work across three
existing Commerce areas: **Commerce → Configuration → Order types → (type) → Manage
fields** and **Manage form display**, and **Commerce → Configuration → Checkout
flows**. The full sequence is in [Configuration](configuration/index.md).
