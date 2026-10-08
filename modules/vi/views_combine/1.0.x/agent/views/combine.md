<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Combining views

Views Combine merges several Views displays into one by compiling each into a
`\Drupal\Core\Database\Query\Select` and joining them with a **SQL `UNION`**. The base
view's query becomes the parent; every combined view's query is appended with
`$base_query->union($query)`. Before unioning, all queries are column-normalized so the
UNION is valid even when the views select different tables/fields. There is no settings
form — everything is configured per-view in the Views UI.

## Prerequisites (from README)

- Base view and every combined view must use the **Unformatted list** display style.
- The base view must use the **Fields** row style.
- Combined views may use **Content** or **Fields** row style.
- For per-entity output across mixed types, use the **Rendered entity** field with the same
  field label in the base and all combined views (combined views only render fields that also
  exist in the base view).

## Set up a combined view

1. Edit the base view display.
2. Add field **Global: Views combine** (`hook_views_data` key `views_combine`).
3. In the field settings, choose the target `view : display` in **Combine view** (`view_id`
   option, required) and apply. The select is populated by `Views::getViewsAsOptions()`.
4. (optional) Add another **Global: Views combine** field for each additional view to fuse.
5. (optional) Set the display's caching to **Tag based (views combine)** (`combine_tags`).

The field, filter, and sort handlers all have an empty `query()` — they contribute no SQL
themselves. The actual combining runs later, in `hook_views_post_build()` →
`\Drupal\views_combine\ViewsCombiner::combine()`. See [api/extend.md](../api/extend.md).

## Handlers

### Field — "Global: Views combine" (`@ViewsField("views_combine")`)

The unit of combining: one field per view you want to union in.

| Option | Meaning |
| --- | --- |
| `view_id` | The `view_id:display_id` to combine (required select). |
| `filter_map` | Per exposed-filter identifier: remap the base view's exposed input key to a different identifier on the combined view. |
| `sort_map` | Per exposed-sort identifier: remap the base view's exposed sort key to the combined view. |

`init()` forces `exclude = 1` so the field never renders as a column; `adminSummary()`
shows the chosen `view_id`. `filter_map`/`sort_map` textfields appear only for exposed
handlers of the base view (`getExposedHandlers()`).

### Filter — "Global: Views combine" (`@ViewsFilter("views_combine")`, extends `InOperator`)

Optional. Lets an operator include or exclude entire combined views from the result set,
best used as an **exposed** filter. The value options are `current_view` plus each
`view_id` configured in the display's `views_combine` fields (`getValueOptions()`) — a user
can only pick among views the site builder already wired in, never an arbitrary view.

Extra expose options:

| Expose option | Meaning |
| --- | --- |
| `default_views` | Pre-selected views when the exposed filter uses "reduce" and no input is submitted. |
| `all_views` | Views included by the "select all" pseudo-option. |
| `view_labels` | Rewrite option labels, one `value | Label` per line. |

Operator `in`/`not in` is honored by `ViewsCombiner::filter()`; selecting a combined view
also pulls in any views it recursively combines (`getViewIds()`).

### Sort — "Global: Views combine" (`@ViewsSort("views_combine")`)

Optional. Adds a synthetic `_combine_sort` column numbered by combine order so rows group by
which view they came from. It is `UncacheableDependencyTrait`. Ordinary sorts do not need
this handler — they are normalized automatically (below).

## Exposed filter & sort inheritance

- Exposed input is captured **only from the base view** and pushed down to every combined
  view (`buildView()` calls `$view->setExposedInput($input)`). For a base exposed filter to
  apply to a combined view, that view must define the same exposed filter with an **identical
  identifier** (or map it via `filter_map`).
- Exposed sort: if the requested `sort_by` does not exist on a combined view, the combiner
  falls back to that view's `sort_map` entry, else its first sort handler, else drops the
  sort. Every sort field across the queries is re-aliased `_order_#` (by position) and the
  final UNION orders by those aliases, so heterogeneous sorts line up. Direction prefers the
  topmost view. Non-timestamp cross-type sorts are the site builder's responsibility; use
  `hook_views_query_alter()` for advanced cases.

## Caching — `combine_tags`

Set the display's cache plugin to **Tag based (views combine)**. `CombineTags` extends core
`Tag` and, for each combined query, merges (a) the combined view's config/storage cache tags
and (b) the list cache tags of each entity type it queries — so edits to a combined view or
its entities invalidate the merged render. Entity *result* tags are merged under plain "Tag
based" too, but view-config and list tags are only added by `combine_tags`.

## Supported display styles

Only the two styles patched by `hook_views_plugins_style_alter()` work out of the box:
`default` (Unformatted list) and `views_bootstrap_grid`. Each is swapped for a subclass that
mixes in `CombineStyleTrait`, which re-renders each row with the field handlers of the view
the row actually came from (`_view_id`). Other styles need a matching subclass — see
[api/extend.md](../api/extend.md).

## Limitations (from README)

- Combined views only render fields that also exist on the base view.
- Very limited built-in configuration validation — misconfiguration can fatal at query time.
- Tag-based cache invalidation across combined views is described as "more testing required".
- Intended for advanced site builders.
