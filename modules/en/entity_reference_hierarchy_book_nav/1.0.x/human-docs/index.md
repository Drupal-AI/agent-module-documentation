# Entity Reference Hierarchy Book Navigation — manual setup guide

**Entity Reference Hierarchy Book Navigation**
(`entity_reference_hierarchy_book_nav`) adds book-style navigation — a table of
contents plus previous/next section links — over hierarchies built with the
[Entity Reference (with) Hierarchy](https://www.drupal.org/project/entity_reference_hierarchy)
module. If you have used core's Book module, this gives you the same reading
experience, but driven by a reference-field hierarchy instead of core Books.

The problem it solves is turning a content hierarchy into something a reader can
navigate. Once your pages are arranged as a rooted tree on a reference field,
this module renders the "you are here / go up / go to the next page" chrome that
makes a multi-page handbook or documentation set feel like a book.

It ships two content types and two blocks. The **Book** content type holds the
books you create and must keep its `field_book_structure` field (which you point
at whichever content types you want inside the book); the **Book chapter**
content type is for adding unlinked pages into the book. The **Book Contents
Block** renders a table of contents when the current page is part of a book, and
the **Book Navigation** block renders the next/previous section links. It
depends on the Entity Reference Hierarchy module. Navigation follows the
hierarchy and respects entity access; it has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in Entity Reference Hierarchy).

There is **no configuration page** for this module — it has no settings form.
Setup is a matter of configuring the Book content type's field and placing the
two blocks, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no central settings page. You work with it through the content
types it provides (**Structure → Content types**), the **field_book_structure**
field on the Book type (**Manage fields**), and the two blocks you place at
**Structure → Block layout** (`/admin/structure/block`).

## How to use it

1. On the **Book** content type's **Manage fields**, edit the
   **field_book_structure** field so it may reference the content types you want
   to include in a book.
2. At **Structure → Block layout**, place the **Book Contents Block** and the
   **Book Navigation** block in the regions you want them.
3. Create a **Book** node, then add and order the other pages in its Book
   structure field.
4. Visit any page that is part of the book — the contents and next/previous
   navigation blocks appear because the current page belongs to that book.
