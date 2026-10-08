# Entity Reference (with) Hierarchy — manual setup guide

**Entity Reference (with) Hierarchy** (`entity_reference_hierarchy`) extends
Drupal core's standard entity-reference field, turning it from a flat, linear
list of references into a **rooted tree**. Instead of just listing references,
one field can hold a full parent-child structure — with a drag-and-drop
interface like the one core uses for taxonomy terms and menu links.

The problem it solves is that menus give a *site* navigation structure, not a
*content* structure. A handbook whose chapters contain sections, a product
catalogue with sub-categories, an organisational chart — these are properties of
the content itself, and modelling them through a menu means the structure exists
only where the menu is rendered and disappears from Views, from the API, and
from anything else that reads the content. This module stores the hierarchy on
the reference field, with a weight so siblings order, so the tree becomes
*data*. That makes it queryable: "everything under this chapter", "this page's
ancestors", and "the next sibling" become things a View or an API consumer can
ask.

Its architecture is a **single-field rooted tree**: the whole hierarchy —
depth and weight metadata alongside each target ID — is stored on the primary
host entity, rather than chained across many entities (the "nested set" approach
of the separate Entity Hierarchy module). That makes it especially well suited
to deeply nested Paragraphs layouts, and it is fully compatible with Entity
Reference Revisions, Inline Entity Form, and Paragraphs. It has no routes,
permissions, or endpoints.

Some design questions are worth settling **before content exists**: whether an
entity may have more than one parent (that decides whether you have a tree or a
graph, and "everything under X" costs very differently in each), any depth
limit, and what moving a subtree does to its descendants and to anything derived
from the structure such as paths or breadcrumbs. Test a subtree move early — it
is the operation that reveals whether the model behaves as you assumed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form.
Setup happens when you add the hierarchy field to a bundle, described in "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it from **Structure → Content types (or
other bundles) → *(bundle)* → Manage fields**, by adding the hierarchy-enabled
entity-reference field it provides.

## How to use it

1. On a bundle's **Manage fields**, add the module's hierarchical
   entity-reference field and set what it may target (content types, paragraph
   types, and so on).
2. On the entity edit form, add references and arrange them with the
   drag-and-drop interface — nesting items to set parent-child relationships and
   dragging to reorder siblings.
3. Because the tree is stored as data on the host entity, consume it from Views
   or the API to build navigation, ancestor lists, breadcrumbs, and similar.
