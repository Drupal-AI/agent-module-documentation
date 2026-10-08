# Commerce Simplenews Checkout — manual setup guide

**Commerce Simplenews Checkout** (`commerce_simplenews_checkout`) adds a newsletter
sign-up step to the Drupal Commerce checkout. It provides a Commerce **checkout pane**
that shows your [Simplenews](https://www.drupal.org/project/simplenews) newsletters as
checkboxes during checkout; when the customer opts in, their order email address is
subscribed to the newsletters they selected once the order is submitted.

It solves a common marketing need: growing a newsletter list without asking buyers to fill
in a separate sign-up form. The subscription always uses the buyer's own order email
(`$order->getEmail()`) — there is no free-text email field for a shopper to abuse — and if
no Simplenews subscriber exists for that address yet, one is created automatically.

The module depends on **Drupal Commerce** and **Simplenews**. It has no settings page of
its own: you add and configure the pane from the Commerce checkout flow, exactly like any
other checkout pane. (The repository also contains some legacy Drupal 7-era procedural code
in its `.module`/`.install` files; that code does not run on Drupal 10/11 — the working
code path is the checkout pane plugin.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module and
   its dependencies.

There is **no dedicated configuration page** for this module. You set it up on the checkout
flow, described in "How to use it" below.

## Where it lives in the admin menu

The pane is configured from **Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`). Editing a checkout flow requires the
**Administer checkout flows** (`administer commerce_checkout flow`) permission.

## How to use it

1. Make sure you have at least one Simplenews newsletter set up (**Content → Newsletters**,
   or `/admin/content/simplenews`), and that Simplenews is configured.
2. Go to **Commerce → Configuration → Checkout flows** and edit the flow you want to add
   sign-up to.
3. Place the **Simplenews subscription** pane on a checkout step. By default it lands on
   the **summary** step, but you can drag it to whichever step and position you prefer.
4. Configure the pane:
   - **Newsletters** — tick which of your Simplenews newsletters appear at checkout.
   - **Label** — the heading shown to the shopper above the checkboxes (default
     "Subscribe to newsletters").
   - **Display in review step** — whether the choice is echoed back in the checkout review
     summary.
   - **Review label** — the text used in that review summary; it supports the
     `@newsletters` placeholder.
5. Save the checkout flow. During checkout, customers now see the newsletter checkboxes; on
   order submission, their order email is subscribed to whichever newsletters they checked.
