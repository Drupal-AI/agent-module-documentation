# Commerce Order Data Formatter — manual setup guide

**Commerce Order Data Formatter** (`commerce_order_data_formatter`) is a small,
focused field formatter for Drupal Commerce. Every Commerce order carries a
serialized catch-all `data` field where modules and custom code stash arbitrary
key/value information. That field isn't meant to be shown to people directly — but
sometimes you *do* want to surface one particular value from it, such as a flag,
a reference, or a note that some other process wrote there.

This module solves exactly that. It adds a formatter that you point at the order
`data` field and tell which **key** to display, and it renders just that key's
value — on the order's display or in a View — without you writing any custom code
or a preprocess hook. That's the whole module: no dashboards, no background jobs,
no new permissions.

It depends only on **Commerce Order** (`commerce_order`), which is part of Drupal
Commerce, plus core's Field module. There is nothing to switch on beyond enabling
it — once installed, the formatter simply appears as an option wherever the order
`data` field can be displayed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely on a display, described in "How to use it" below.

## Where it lives in the admin menu

Commerce Order Data Formatter adds no admin page of its own. You use it from the
order entity's **Manage display** screen (under **Commerce → Configuration →
Order types → *(your order type)* → Manage display**) or when configuring an order
field in a **View**.

## How to use it

1. Go to the order type's **Manage display** (or edit the relevant order View).
2. Find the **Data** field row and change its **Format** to the formatter provided
   by this module.
3. In the formatter's settings (the gear/cog icon), enter the **key** whose value
   you want to show — for example the key some other module wrote into the order
   `data` field.
4. Save. The chosen key's value now renders wherever that display or View is used.

Because the order `data` field is order content, the value is shown subject to the
normal order access rules — this module adds no access logic of its own.
