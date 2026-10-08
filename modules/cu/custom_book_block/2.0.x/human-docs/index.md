# Custom Book Block — manual setup guide

**Custom Book Block** (`custom_book_block`) provides a more flexible, configurable
version of the **book navigation block** that the Book module offers. Core's book
block is fixed in behaviour, but documentation and handbook sites often want more
control over what part of the book tree appears and how deep it goes. This module
makes book navigation a configurable block, so the navigation matches the shape of
your documentation rather than core's one‑size rendering.

Compared with core (or a similar module like *Book Tree Menu*), this one leans on
**configurability** — what to show and from where. Its per‑block options let you:

- show only a **single book**, or default to showing all (as core does);
- **dynamically detect** the current book;
- set a **starting level** and a **maximum depth** for the menu;
- **force** the menu to be fully expanded.

That means you can place several instances, each scoped differently — for example
a sidebar showing just the current chapter on one section and the full tree
elsewhere. The trade‑off is simply that more flexibility means more settings to get
right per placement.

It depends on core **Book** (which was deprecated in Drupal core 10 and moved to
the contrib [Book](https://www.drupal.org/project/book) project). This **2.0.x**
release targets **Drupal 10.3 or 11** together with the contrib Book **^2.0**.
There's no central settings page — all configuration is on each block instance.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Book dependency.

Configuration is per‑block, described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)); this requires the
   Book module.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and place the
   **Custom Book Block** into a region.
3. In the block's configuration, tune the options for that placement — choose a
   single book or all books, whether to detect the current book dynamically, the
   starting level and maximum depth, and whether to force the tree expanded.
4. Save, and check the navigation on a book page to confirm it renders the tree
   scope you intended. Since each placement is independent, repeat with different
   settings where you need a different scope.
