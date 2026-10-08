<!-- SPDX-License-Identifier: GPL-2.0+ -->
Views Arg Order Sort adds a Views sort handler that orders results to match the order of the values passed in a multi-item contextual filter (argument), so a view fed `3,1,2` returns rows in exactly that sequence.

---

The module declares a global Views sort field via `hook_views_data()` (`views_arg_order_sort` table, field `weight`, title **"Multi-item Argument Order"**) backed by the sort plugin `views_arg_order_sort_default` (`ArgOrderSort extends SortPluginBase`). You add it as a **Sort criteria** on any view; it does not need a table join because it is a `#global` handler. It reads the values from a chosen contextual filter (the `argument_number` option, 0-indexed), splits them on `+` or `,`, and builds a SQL `CASE … WHEN … THEN <position>` expression on the target column so rows sort by their position in the argument list. Options: **argument_number** (which contextual filter to read), **inherit_type** (derive the sort column from that argument's own table/field — the usual choice), **field_type** (an explicit `table::field` such as `node::nid` when not inheriting), **null_below** (place items not present in the argument at the end), plus the standard sort **order** (ASC/DESC, which reverses the sequence). It is typically used with programmatically-passed IDs (e.g. from a search-relevance service or a hand-curated list) to preserve that exact ordering in the rendered view. No config UI, no permissions, no Drush — configuration is per view and validated by the `views.sort.views_arg_order_sort_default` schema.

---

- Render nodes in the exact order of node IDs passed to a view (e.g. `?ids=5,3,9` → 5, 3, 9).
- Preserve a search engine's relevance ranking by passing ranked IDs into a view and sorting by argument order.
- Show a hand-curated list of entities in a fixed, editor-defined sequence.
- Order results from an external recommendation service by the order it returned.
- Sort a "related items" view by a precomputed similarity order.
- Keep a multi-value contextual filter's order meaningful instead of falling back to default sorting.
- Place items that are not in the argument list at the end of the view (`null_below`).
- Reverse the passed order with a DESC sort when you need the inverse sequence.
- Inherit the sort column automatically from the contextual filter's own field (`inherit_type`).
- Choose an explicit `table::field` to sort on when the argument is the NULL/none argument.
- Sort by the order of taxonomy term IDs, user IDs, or any entity id passed as an argument.
- Build a "featured, in this order" block driven by a list of IDs.
- Support pagers while keeping the argument-defined order stable across pages.
- Feed IDs from custom code into `$view->args` and have the view honor that order.
- Handle `+` or `,` separated multi-item arguments (both delimiters are split).
- Combine with other sorts as a primary "keep my order" criterion.
- Recreate a "recently viewed, in view order" list from a stored ID sequence.
- Order promoted content by a marketing-defined priority list.
- Avoid writing a custom sort plugin just to preserve argument order.
- Drive an API/JSON view (rest export) that must echo the caller's requested ordering.
- Order a gallery/carousel view by a curated ID list.
- Keep quiz/step content in the exact sequence supplied by an argument.
