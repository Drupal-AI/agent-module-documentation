# Commerce Donation Flow — manual setup guide

**Commerce Donation Flow** (`commerce_donation_flow`) reshapes Drupal Commerce
for **donations** rather than product sales. Buying a product and making a
donation are surprisingly different: a donor wants to type or pick an amount,
maybe switch between a one‑time gift and a monthly one, and get to payment
quickly — without the cart, quantities and product pages of a normal store. This
module supplies the pieces that make that possible.

It ships a donation‑specific **order item** with the fields donations need,
routes and a controller for starting a donation and jumping to steps in the flow,
**two customised checkout flows** that extend Commerce's own checkout, checkout
**panes** that collect the donation data, an **AJAX price widget** that offers a
range of suggested amounts and switches between one‑time and monthly, and a
**block** for a quick donation that pre‑fills an amount and goes straight to
payment. It builds on the core Commerce order, price, payment and checkout
subsystems (`commerce_order`, `commerce_price`, `commerce_payment`,
`commerce_checkout`), so orders, gateways and panes all still work the way you
expect — they are simply tailored to the donation case.

The module handles the donation *experience*; it does **not** move money itself.
The actual payment runs through whatever Commerce **payment gateway** you pair it
with, so the security of the transaction lives in that gateway — choose one that
verifies its callbacks server‑side. It supports three broad setups: a site where
donations are the only commerce, a site where donations sit alongside a normal
store, and a site that runs donations and ordinary sales as separate processes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside its Commerce dependencies.
2. [Configuration](configuration/index.md) — the donation‑settings page and how
   the flow, amount widget and quick‑donation block fit together.

## Where it lives in the admin menu

After you enable the module, browse to the donation settings at
**Administration → Commerce → Configuration → Donation settings**
(`/admin/commerce/config/donation-settings`) and follow the on‑page guidance to
complete the setup. The module also provides its own permission for administering
the donation configuration.
