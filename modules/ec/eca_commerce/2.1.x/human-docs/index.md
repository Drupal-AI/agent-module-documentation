# ECA Commerce — manual setup guide

**ECA Commerce** (`eca_commerce`) connects Drupal Commerce to the
[ECA](https://www.drupal.org/project/eca) ("Event – Condition – Action") no‑code
automation engine. With it, you can build order, cart, checkout, product,
payment, and promotion workflows visually in an ECA modeller (the maintainers
recommend the BPMN modeller) instead of writing a custom module with event
subscribers.

The module is pure "glue" — it has no settings page, no permissions, and no admin
UI of its own. What it does is expose three families of building blocks to ECA:

- **Events** — every Commerce event (core, cart, checkout, order, order‑item,
  payment, price, product, product‑variation, promotion, coupon, store, and tax)
  becomes an ECA start event your model can react to. Each event also exposes
  **tokens** (like `commerce_order`, `cart`, `commerce_payment`) so later steps in
  the model can read and modify the relevant entity.
- **Conditions** — every Commerce condition plugin (order total, product category,
  store, and so on) becomes an ECA condition you can use to guard a workflow step.
- **Actions** — two custom actions that operate on order items: **Change Price in
  Cart** (set an order item's unit price from a number or token) and **Add Price
  Adjustment** (add a custom discount, surcharge, or fee to an order item).

Because all of the behavior is defined in ECA models — which are trusted site
configuration — there's nothing to configure in this module directly. You install
it, then do your work inside ECA.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including per‑family references for
[events](../agent/plugins/events.md), [conditions](../agent/plugins/conditions.md),
and [actions](../agent/plugins/actions.md).

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (alongside ECA and Commerce).

## Where it lives in the admin menu

ECA Commerce adds **no** menu items or settings page of its own. You do all your
work in **ECA** — typically under **Configuration → Workflow → ECA** — where the
Commerce events, conditions, and actions this module contributes become available
in your models and modeller.

## How to use it

1. Install and enable ECA, a Commerce install, a modeller (BPMN recommended), and
   this module (see [Installation](installation/index.md)).
2. In your ECA modeller, create a new model and pick a **Commerce event** as the
   start — for example *order paid* (`order_paid`) or *item added to cart*
   (`cart_order_item_add`).
3. Read the entity you care about through the event's **token** (for example
   `commerce_order` or `commerce_order_item`).
4. Optionally add a **Commerce condition** to decide whether the workflow should
   proceed (for example, only when the order total exceeds a threshold).
5. Add **actions** — either the two Commerce‑specific ones (Change Price in Cart,
   Add Price Adjustment) or any other ECA action (send an email, call a webhook,
   set a field) — to do the work.

A couple of practical notes:

- Commerce event groups only appear when the matching Commerce submodule is
  installed, so if you don't see cart or payment events, enable the relevant
  Commerce submodule first.
- The two custom actions operate on `commerce_order_item` entities. Change Price
  in Cart sets the unit price (USD in this version); Add Price Adjustment adds a
  `custom` adjustment with a method, type, label, amount or percentage, and
  currency — with amounts and labels run through ECA token replacement first.
