# Commerce Shipping Mondial Relay — manual setup guide

**Commerce Shipping Mondial Relay** (`commerce_shipping_mondial_relay`) adds
**Mondial Relay pick-up-point shipping** to Drupal Commerce — the parcel-shop
delivery option that is popular across France and much of Europe. It provides a
Mondial Relay shipping method and a checkout pane carrying the **Mondial Relay
widget**, so customers can search for and choose a nearby parcel shop as their
delivery point during checkout.

It depends on **Commerce Shipping** (`commerce_shipping`) and adds no permissions
or access role of its own. It supports **Drupal 10.1+ and 11**.

The Mondial Relay checkout pane needs the **Shipping information** pane (provided
by `commerce_shipping`) to be present in your checkout flow to work. One known
issue to be aware of: with multiple shipping methods, the widget may not
show/hide or refresh correctly via AJAX — see the project's issue queue for the
current workaround.

The pickup-point search is Mondial Relay's own hosted widget, loaded in the
customer's browser; the module makes no server-side carrier API call and stores
no API secret (the **Brand / "Enseigne"** code it needs is a public widget
identifier). Serve checkout over HTTPS; the customer's chosen pick-up point and
address are shipping data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the Mondial Relay shipping
   method, enter your widget settings, and add the checkout pane.

## Where it lives in the admin menu

You configure it as a shipping method under **Administration → Commerce →
Configuration → Shipping methods** (`/admin/commerce/shipping-methods`) using the
**Mondial Relay** plugin, and you add the Mondial Relay pane in **Commerce →
Configuration → Checkout flows**. See [Configuration](configuration/index.md).
