# Commerce Product Add On — manual setup guide

**Commerce Product Add On** (`commerce_pado`) lets one product offer other products
as tick-box add-ons directly in its Add to Cart form — an extended warranty next to
a laptop, gift wrapping next to a gift, an installation service next to a piece of
hardware. Each add-on the customer ticks becomes its own order item in the cart, so
it keeps its own price, stock and tax treatment and appears as a separate line —
which keeps reporting and fulfilment straightforward.

The clever part is that it works entirely through **display configuration** rather
than new entities. Which products are offered as add-ons is a per-display decision:
the module adds an add-on section to a product's **view display** (the entity
display you edit under *Manage display*), so you can offer different add-ons in, say,
the full product page versus a teaser, and the whole configuration exports with your
site's config. At render time the add-on checkboxes are built into the Add to Cart
form. Because add-ons are ordinary products, editors can add or remove them from a
display without deleting anything, and everything about them — price, inventory, tax
— behaves exactly as for a normally purchased product.

The add-on labels are themeable: the module ships three Twig templates (one for the
form, one for the add-on product label, one for the add-on variation label) with
theme-suggestion hooks, so you can style labels per product type or variation type.
The module requires Commerce's **Cart** and **Product** modules and adds no
permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — configure which products are offered
   as add-ons on a product's view display, and theme the labels.

## Where it lives in the admin menu

There is no dedicated settings page. You configure add-ons on a product type's
**view display** at **Commerce → Configuration → Product types → *(a product type)*
→ Manage display**, or via *Structure → Display modes* — the add-on options are
added to that entity-view-display edit form.

## How to use it

At its simplest: enable the module, edit the view display of a product type, choose
which products should be offered as add-ons there, and save. On the storefront, the
Add to Cart form for that product then shows the add-ons as checkboxes, and each
ticked add-on is added to the cart as its own order item. See
[Configuration](configuration/index.md) for the step-by-step.
