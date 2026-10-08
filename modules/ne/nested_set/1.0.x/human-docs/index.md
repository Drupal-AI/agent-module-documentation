# Nested Set — manual setup guide

**Nested Set** (`nested_set`) provides a **field type** for organizing entities
into a hierarchy using the *nested-set model* (also known as modified preorder tree
traversal, or MPTT). It is a developer-oriented building block: rather than storing
a parent reference, it stores each element's left/right position values as ordinary
field values, so an entity can be placed into a tree and subtrees can be queried
efficiently.

It solves the same problem as **Entity Reference Hierarchy** but takes a different
approach. Because it stores only position values as field data — and does *not*
extend core's Entity Reference field or add a database table — it integrates
tightly with the Entity/Field system. That means you can have multiple hierarchy
fields on one entity, or per-translation hierarchies, and gather most
hierarchy-related information in a single entity query. The trade-off is write cost:
inserting or reparenting an element updates many rows, so it saves a potentially
large number of entities and is much slower than the two simple queries Entity
Reference Hierarchy needs.

Be aware of where this module currently sits. It is an **alpha release** and is
**seeking co-maintainers**. Today it provides the field type and a list builder
(similar to the taxonomy-term overview for organizing entities), so the field can
be added to any entity type but is **practically usable only with a custom
entity** — there is not yet a widget for general use. Position updates are **not
batched**, so it is suited to **small hierarchies** only. A widget, Views
integration, and computed parent/children properties are on the roadmap. It depends
on core's **Field** module and runs on Drupal 10.1 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it adds a field type and a
list builder rather than a settings form.

## Where it lives in the admin menu

Nested Set adds no dedicated settings page. You use it by adding a **Nested Set**
field to a (custom) entity type through the usual **Manage fields** workflow, then
organizing entities through the module's list builder — an interface similar to the
taxonomy-term hierarchy screen.

## How to use it

1. On a custom entity type, add a **Nested Set** field via that entity's **Manage
   fields** screen.
2. As you create entities, the field automatically appends each new element to the
   right of the nested set.
3. Use the module's **list builder** to drag entities into a hierarchy, much like
   organizing taxonomy terms.

> **Keep it small.** Because position updates are not yet batched, reparenting in a
> large tree can save a very large number of entities at once. Use Nested Set with
> small hierarchies until batched saves land, and expect to write some custom code
> — this release targets custom entities and does not yet ship a general-purpose
> widget or Views integration.
