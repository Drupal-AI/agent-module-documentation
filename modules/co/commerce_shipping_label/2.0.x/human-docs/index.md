# Commerce Shipping Labels — manual setup guide

**Commerce Shipping Labels** (`commerce_shipping_label`) provides an **API for
generating shipping labels** in the admin interface for shipments created with
Drupal Commerce Shipping. Think of it as the shared plumbing for printable labels
— it gives other modules a common way to produce and download a label for a
shipment.

The important thing to understand is that **this module does not talk to any
shipping carrier by itself**. On its own it does not fetch rates or create real
carrier shipments; it is a framework that *other* shipping-service modules
integrate with to add remote shipment and label-download support. Modules that
build on it include **Commerce EasyPost** and **Commerce Shipping Colissimo**. It
also ships a **Zebra printer** submodule for producing labels on Zebra label
printers.

It depends on **Commerce Shipping** (`commerce_shipping`) and supports **Drupal
9, 10, and 11**. It adds no permissions or access role of its own.

Two things to keep in mind for whichever carrier module you pair it with: any
**carrier API credentials** those modules use should be stored as secrets and
sent over HTTPS, and generated **labels contain customer addresses (personal
data)**, so store and dispose of them appropriately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   (optionally) the Zebra submodule.

This module has **no configuration page of its own** — there are no settings to
fill in. The label behaviour you actually configure lives on the carrier module
you install alongside it (for example Colissimo's settings form). Enable this
module so those carrier modules have the label API to build on.

## Where it lives in the admin menu

Commerce Shipping Labels adds no settings page. Once a carrier module that
integrates with it is configured, label generation and download appear on the
**shipment** in an order's admin screens (**Commerce → Orders → *(order)* →
Shipments**).
