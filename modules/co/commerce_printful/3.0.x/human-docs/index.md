# Commerce Printful — manual setup guide

**Commerce Printful** (`commerce_printful`) connects Drupal Commerce to
**Printful**, the print-on-demand (POD) drop-shipping and fulfillment service. It
lets you sell branded apparel and merchandise — t-shirts, hoodies, hats, mugs, and
more — where Printful holds the inventory, prints on demand, and ships to your
customer. You set your storefront up in Commerce; Printful handles fulfillment.

The problem it solves is running a merch store without stock, warehousing, or
photography: Printful's API creates product images dynamically, you import
Printful products into Commerce (through the module's UI or a Drush command), and
when a customer checks out, the module consults Printful's API for shipping costs
and — on order completion — transfers the order to Printful for fulfillment. You
can choose to send orders as **drafts** for review or **fully automate**
fulfillment. Printful bills your card on file for each order; your payment gateway
collects from the customer and you keep the difference.

It depends on **Drupal Commerce** (plus **Commerce Shipping** and **Commerce
Currency Resolver**), provides its own **Drush commands** and **permissions**, and
is compatible with Drupal 11 and Commerce 3.x. It does **not** work on enable alone
— you must connect it with your Printful API key and import products before it does
anything.

> **Keep credentials safe.** The Printful API key is a live billing credential.
> Store it as a secret — an environment variable exposed through a **Key** entity
> rather than raw config — and run your site over **HTTPS**. See
> [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect your Printful account, choose
   the fulfillment behavior, and import products.

## How to use it

Once installed, connecting Printful and importing products is done from the
module's admin pages (and optionally the Drush import command). At a high level:
connect with your Printful API key, import the Printful products you want to sell,
decide whether orders go to Printful as drafts or are fully automated, and add a
payment gateway of your choice so you can collect from customers. The
[Configuration](configuration/index.md) page walks through this.
