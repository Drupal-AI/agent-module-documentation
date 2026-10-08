# Commerce: Admin Checkout — manual setup guide

**Commerce: Admin Checkout** (`commerce_admin_checkout`) lets store
administrators use the normal Drupal Commerce checkout form to create and complete
orders *on behalf of customers* — the classic use case being phone or in‑person
sales. Its big advantage is that it reuses your existing checkout workflow: if
you've built custom checkout panes and logic, admins get the same flow rather than
a separate, parallel order‑entry screen you'd have to maintain twice.

It adds two checkout panes: **Assign Order to Customer** (attach the order to a
specific customer account during checkout) and **Order Items** (add products to
the order during checkout). It depends on Commerce Checkout
(`commerce_checkout`) and Commerce Order (`commerce_order`), and ships an optional
submodule, **Commerce Admin Payment** (`commerce_admin_payment`), for recording
manual "admin payments" that reduce the amount a customer pays — useful for
employee discounts and similar adjustments (this submodule needs the Commerce
Multiple Payments module).

Creating orders as another user is a sensitive capability, so it's properly
**permission‑gated**. Dedicated permissions — `access checkout as a different
user`, `edit cart items during checkout`, and `configure admin checkout settings`,
alongside core `access checkout` — are checked before an admin can act on someone
else's behalf. Grant `access checkout as a different user` only to trusted staff:
it lets them place orders as/for other people and see their carts.

One important install note: this module **requires a patch to Commerce core**
(from issue [#3204694]) — see [Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — apply the required core patch, install
   with Composer, enable the module (and optional submodule), and assign
   permissions.

Configuration of this module happens through the Commerce **checkout flow** (you
add its panes to your flow) and through **permissions**, both covered below and in
Installation — there is no standalone settings form page in this guide.

## Where it lives in the admin menu

- **Permissions:** **People → Permissions** (`/admin/people/permissions`).
- **Checkout flow / panes:** **Commerce → Configuration → Checkout flows**
  (`/admin/commerce/config/checkout-flows`) — this is where you add the
  *Assign Order to Customer* and *Order Items* panes (and, with the submodule, the
  *Apply Manual Payments* pane) to the flow admins will use.

## How to use it

1. Apply the required Commerce core patch and enable the module (see
   [Installation](installation/index.md)).
2. On **People → Permissions**, grant `access checkout as a different user`,
   `edit cart items during checkout`, and `configure admin checkout settings` to
   your trusted staff/administrator roles only.
3. Under **Commerce → Configuration → Checkout flows**, edit the checkout flow
   your admins will use and add the **Assign Order to Customer** and **Order
   Items** panes (and **Apply Manual Payments** if you enabled the submodule).
4. As an admin, start a checkout, assign the order to the customer, add the order
   items, and complete payment on their behalf — a phone/in‑person order placed
   through your real checkout workflow.
