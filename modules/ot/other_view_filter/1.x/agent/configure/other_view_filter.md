# other_view_filter — configure (Views UI)

No admin/settings form and no config object of its own — this is a **Views filter handler**
you add inside a view.

## Add the filter
1. Edit the view you want to *narrow*.
2. **Filter criteria → Add** → choose **"Other view result"** (available on the view's base
   field, e.g. Content: it appears as the filter titled *Other view result*).
3. Set the **operator**: `not in` (default — exclude the other view's rows) or `in` (keep
   only the other view's rows).
4. Under **View: display**, select one or more `view:display` combos whose results drive the
   filter. (The special `all` option is removed.)
5. Optionally tick **Inherit contextual filter(s)** to pass this view's arguments into the
   selected views.
6. Save.

## Options (`OtherView` / stored in the filter's config)
| Option | Default | Meaning |
|---|---|---|
| `operator` | `not in` | `in` = keep matching IDs; `not in` = exclude them. |
| `value` | — | Array of selected `viewId:displayId` strings. |
| `inherit_contextual_filters` | `FALSE` | Pass the parent view's `args` into each selected view before executing it. |

Config schema: `config/schema/other_view_filter.views.schema.yml`.

## Behaviour / edge cases
- Each selected display is **fully executed** at query time; the base-field value
  (`real field`, e.g. `nid`) of each result row becomes the IN/NOT IN set.
- The referenced display's own access is enforced — `$view->access($display)` must pass or
  that display is skipped.
- If selected views return **no rows**: `not in` is a no-op (everything shows); `in` forces
  an empty result via `addWhereExpression('1 = 2')`.
- **Performance:** executing extra full view queries per request is expensive. The UI shows a
  warning; keep to one referenced view where possible, keep those views simple, and cache
  aggressively (Views cache, Views Content cache, etc.).

## Where it is available
`hook_views_data_alter()` adds the filter to: every `ContentEntityType` data/base table
(keyed on its id field), each `search_api_index_*` table (keyed on `search_api_id`), and any
other table that declares `table.base.field`.
