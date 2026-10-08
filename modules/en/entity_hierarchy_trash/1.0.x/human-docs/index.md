# Entity Hierarchy Trash Support — manual setup guide

**Entity Hierarchy Trash Support** (`entity_hierarchy_trash`) is a bridge module
that makes [Entity Hierarchy](https://www.drupal.org/project/entity_hierarchy)
work correctly with the [Trash](https://www.drupal.org/project/trash) module's
soft‑delete (recycle‑bin) model. Without it, sending a hierarchical entity to the
trash skips the delete hooks other modules rely on — so Entity Hierarchy never
gets the chance to reorganize the tree (for example, to move a deleted node's
children up to its parent).

This module fixes that. When an entity is moved to trash rather than hard‑deleted,
it triggers all of Entity Hierarchy's post‑delete actions — such as re‑parenting
the deleted item's children — while leaving the hierarchy information intact so
the entity can be restored later from the trash with its place in the tree still
known.

It is a pure integration layer: there is nothing to configure and no page of its
own. It simply depends on both **Entity Hierarchy** (5.x) and **Trash**, and does
its work automatically once all three modules are enabled.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Entity Hierarchy and Trash.

There is no configuration for this module. As the project notes: once installed,
no further steps are necessary.

## How to use it

There is nothing to switch on. With Entity Hierarchy, Trash, and this bridge all
enabled, soft‑deleting a hierarchical entity now behaves correctly — its children
are re‑parented and the hierarchy is preserved so the entity can be restored from
the trash.
