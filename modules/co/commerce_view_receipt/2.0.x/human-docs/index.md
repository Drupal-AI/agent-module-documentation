# Commerce View Receipt — manual setup guide

**Commerce View Receipt** (`commerce_view_receipt`) lets you view a Drupal
Commerce order's receipt — the very same template that gets emailed to the
customer — right in the browser. Staff get a **Receipt** tab on the order page,
and customers get a viewable receipt page for their own orders. If you also have
the Entity Print module, each receipt page gains a **Download PDF** action.

There's no settings form and no new permissions to manage. Once the module is
enabled, the receipt links and tabs simply appear, and access is governed by
Drupal Commerce's existing order‑access rules. Staff need permission to reach the
Commerce admin pages *and* to view the order; a customer can only open the receipt
for an order they actually own. That means one customer can never read another
customer's receipt.

It's useful in a few everyday situations: previewing changes to the receipt
template without sending yourself a test email, letting customer service confirm
what a customer's emailed receipt looks like, giving customers a printable or
downloadable copy for their records, and adding a receipt link column to an order
listing built in Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Entity Print add‑on.

## Where it lives in the admin menu

There is no configuration page. The features appear on existing Commerce pages:

- **Staff:** a **Receipt** tab on each order's page
  (`/admin/commerce/orders/{order}/receipt`).
- **Customers:** a **View Receipt** action on their order, at
  `/user/{user}/orders/{order}/receipt`.

## How to use it

- **View a receipt as staff.** Open any order under **Commerce → Orders**, then
  click the **Receipt** tab. You'll see the order's receipt rendered from the
  `commerce_order_receipt` template, including the billing profile and the order
  total summary (subtotal, adjustments, total).
- **Give customers their receipt.** Customers see a **View Receipt** action on
  their own order pages. The link is scoped to the order's owner, so it only works
  for the right person.
- **Download a PDF.** Enable the optional **Entity Print** module (see
  [Installation](installation/index.md)) and a **Download PDF** action appears on
  both the staff and customer receipt pages.
- **Add a receipt link in Views.** When building a view of orders, add the
  **Receipt link** field. It renders a link to the customer receipt for
  **completed** orders only, and hides itself automatically when the viewer isn't
  allowed to see it.
