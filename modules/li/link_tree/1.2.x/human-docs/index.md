# Link tree — manual setup guide

**Link tree** (`link_tree`) extends Drupal's core **Link** field with a
hierarchical, indentable *tree* of links. Where a normal multi-value link field
gives you a flat list, Link tree lets an editor reorder the items **and** indent
them to express parent/child relationships — turning that flat list into a nested
structure. It's a handy way to build menu-like navigation or an in-content table
of contents without creating a separate menu entity.

Each link item is a real link (an internal path or an external URL), and the
module integrates with **Linkit** so editors get autocomplete when pointing a
link at internal content. Because it is a field type, it can be attached to any
fieldable entity, and it follows that entity's and field's normal access rules —
it adds no permissions or access logic of its own.

Link tree has **no configuration page of its own**. You add the field, and all
the work happens in the field widget on the content edit form (dragging to
reorder, indenting to nest) and in how your theme renders the provided templates.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in
   Link and Linkit), enable the module, and add the field.

There is **no settings form** for this module. Setup happens entirely on the
field you add to an entity bundle, described in "How to use it" below.

## Where it lives in the admin menu

Link tree adds no admin page. You use it from **Structure → *(your entity
type)* → Manage fields**, where you add a field of type **Link tree**, and from
the content edit form where the tree widget appears.

## How to use it

1. Go to the entity bundle you want the tree on — for example **Structure →
   Content types → *(your type)* → Manage fields** — and click **Add field**.
2. Choose the **Link tree** field type and give it a label. Set the field to
   allow **more than one value** (an Unlimited or fixed multi-value field) so
   there is a tree to build.
3. Save the field settings. Configure the Linkit profile on the field/widget as
   you would for any Linkit-enabled link field, so editors get autocomplete for
   internal targets.
4. When editing content, add several link items, then **drag to reorder** them
   and **indent** child items beneath their parents to build the tree. The
   sequence and nesting you set are stored per entity.
5. On **Manage display**, the tree is rendered through the module's templates;
   theme them if you want custom markup for the nested output.
