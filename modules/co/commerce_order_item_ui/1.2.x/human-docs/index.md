<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item UI — manual setup guide

**Commerce Order Item UI** (`commerce_order_item_ui`) gives Drupal Commerce a proper
admin interface for managing the individual **order items** (line items) of an order.
Out of the box, Commerce only lets you edit line items inside the order edit form's
inline widget; this module adds a dedicated tab where staff can list, add, edit,
duplicate, and delete an order's line items one at a time.

It adds no new entities or configuration of its own — it simply augments the existing
`commerce_order_item` entity type with its own routes, list builder, forms, and menu
links. Everything lives under an order, at
`/admin/commerce/orders/{order}/order-items`, reached either from an **Order Items**
tab on the order page or an **Order Items** operation on the order list.

This is a back-office tool. It is handy for customer-service and warehouse staff who
need to amend orders — adding a phone-order line, correcting a mispriced item,
duplicating a similar line, comping a replacement, or removing an erroneous one —
without wrestling the whole order form. On the add form it is also careful to only
offer product variation types that actually belong to each order-item type, so
editors cannot attach the wrong kind of product.

There is no settings form to fill in — enabling the module is all the setup there is.
Because of that, this guide folds the "how to use it" and access details into this
page rather than a separate configuration section.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside Commerce).

## Where it lives in the admin menu

The interface is always scoped to a single order:

- **Order Items tab** — open any order at **Commerce → Orders** and click the
  **Order Items** tab.
- **Order Items operation** — on the order list (**Commerce → Orders**), each order
  row gains an **Order Items** operation linking to the same listing.
- Direct URL: `/admin/commerce/orders/{order}/order-items`.

## How to use it

From an order's **Order Items** listing you can:

- **Add order item** — click the action link. If the store has only one order-item
  type, you go straight to the add form; otherwise you pick the type first. The
  purchased-entity field only offers variation types valid for that order-item type.
- **Edit** — change the quantity, unit price, or title of a single line in isolation.
- **Duplicate** — copy an existing line as the basis for a similar one.
- **Delete** — remove a line, with a confirmation step.

## Who can access it

The module defines no permissions of its own; it reuses **Commerce Order**
permissions. Grant these at **People → Permissions** (`/admin/people/permissions`),
under the Commerce Order section:

- **Administer commerce_order** — full management: add, edit, and delete any order
  item.
- **Access commerce_order overview** — enough to view the order-items listing.
- **Manage &lt;type&gt; commerce_order_item** — a per-type permission; grant it for
  specific order-item types to let a role manage only those line-item types.

Users need one of the first two (or the relevant per-type permission) to see the
**Order Items** tab and operation at all.
