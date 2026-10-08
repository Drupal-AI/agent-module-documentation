# Shortcut View — manual setup guide

**Shortcut View** (`shortcut_view`) builds on Drupal core's Shortcut feature to give
each user a customizable, reorderable list of quick-access links. Where core lets you
collect shortcuts into a set, this module surfaces the current user's shortcuts as a
block that they can arrange to taste — dragging links into the order they prefer.

The problem it solves is small but real: everyday editors and administrators tend to
visit the same handful of pages over and over, and a fixed menu does not always put
those pages where a given person wants them. Shortcut View lets each user shape their
own quick-links list, powered by **Draggable Views** so the ordering is drag-and-drop
rather than a fiddly weight field.

When you enable the module it creates a **shortcuts view block** for you. The setup is
mostly about placing that block: you position it in a region through the block layout,
and it then displays the current user's shortcuts based on their assigned shortcut
set. There is no dedicated settings form — you tune it by editing the view and by
placing the block.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it, along with its Shortcut and Draggable Views dependencies.

## How to use it

After enabling the module, go to **Structure → Block layout**
(`/admin/structure/block`), find the **shortcuts** block it created, and place it in
the region where you want the quick-links to appear. The block then shows the current
user's shortcuts, drawn from their assigned shortcut set, and users can reorder the
links by dragging them. Because it is a view, you can further modify what it shows by
editing the view and saving your changes.
