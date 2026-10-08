# Taxonomy term depth — manual setup guide

**Taxonomy term depth** (`taxonomy_term_depth`) adds a `depth_level` field to
every taxonomy term that records how deep the term sits in its hierarchy — a
root term is depth 1, its child is depth 2, and so on. The value is kept correct
automatically: whenever a term is created or moved to a new parent, the module
walks up the parent chain and recalculates. Because the depth is stored in a real
field, you can sort and filter on it in Views without writing any recursion.

That opens up a lot of everyday tricks: show only top-level terms in a menu or
listing, cap a term view at levels 1–2 for compact navigation, sort terms to
render a hierarchy outline, or style term pages differently per level. For
developers there's a small set of helper functions to read a term's depth, its
parent, its full ancestor chain, or its children directly.

The module has no settings page and no permissions of its own (its forms use the
core *Administer taxonomy* permission). It depends only on core's **Taxonomy**
module. On install it queues all your existing terms for a one-time depth
calculation, and you can re-run that per vocabulary whenever you need to. Because
a stored field can't simply be dropped while it holds data, the module also ships
an uninstall helper (a Drush command and a UI form) to clear the values first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it (which triggers the initial depth calculation), and how to uninstall
   cleanly.

## Where it lives in the admin menu

There's no settings page. The one interactive piece is the **Update term depths**
task on each vocabulary, at *Structure → Taxonomy → {vocabulary}* — its operation
link points to
`/admin/structure/taxonomy/manage/{vocabulary}/taxonomy_term_depth_update`.

## How to use it

- **It just works after install.** Enabling the module queues all existing terms
  for a depth calculation, and from then on the value updates automatically as
  editors add or re-parent terms.
- **Use it in Views.** When building a term view, add or filter on the numeric
  **Depth** field — for example filter to `Depth = 1` for top-level terms only, or
  `Depth <= 2` for a shallow navigation. You can also sort by depth to produce an
  outline.
- **Recalculate a vocabulary.** If you ever need to rebuild the values (after a
  bulk import, say), use the **Update term depths** operation on that vocabulary.
- **Read it in code.** Helper functions let you fetch a single term's depth
  (`taxonomy_term_depth_get_by_tid($tid)`), force a fresh recalculation, or walk
  the parent/child chain. See the sibling [`agent/`](../agent/start.md) docs for
  the full list.
