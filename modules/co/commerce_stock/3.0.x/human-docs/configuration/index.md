# Configuration

Commerce Stock's main settings live on one form that controls **which stock
service** handles your products and **how orders change stock**. For real
inventory tracking, make sure you enabled the **Local stock** submodule first
(see [Installation](../installation/index.md)).

## Open the stock settings form

Go to **Commerce → Configuration → Stock → Stock settings**
(`/admin/commerce/config/stock/settings`). You need the **Administer commerce
stock** permission.

## Choose the stock service

A "stock service" is the backend that tracks a product's availability. The form
lets you set:

- **Default stock service** — used for any product type that doesn't have its own
  override. Options are the services currently available: **Always in stock**
  (every product always available, no tracking) and, once the Local stock
  submodule is on, **Local stock** (real, database‑backed quantities). For
  inventory tracking, set this to **Local stock**.
- **Per product‑variation‑type service** — the form lists each purchasable entity
  type and its bundles, so you can override the service per product variation
  type. Leave one on **Use default** to fall back to the default service. This is
  how you track some product types while leaving others (for example digital
  goods) always in stock.

## Configure how orders affect stock

- **Stock events plugin** — decides whether and when orders create stock
  transactions. The default (**Core stock events**) automatically adjusts stock
  as orders move through their lifecycle. Choosing **Disabled** turns automatic
  order‑driven stock changes off entirely (useful if you record stock some other
  way).
- With **Core stock events** selected, you also control:
  - **Which order event completes the sale** — which point in the order
    lifecycle triggers the stock decrement (for example when the order is placed
    versus a later workflow transition).
  - **React to order cancellation** — restore stock when an order is cancelled.
  - **React to order updates** — adjust stock when order items change.

Save the form when done.

## Permissions

Manage these at **People → Permissions**:

- **Access commerce stock administration pages** — lets a user reach the Stock
  admin section under Commerce configuration.
- **Administer commerce stock** — lets a user change these stock settings
  (restricted — grant only to trusted administrators).

## Setting actual stock levels

The settings above choose *how* stock is tracked; entering the numbers happens
elsewhere, provided by the submodules:

- With **Commerce Stock Field**, a stock‑level field appears on product
  variations so you can set quantities while editing a product.
- With **Commerce Stock UI**, warehouse staff get dedicated transaction forms to
  record stock received, sold, moved, or returned, and to manage stock
  **locations** (warehouses).

Those submodules have their own settings; see their documentation for details.
