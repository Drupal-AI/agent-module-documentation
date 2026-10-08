# Commerce Purchasable Entity — manual setup guide

**Commerce Purchasable Entity** (`commerce_purchasable_entity`) gives Drupal
Commerce a lightweight alternative to the usual product-and-variation pair.
Commerce normally models anything you sell as a *product* with one or more
*variations*, which is powerful but heavier than you need when you are selling a
single-SKU thing — an event ticket, a membership, a one-price service, a
donation. This module defines a minimal **purchasable entity** instead: a single
entity type carrying just the fields Commerce actually requires of something
sellable — a **price** and a **store** reference.

Because it implements Commerce's purchasable-entity contract, this minimal
entity behaves like a product variation where it counts: it can be the target of
an order item type and flows through cart, checkout, tax, and promotions the
same way. What you leave behind is the variation UI and the editorial overhead
that comes with it.

It is a proper bundleable entity type — you can create several purchasable
*types* (bundles), each with its own extra fields added through Field UI — and
it ships a full admin interface for managing both the entities and their types,
with the usual create/edit/delete/view permissions plus a restricted permission
for configuring the bundles. It depends on the **Commerce**, **Commerce Price**,
and **Commerce Store** modules.

One trade-off is the point of the module: because this is a distinct entity type
rather than a product variation, product-specific contrib (product attributes,
variation-based add-ons) will not apply to it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   Commerce dependencies, and enable the module.

## Where it lives in the admin menu

Once enabled, the module adds an admin area for managing purchasable entities
and their types (bundle configuration), reachable from Commerce's
administration under the entity's own menu, task, and action links. Bundle
administration is gated by the restricted **Administer commerce purchasable
entity type** permission; the entities themselves use standard create, edit,
delete, and view permissions on **People → Permissions**.

## How to use it

1. Enable the module and its Commerce dependencies (see
   [Installation](installation/index.md)).
2. Create a **purchasable entity type** (a bundle) in the admin UI — for
   example "Ticket" or "Membership". Add any extra fields it needs with Field
   UI.
3. Create an **order item type** whose purchasable entity type points at your
   new type, so Commerce knows how to add these items to a cart.
4. Add individual **purchasable entities** (giving each a price and a store) and
   reference them from an add-to-cart form.

From there, cart, checkout, tax, and promotions all behave as they would for a
normal product variation — you have simply skipped the product/variation
structure.
