# Entity Hierarchy Widgets — manual setup guide

**Entity Hierarchy Widgets** (`entity_hierarchy_widgets`) adds friendlier editing
tools on top of the [Entity Hierarchy](https://www.drupal.org/project/entity_hierarchy)
(Entity Reference Hierarchy) module. Entity Hierarchy stores the parent/child
relationships between entities; this module gives editors a visual way to view and
rearrange those hierarchies instead of editing one reference field at a time.

It provides three things: a **drag‑and‑drop management interface** for reorganizing
a whole hierarchically‑organized tree (not just the direct children of one item),
an **additional selection widget** similar to the one Drupal uses for hierarchical
taxonomy terms, and a **block** that displays the hierarchy of the entity currently
being viewed.

This is a content‑editing and site‑building helper. It follows Entity Hierarchy's
own data model and adds one permission for using the hierarchy management form. It
depends on the Entity Hierarchy module (5.x).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Entity Hierarchy.

There is no central settings form for this module. Setup is a matter of granting
its permission, choosing the selection widget on your field, and (optionally)
placing its block — described in "How to use it" below.

## How to use it

After enabling the module (see [Installation](installation/index.md)):

1. **Grant the permission.** At **People → Permissions**
   (`/admin/people/permissions`), give the roles that should reorganize
   hierarchies the module's permission to use the hierarchy management form.
2. **Choose the selection widget.** On the form display of the bundle that carries
   your Entity Reference Hierarchy field (**Manage form display**), switch the
   field to the new taxonomy‑style hierarchical selection widget this module
   provides.
3. **Place the hierarchy block (optional).** At **Structure → Block layout**
   (`/admin/structure/block`), place the "hierarchy" block in a region if you want
   editors to see the tree of the current entity while viewing it.
4. **Reorganize with drag‑and‑drop.** Use the management form to drag entities
   into a new order or under new parents across the whole tree.
