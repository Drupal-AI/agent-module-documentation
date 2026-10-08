# Restaurant Order Management — manual setup guide

**Restaurant Order Management** (`restaurant_order`) is an in-Drupal ordering and
point-of-sale workflow for restaurants. It aims to cover the day-to-day operation
end to end: building and managing a menu, taking table orders, routing kitchen and
bar tickets — **KOT** (Kitchen Order Ticket) and **BOT** (Bar Order Ticket) — and
producing bills, including aggregated bills per table or session. It does this with
its own custom routes, controllers and forms rather than by configuring core entities,
and it depends on core's **Field**, **User** and **Views** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** for this module — its screens are operational
(menu management, order taking, ticket routing, billing) rather than a configuration
page, so setup beyond installation is done by using those workflow screens and by
setting up permissions for your restaurant roles.

## How to use it

Functionally, staff use the module's screens to build a menu, place table orders,
route KOT/BOT tickets to the kitchen and bar, and generate bills per table or
session. The custom routes provide the order list, the per-order view, the
status-change action, and the billing/receipt output.

## Where it lives in the admin menu

The module works through its own custom paths (under `/restaurant/…` and
`/restaurant-order/…`) rather than a settings page in the admin configuration tree.
