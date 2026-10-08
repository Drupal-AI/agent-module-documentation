# Pager — manual setup guide

**Pager** (`pager`) provides a block with **previous / next navigation between
individual pieces of content** — the previous and next article, the next chapter of a
document, the following item in a collection. It's worth being clear about the name up
front, because two very different things are both called a "pager":

- **Views' pager** moves through *pages of a list* (page 1, 2, 3 of search results).
- **This module** moves through *items in a sequence* — one piece of content to the
  next.

That kind of sequence navigation is what keeps a reader moving through a body of content
— a documentation set, a book‑like structure, a serialised archive — instead of returning
to an index between every item. Pager renders the links as a block you place in your
theme, with a choice of two presentations: a **centred block** or **slide‑out side tabs**.

What counts as "next" is up to you. The block can build its sequence across chosen
**content types** and **taxonomy terms**, in a **direction** you set, with configurable
**end behaviour** at the first and last item. It can even show an **image** for each
previous/next target (using an image field and image style), so the links become visual
cards rather than plain text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and note
   the optional Views sub‑modules.
2. [Configuration](configuration/index.md) — the settings that define the sequence
   (content types, taxonomy, direction, end behaviour) and the block's appearance.

## Where it lives in the admin menu

Pager has its own settings page (route `pager.admin`), governed by the **Administer
pager** permission. The block itself is placed from **Structure → Block layout**. See
[Configuration](configuration/index.md) for the settings, field by field.

## A note on correctness

Two things decide whether the previous/next links are right. First, **what defines the
sequence** — creation date, a weight field, taxonomy order and menu order each give a
different "next," so choose the ordering that matches how a reader expects to move through
the content. Second, **sequence links are per‑item and cacheable**: a block showing "the
next article" must vary by the current item and be invalidated when a neighbouring item is
added, unpublished or reordered — otherwise it can point at content that has moved or
disappeared, a broken link the site won't notice on its own.
