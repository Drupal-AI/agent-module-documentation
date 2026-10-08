# Cafe Outlet Billing — manual setup guide

**Cafe Outlet Billing** (`cafe_outlet_billing`) is a lightweight,
point-of-sale-style billing tool for a small cafe or outlet. A cashier opens a
billing form, types in line items — each with a name, quantity, and price — and
the module turns those items into a printable PDF invoice. The invoice is
stamped with your site's name and email in the header and totals the items up,
ready to hand to or download for a walk-in customer.

It is deliberately minimal: there is no inventory, no stored orders, and no
payment processing. Think of it as a quick receipt generator rather than a full
commerce system. The form lets you add and remove item rows as you go and
defaults the cashier ID to the logged-in user, and the PDF is produced on the
server using the TCPDF library.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   TCPDF), and enable the module and its dependencies.

## Where it lives

Cafe Outlet Billing does not add an admin settings page. It exposes two
front-end routes once enabled:

- **`/billing-form`** — the cashier's form for entering line items. Add and
  remove rows, enter each item's name, quantity, and price, and the form
  calculates per-line and grand totals.
- **`/generate-bill/...`** — produces the invoice as an `application/pdf`
  response, served inline so it can be printed or downloaded.

## How to use it

Enable the module, open **`/billing-form`**, enter the items for the order,
and generate the bill. The resulting PDF carries the site name and email, the
date, the cashier ID, the line items, and the totals — a printable receipt.
