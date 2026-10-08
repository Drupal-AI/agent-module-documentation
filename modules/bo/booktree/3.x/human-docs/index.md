# Book Tree — manual setup guide

**Book Tree** (`booktree`) provides a tree representation of one or more books.
Core's Book module builds hierarchical content, but for large books a
whole‑tree view makes navigation much easier. Book Tree renders one or more
books as a single navigable tree, so readers can see the structure and move
around it from any page.

It is a **display/navigation feature** for book‑using sites, with no security
surface of its own: it renders the structure of access‑controlled books, and a
book page a user cannot view remains subject to its own access control. It
depends on core's **Book** module. There is no dedicated admin settings page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. Book Tree renders book structure as a tree;
you surface it where your site presents book navigation (typically via a block at
**Structure → Block layout**, `/admin/structure/block`).

## How to use it

1. Make sure you have one or more books built with core's Book module.
2. Enable Book Tree and surface its tree where you want book navigation to
   appear.
3. Readers get a navigable tree of the book hierarchy — confirm it renders the
   book(s) you intend, since a full tree can be large for a big book. Book pages
   a visitor cannot access remain hidden by their own access control.
