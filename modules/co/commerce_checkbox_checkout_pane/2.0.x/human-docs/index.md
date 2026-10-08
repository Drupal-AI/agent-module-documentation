# Commerce Checkbox Checkout Pane — manual setup guide

**Commerce Checkbox Checkout Pane** (`commerce_checkbox_checkout_pane`) adds a
single, configurable **checkbox to the Drupal Commerce checkout flow** and saves
whatever the customer chooses onto the order. It's the small helper you reach for
when checkout needs one opt‑in or acknowledgement: accepting terms and conditions,
agreeing to share an email address with a shipping service, confirming an age
gate, or any other yes/no the customer should tick before completing an order.

You give the pane a title, a checkbox label, an optional description, and decide
whether ticking it is **required** to proceed. You also set a **key** under which
the checkbox's value is stored on the order (in `$order->data[KEY]`), so other
parts of your site can read the customer's choice later. It's deliberately
minimal — one checkbox, saved to the order — which keeps it flexible enough for
almost any single‑checkbox need.

This is a checkout‑UX module with **no access‑control role of its own**. It depends
on Commerce **Checkout** (`commerce_checkout`) and works on Drupal 10.3 and 11. If
you specifically want a terms‑and‑conditions agreement, the
[Commerce Agree Terms](https://www.drupal.org/project/commerce_agree_terms) module
is a purpose‑built alternative — but this module handles that case and many others
just as well.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Commerce Checkout.
2. [Configuration](configuration/index.md) — placing the pane in a checkout flow
   and setting its key, title, label, description, and required flag.

## Where it lives in the admin menu

The pane is added and configured under **Commerce → Configuration → Checkout
flows** (`/admin/commerce/config/checkout`). You place the pane on a checkout flow
there, then edit its settings at that flow's pane configuration
(`/admin/commerce/config/checkout/form/pane/commerce_checkbox_checkout_pane`).
