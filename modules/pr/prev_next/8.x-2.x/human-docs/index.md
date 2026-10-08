# Prev Next — manual setup guide

**Prev Next** (`prev_next`) is a high‑performance API for finding the *previous*
and *next* node relative to any given node. "Previous article / next article"
navigation looks trivial, but computed live it is one of the more expensive
things a content site does: a query ordered by date across the whole content
table, run on every article page, that only gets slower as your archive grows.

Prev Next solves that by **precomputing** the relationships and storing them in a
lookup table, so retrieving a node's neighbour is a fast, constant‑cost read no
matter how much content you have. Once the module is enabled it builds this index
in the background on cron, working backwards through existing content until every
node is indexed. New nodes are indexed automatically as they are created.

The module is an **API**, not a ready‑made block. On its own it displays nothing —
it exposes a single function, `prev_next_nid($nid, $op)`, that your theme or a
custom module calls to get the previous or next node ID. See the module's
`README.txt` for a worked example of turning those IDs into on‑page links.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no dedicated configuration URL registered by the module, so this guide
folds the small settings page and everyday use into the sections below.

## How to use it

**Settings page.** The module provides a settings form where you can:

- **Restrict indexing to specific content types** — for example, only index Video
  and Image nodes so visitors browse those, but not blogs or basic pages.
- **Set how many nodes to index per cron run** (default **200**). Lower this on a
  shared host if cron runs are timing out.
- **Re‑Index** — a button that rebuilds the whole lookup from scratch. Use it after
  a large import or if you suspect the index has drifted.

**Indexing existing content.** New nodes are indexed automatically on save. Nodes
that already existed when you installed the module need to be saved once to enter
the index — go to the content list, select the nodes, and run the **Save content**
bulk action to index them in one pass.

**Using the API in code.** Ask for a node's neighbour by ID:

```php
// The previous node's ID (older by the module's ordering).
$prev_nid = prev_next_nid($nid, 'prev');

// The next node's ID.
$next_nid = prev_next_nid($nid, 'next');
```

Turn those IDs into links (with a title, a thumbnail, and so on) in your theme or
module. If you never call the function, the module does nothing visible.

> **A note on access and freshness.** Because neighbours are precomputed, remember
> to keep the lookup current — check that it updates when nodes are deleted,
> unpublished, or have their date changed, not only on save — and test with a
> restricted or unpublished node in the sequence to confirm the links behave the
> way you expect on a site where content visibility varies.
