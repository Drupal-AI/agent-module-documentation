# Book Tree Menu — manual setup guide

**Book Tree Menu** (`book_tree_menu`) gives core's Book module a better
navigation block. Drupal core can build hierarchical books, but its built‑in
book navigation block is minimal — it does not present the whole book as a tree,
which is exactly what a documentation or handbook site wants so a reader can see
where they are in the larger structure and jump around it.

This module supplies that: a tree‑style navigation block that shows the full
book hierarchy and is navigable from any page in the book. It is a **display
alternative** — it changes how book navigation is presented, not how books are
authored — so you use it by placing its block wherever the book navigation
should appear. It depends on core's **Book** module and is only useful on a site
that uses books.

It sits alongside other takes on "core book navigation is not enough" (for
example `custom_book_block`); which one fits depends on whether you want a full
tree (this module) or a more configurable block. There is no dedicated admin
settings page — the module works through block placement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. You work with it at **Structure → Block
layout** (`/admin/structure/block`), where its book‑tree block becomes available
to place into a region.

## How to use it

1. Make sure you have a book built with core's Book module.
2. Go to **Structure → Block layout** and place the module's book‑tree block into
   the region where you want book navigation (typically a sidebar).
3. View a book page — the block renders the full book hierarchy as a tree, so
   readers can see where they are and jump to any section.

Because a full tree can be large for a big book, confirm the depth and branch it
renders suit your content before relying on it site‑wide.
