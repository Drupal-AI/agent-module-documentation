<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Taxonomy Parent ID from Term (views_taxonomy_parent_id_from_term) — agent index

A **Views data + query alter** that resolves a taxonomy term to its **parent term's id**. It
registers a "Parent ID From Term" relationship, numeric filter, and taxonomy argument on the
`taxonomy_term__parent` table, then rewrites the running query so an input term id is swapped for
that term's first parent id. Package **Views**. Version **2.0.1**. Core **`^10.3 || ^11.0`**.
License GPL-2.0-or-later. **No dependencies, src/, routes, permissions, config, or Drush.**

- **The two hooks, the registered handler, the value rewrite, and the multi-parent caveat** →
  [views/handler.md](views/handler.md)

## What it actually is

- Two procedural include files, no PHP classes:
  - `views_taxonomy_parent_id_from_term.views.inc` — `hook_views_data_alter()` adds
    `$data['taxonomy_term__parent']['term_parent']` (title *"Parent ID From Term"*, `real field`
    `parent_target_id`) exposing a `relationship` (to `taxonomy_term_field_data`), a numeric
    `filter`, and a `taxonomy` `argument`.
  - `views_taxonomy_parent_id_from_term.views_execution.inc` — `hook_views_query_alter()` walks
    `$query->where`, finds conditions whose field matches `:taxonomy_term__parent_term_parent`,
    calls `taxonomy_term` storage `loadParents($value)`, and replaces the condition value with the
    **first** parent's id (`NULL` if the term is top-level).
- Changes only how a taxonomy-term View queries; the site admin adds the handler on a View via the
  Views UI. Nothing runs for anonymous requests except the normal View it is placed in.

## Caveats (from source)

- **Top-level terms have no parent** → value becomes `NULL`, so the View returns no match; define a
  fallback for the empty-argument case.
- **Multiple parents**: only the first `loadParents()` entry is used, and the handler's own help
  text warns this "can produce duplicate entries" for multi-parent vocabularies.
