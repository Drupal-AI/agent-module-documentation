# Commerce Shipping Tracking — manual setup guide

**Commerce Shipping Tracking** (`commerce_shipping_tracking`) gives your
customers a self‑service way to check **whether their order has shipped**. It
provides a lookup form (rendered as a block you place with Block Layout) where a
customer can check the shipping status of their order, plus a configuration page
where you map your shipping workflow states to friendly labels and set the success
and error messages shown to the user. It depends on **Commerce Shipping**
(`commerce_shipping`) and provides its own permissions.

Once enabled it does need a little setup before it's useful: you place the block,
map your shipment workflow's machine names to the labels customers should see, and
decide what the form says on success and on error. That's all done on its settings
page.

**How the lookup identifies a customer.** The form asks for two things: the
**order number** and the **email address used on the order**. It returns a status
only when an order with that number exists, the submitted email matches that
order's own email, and the order has a shipment. What it shows is a single
status label (mapped from the shipment's workflow state) plus your configured
message — not the order's contents. The configuration page itself is protected by
the module's own permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — map your shipment states to labels,
   set the messages, place the block, and review permissions.

## Where it lives in the admin menu

The settings page is at **Commerce → Configuration → Shipping → Order
Tracking Settings** (`/admin/commerce/config/shipping_tracking`). The customer‑facing
lookup form is a **block** you position via **Structure → Block layout**.
