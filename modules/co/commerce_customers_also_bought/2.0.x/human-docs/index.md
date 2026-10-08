# Commerce Customers Also Bought — manual setup guide

**Commerce Customers Also Bought** (`commerce_customers_also_bought`) displays a
"customers also bought" recommendation block — products that other customers
frequently purchased alongside the product currently being viewed, computed from
your store's order history.

It is a **cross‑sell** feature aimed at increasing basket size: when a shopper
looks at a product, the block surfaces related items that others bought with it,
nudging them toward add‑on purchases. The recommendations come from **aggregate
order history**, not from any individual customer's personal data, and the module
has no access‑control role.

It is delivered as a **block**, so you place and configure it through Drupal's
Block layout. It requires core **Block** (`block`) and **Drupal Commerce**
(`commerce`), and supports Drupal 9.5, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** for this module — you configure it in the
block's settings when you place it, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You place and configure its block from
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the recommendations to
   appear, and choose the **Commerce Customers Also Bought** block.
3. In the block settings, configure:
   - **How many products** to show to the customer.
   - The **product view mode** used to render each recommended product.
   - Standard block visibility options (for example, restricting it to product
     pages).
4. Save the block.

> **Good to know:** the block shows products bought together with the product on
> the current page. If you place it somewhere that is **not** a product page,
> products are chosen **randomly** from all Commerce orders instead — so it is most
> meaningful on product displays.
