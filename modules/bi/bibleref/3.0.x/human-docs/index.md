# Bible Reference — manual setup guide

**Bible Reference** (`bibleref`) provides a way to store and display scripture
citations — book, chapter and verse — consistently across your content. Instead of
typing references as free text, editors can capture a proper Bible reference on a
piece of content, and the module formats it the same way everywhere it appears.

The reference data is backed by core's Taxonomy module: the list of books (and the
structured reference information behind them) is managed as taxonomy, which the
field then draws on. This keeps citations tidy and uniform rather than depending on
however each author happened to type them.

It is a fields and content-display feature. The reference data is admin/editor
content, and the module has no content-model role or access-control behavior beyond
providing the field — it simply lets your content store and show Bible references.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on core Taxonomy).

## Where it lives in the admin menu

Bible Reference does not add a central settings form of its own. You use it by
adding its field to a content type under **Structure → Content types →
(your type) → Manage fields** (`/admin/structure/types`), and the taxonomy that
backs it lives under **Structure → Taxonomy** (`/admin/structure/taxonomy`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the content type you want to add citations to, choose **Manage fields**,
   and add the Bible-reference field.
3. Editors then enter book/chapter/verse on that content, and the module renders
   the citation consistently wherever the content is displayed. Adjust the
   display under **Manage display** as with any other field.
