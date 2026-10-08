# Views Arg Order Sort — manual setup guide

**Views Arg Order Sort** (`views_arg_order_sort`) adds a Views sort criterion
that orders results to match the order of the values you pass into a multi-item
contextual filter. Feed a view the IDs `3,1,2` and it returns those rows in
exactly that sequence — `3`, then `1`, then `2` — instead of falling back to
alphabetical or ID order.

This is what you reach for when the *order itself* carries meaning: a
search-relevance ranking, a recommendation engine's output, or a hand-curated
"featured, in this order" list. You pass the IDs into the view's contextual
filter (usually from code, a URL, or a REST/embed call, separated by `+` or
`,`), and this sort keeps the rendered rows in that order across pages and
pagers.

The sort is called **"Multi-item Argument Order"** in the Views UI. It is a
global sort, so it needs no relationship or table join. A handful of options let
it read from the right contextual filter, work out which column to sort on, and
decide where to place rows whose value was not in the list. It depends only on
core's **Views** module and has no admin page, permissions or Drush commands —
you configure it per view.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is **no settings page** — you add the sort to a view.

1. The view must already have a **contextual filter** (argument) whose values
   you will pass, for example **Content: ID**.
2. In the view, add **Sort criteria → "Multi-item Argument Order"**.
3. Configure the options:
   - **Argument** — which contextual filter to read the ordered values from
     (`0` is the first). Default `0`.
   - **Inherit type of Field from Argument** — leave this **on** for the normal
     case; it works out the column to sort on automatically from the chosen
     contextual filter.
   - **Type of Argument Field** — only used if you turn inheriting off. Specify
     an explicit `table::field`, such as `node::nid`.
   - **Non arguments at End** — when on (default), rows whose value was not in
     the passed list are placed at the end.
   - **Order (ASC/DESC)** — the standard sort direction; **DESC** reverses the
     sequence you passed.
4. Save the view.
5. Pass the ordered values into the argument — via `$view->args` in code, the
   URL, or a REST/embed call. Values may be `+`- or `,`-separated.

Internally it builds a SQL `CASE … WHEN … THEN` expression so each row lands at
the position matching where its value appeared in your argument list.
