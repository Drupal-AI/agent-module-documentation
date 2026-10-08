# Commerce Product Reservation — manual setup guide

**Commerce Product Reservation** (`commerce_product_reservation`) is a framework for
building a *reserve-and-collect* flow on top of Drupal Commerce. A "reservation"
here means a customer wants to hold a product and then pick it up and pay for it in
a physical store — rather than checking out and paying online in the usual way. That
lets you offer a different, lighter checkout for reservations (for example asking
only for a phone number) alongside your normal online orders.

Rather than being a finished, drop-in feature, this module gives you the scaffolding
and expects you to supply the store-specific parts. When you enable it, it creates a
**"reservation item"** order-item type, a **"reservation"** order type, and a
**"reservation" checkout flow** — you will usually want to tidy that checkout flow
to match how your stores actually take reservations.

To be genuinely useful it needs two things you provide: a source of **store data**
(which stores exist and whether the product is available at each) and, typically, an
**integration** that notifies a store when a reservation is coming so staff can get
the item ready and tell the customer. The project ships an example implementation,
the **Commerce Product Reservation Simple** submodule
(`commerce_product_reservation_simple`), which returns a single store (your online
store) and always reports the product as available — a working reference you can
study or replace with a plugin of your own.

It builds on Commerce cart and checkout and stores nothing sensitive of its own. It
depends on **Commerce Product** (`commerce_product`), **Commerce Cart**
(`commerce_cart`), and **Commerce AJAX Cart Message**
(`commerce_ajax_cart_message`), and supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it and its
   Commerce dependencies, and note the example submodule.

There is **no global settings form**. Setup happens by tidying the generated
reservation checkout flow and supplying a store-data plugin, described below.

## Where it lives in the admin menu

The module adds no settings page of its own. What it creates lives in the standard
Commerce places: the **reservation** order type and **reservation item** order-item
type under **Commerce → Configuration**, and the **reservation** checkout flow under
**Commerce → Configuration → Checkout flows**.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). It creates the
   reservation order type, order-item type, and checkout flow.
2. Edit the **reservation** checkout flow under **Commerce → Configuration →
   Checkout flows** to strip it down to what a reservation actually needs (for
   example, just contact details rather than payment).
3. Provide store data. Enable the example **Commerce Product Reservation Simple**
   submodule to see the flow working end-to-end with a single always-available
   store, or write your own plugin that lists stores and reports per-store
   availability for your real use case.
4. Add your notification/integration step so a store learns when a reservation is
   placed.
