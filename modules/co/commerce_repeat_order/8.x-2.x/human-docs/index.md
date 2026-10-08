# Commerce Repeat Order — manual setup guide

**Commerce Repeat Order** (`commerce_repeat_order`) lets a customer turn a past
order back into a cart — the "order again" feature. You place a simple link or
button that points at a previous order, and clicking it repopulates the cart with
that order's items, ready to check out again. It depends on **Commerce**
(`commerce`) and **Commerce Cart** (`commerce_cart`), and this project is
**covered by Drupal's security advisory policy**.

The problem it solves is friction on repeat purchases. For anything bought
regularly — consumables, supplies, a standing list — the second purchase shouldn't
cost the same effort as the first. Reordering is one of the highest-value small
features in commerce because it converts an existing customer with almost no
friction. The module works by exposing a route you link to with the order ID (for
example a "Repeat order" link placed in a template or view), and it validates that
the order being repeated belongs to the same customer — one customer's order won't
be added to another's cart.

Two things are worth thinking through before you rely on it. First, decide what
"the same order" should mean once the catalogue moves on — products get
discontinued, change price, go out of stock, or have their variations
restructured; check how the module handles each case on a catalogue that changes.
Second, **ownership is the check that matters**: the permission it defines governs
administration, not the per-order "does this belong to the person asking" check, so
make sure your links only expose a customer's own orders. If the real requirement
is recurring *delivery* rather than convenient reordering, a subscriptions module
is the better fit.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Commerce Cart.
2. [Configuration](configuration/index.md) — the replace-vs-add cart behaviour,
   the permission, and how to place the repeat-order link.

## Where it lives in the admin menu

Commerce Repeat Order works through a **repeat-order route** you link to (passing
an order ID), rather than a big admin page. Its behaviour setting and permission
are found in the Commerce configuration and at **People → Permissions** — see
[Configuration](configuration/index.md).
