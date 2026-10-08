# Commerce Mautic Connect — manual setup guide

**Commerce Mautic Connect** (`commerce_mautic_connect`) bridges Drupal Commerce
and **[Mautic](https://www.mautic.org/)**, the open-source marketing automation
platform. It pushes cart contents and aggregated customer metrics into Mautic so
marketers can build campaigns driven by real shopping behaviour — abandoned-cart
recovery, customer segmentation, coupon tracking, and cross-device cart
restoration.

Its headline feature is **abandoned-cart recovery**. The moment a shopper adds
items, the module sends an HTML representation of their cart to Mautic (tracking
even anonymous visitors via Mautic's `mtc_id` cookie), records the cart's last-
updated timestamp for time-based drip campaigns, and can generate **secure magic
links** that restore a cart on any device and optionally auto-log the customer in.
Cart emails and magic links are rendered in the order's language.

Beyond carts, it tags Mautic contacts with the **coupon codes** they use (with a
configurable prefix) and, on order completion, syncs **RFM-style customer
metrics** — recency (last order date), frequency (order count), monetary
(lifetime value), tenure (first order date), and average order value — so
marketers can build VIP, win-back, and anniversary segments. Metric calculation
runs through Drupal's Queue API in the background, so it never slows checkout, and
multi-currency stores can pick a base currency (with automatic conversion via
Commerce Exchanger). Because it sends customer and cart data to an external Mautic
instance, **review your data-flow and privacy obligations** before enabling it in
production.

This module **needs configuration** — at minimum, connection details for your
Mautic instance. It depends on Drupal Commerce's **Cart** module and the
**Advanced Mautic Integration** module (`advanced_mautic_integration`), which
carries the actual Mautic API connection, and targets **Drupal 10 and 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — connect Mautic, choose the coupon
   prefix and base currency, and enable the features you want.

## How to use it

Once connected, most of the work happens **inside Mautic**: you build the
segments, campaigns, and emails that act on the data this module sends (cart HTML,
abandonment timestamps, coupon tags, and RFM fields). The module creates the
required custom fields in Mautic automatically, so you don't have to define them
by hand.
