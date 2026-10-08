# Taxonaut — manual setup guide

**Taxonaut** (`taxonaut`) replaces Drupal's plain taxonomy term list with a
fast, interactive tree view built for working with large vocabularies. Drupal's
built‑in list is fine for a handful of terms, but once a vocabulary has
hundreds or thousands of terms across several levels it becomes hard to manage.
Taxonaut gives you a collapsible tree with lazy‑loaded children — so even a
vocabulary with 100,000+ terms opens quickly — and a set of editing tools that
make reorganising it far less painful.

From the tree you can drag terms to reorder them within a level or move them to
a new parent, double‑click a term to rename it in place without a page reload,
and add child terms exactly where you need them. It also includes heavier
organisation tools: **merge** duplicate terms (with entity references
automatically reassigned across your content), **bulk** publish / unpublish /
delete on multiple selected terms, automatic **duplicate detection**, and
**weight normalisation** to tidy fragmented term weights back to 0, 1, 2, 3….
Mistakes are recoverable — there is full **undo/redo** (Ctrl+Z / Ctrl+Shift+Z)
with an operation history, and you can save a named **snapshot** of a
vocabulary's hierarchy before a big change and restore it with one click.
Rounding it out are a real‑time **server‑side search** that shows each result's
full ancestry path and expands the tree to it when clicked, and **CSV/JSON
import and export** for bulk loading or backing up a vocabulary.

Taxonaut needs no configuration — enable it and the tree view is available
immediately. It depends only on core's **Taxonomy** module, needs PHP 8.1+, and
supports Drupal 10.3+ and 11. It bundles the SortableJS library (for
drag‑and‑drop) inside the module, so there is no external library to install,
and it works with both the Claro and Gin admin themes. Access follows Drupal's
normal taxonomy permissions: every operation requires the core **Administer
taxonomy** permission, and for finer control Taxonaut also provides
per‑vocabulary *"Manage terms in {vocabulary}"* permissions you can assign at
**People → Permissions**. Note that this module is not covered by Drupal's
security advisory policy, so weigh that as you would for any non‑covered contrib
module.

This guide is written for a **human** setting the site up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Taxonaut has no settings form of its own; it adds the tree view as a new way to
open any vocabulary. After enabling, reach it from any of these places:

- **Taxonomy admin page** (`/admin/structure/taxonomy`) — each vocabulary gains
  a **Tree View** link in its operations dropdown.
- **Vocabulary tabs** — when viewing a vocabulary's term list, a new **Tree
  View** tab appears alongside the existing *List* and *Edit* tabs.
- **Direct URL** — `/admin/structure/taxonomy/{vocabulary-machine-name}/tree`.

## How to use it

Open a vocabulary in the tree view and work directly in the tree: drag to
reorder or reparent, double‑click to rename, and use the add/merge/bulk tools
from the interface. Handy keyboard shortcuts: **/** focuses the search box,
**Escape** clears the search, **Ctrl+Z** / **Ctrl+Shift+Z** undo and redo, and
**Enter / Space** expand or collapse the focused term. For large one‑off or
recurring imports, Taxonaut pairs well with the Feeds or Migrate modules; its
own CSV/JSON import is ideal for spreadsheet‑style bulk loads with automatic
parent matching by name.
