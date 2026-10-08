# Book Visibility — manual setup guide

**Book Visibility** (`book_visibility`) adds a block‑visibility condition based
on the current book. With it enabled, any block — most usefully the book
navigation block — can be shown or hidden depending on which book the page the
visitor is on belongs to. It lives in the *Book* package.

You configure it right where you place a block: the module adds a *book*
condition to the block's visibility settings, so you can say "show this block
only within these books." There is no separate admin settings page.

**What it controls — read this carefully.** Book Visibility controls **block
visibility (presentation), not book content access**. It decides whether a
*block* renders on a page; it does **not** decide who is allowed to read a book.
It has no access‑control role at all. To protect the content of a book, use
Drupal's core node access — hiding a block does not restrict the content behind
it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no settings form of its own. The condition it adds appears inside each
block's configuration at **Structure → Block layout**
(`/admin/structure/block`), in that block's *Visibility* settings.

## How to use it

1. Go to **Structure → Block layout** and configure (or place) a block.
2. In the block's **Visibility** settings, use the new **book** condition to
   choose the book(s) for which the block should appear.
3. Save. The block now renders only on pages that belong to the selected
   book(s).

Remember this only affects whether the block is shown — use core node access to
control who can actually read the book content.
