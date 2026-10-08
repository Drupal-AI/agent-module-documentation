# Book Link Weight — manual setup guide

**Book Link Weight** (`book_link_weight`) makes ordering pages within a core
**Book** outline far easier. Core positions a page among its siblings with a plain
numeric **Weight** select element, which becomes awkward once a book has many
pages — you end up doing weight arithmetic just to slot a page into the right
spot. This module replaces that select with a familiar **drag‑and‑drop** table,
so editors can visually reorder pages by dragging them.

It is a pure content‑editing UX enhancement. When you edit a book page (or use the
standalone book outline form), the module rebuilds the outline widget as a
draggable, weighted table in place of the numeric selector. There is nothing to
configure and no new permissions — it operates entirely inside the existing node
add/edit forms, so access is governed by core's own node and book permissions.
It supports Drupal 8 through 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Book).

## How to use it

There is no setup beyond enabling the module. When you add or edit a node that is
part of a book, the book outline section of the form now shows a drag‑and‑drop
ordering table instead of the numeric weight select. Drag pages up or down to
reorder them relative to their siblings, then save the node. The same friendlier
control also appears on the standalone book outline form.
