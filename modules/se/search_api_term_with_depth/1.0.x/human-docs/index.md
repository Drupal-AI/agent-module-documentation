# Search API Term With Depth — manual setup guide

**Search API Term With Depth** (`search_api_term_with_depth`) brings core's
familiar "Term with Depth" behaviour to Search API-based Views. When you filter
or facet on a taxonomy term, it also matches the term's descendant (child) terms
— so filtering on a broad category such as *Fruit* also returns content tagged
only with a child term such as *Apple*.

It solves a gap that anyone building hierarchical navigation on top of Search API
runs into: core's own taxonomy filter understands term hierarchy and depth, but
that logic does not automatically apply to a search_api-backed View. This module
adds a depth selector to Views filters and arguments (contextual filters) for
taxonomy term fields. Pick a positive depth and a parent term matches its
children; pick a negative depth and a child term also matches its parents (so
searching for *Apple* with depth -1 also picks up content tagged *Fruit*).

The module works by expanding the selected term into the relevant list of term
IDs and adding them as query conditions. It changes only which results match — it
exposes no content on its own, and the underlying Search API query still enforces
index and View access. It depends only on **Search API**, adds no settings page,
and has no permissions of its own.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

After enabling the module and clearing caches, edit a Search API-based View
(**Structure → Views**). Add a **filter** or an **argument (contextual filter)**
for a taxonomy term field. You will now see a select list of depth numbers with
an explanation of how the hierarchy match works. Choose the depth you want, save
the View, and the term match will expand up or down the hierarchy accordingly.
