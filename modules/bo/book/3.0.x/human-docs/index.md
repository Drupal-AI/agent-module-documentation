# Book — manual setup guide

**Book** (`book`) lets editors tie ordinary content into a hierarchical outline —
a tree of chapters, sections, and sub‑pages — with automatic navigation,
breadcrumbs, next/previous/up links, and a printer‑friendly export. If you have
ever read Drupal's own online documentation laid out as a nested handbook, that
is exactly the experience Book creates.

A "book" is simply a set of nodes arranged in a parent/child tree, identified by
the top node's ID (the "book id," or *bid*). Any content type you choose to
allow can be placed into a book outline, and a single book can mix several
content types. The hierarchy can go up to nine levels deep and is stored in a
dedicated outline table, managed behind the scenes by the `book.manager` service.

Book was part of Drupal core through Drupal 10 and now ships as a contributed
module. It depends only on core's Node module, and it works as soon as you allow
at least one content type to join books. Each book node gains an **Outline** tab
for placing or moving it, administrators get a re‑order screen, and readers get a
"Book navigation" block, book‑aware breadcrumbs, a list of all books at `/book`,
and a printer‑friendly single‑document export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the optional submodules.
2. [Configuration](configuration/index.md) — the `book.settings` form field by
   field (allowed types, sort order, parent selector) and the permissions that
   gate books.

## Where it lives in the admin menu

Book's settings are at **Structure → Books → Settings**
(`/admin/structure/book/settings`). The overview of every book on the site is at
**Structure → Books** (`/admin/structure/book`), where you can open a book to
re‑order its pages. Readers see the public list of books at `/book`.

## How to use it

First, tell Book which content types may join a book (see Configuration) — until
you do, nothing can be added to an outline. Then, on any node of an allowed type,
open its **Outline** tab (`/node/{node}/outline`) to start a new book or place
the page under an existing parent. Add a **Book navigation** block to a sidebar so
readers can move around the current book, and grant the relevant permissions to
your editor roles so they can create books, add pages, and re‑order them. To read
a whole book as one printable page, use the export at
`/book/export/html/{node}` (gated by the *access printer‑friendly version*
permission).
