<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Union display plugin (`id: union`)

`Drupal\views_display_union\Plugin\views\display\Union` extends `DisplayPluginBase`. It is a Views
display type registered with `#[ViewsDisplay(id: 'union', title: 'Union', theme: 'views_view')]`.
A union display is never rendered on its own — it **attaches** to one or more "main" displays in the
same view, and its query is appended to the main query with a SQL `UNION`.

## Concept

- The main display (Page, Block, etc.) produces the actual output; the row style, pager and sort of
  the *main* display govern the combined result set.
- Each union display is a second query over the same view's base setup but with its own filters,
  contextual filters and relationships. Its rows are `UNION`ed into the main query's rows.
- Both displays must expose the **same fields, in the same order** (see Validation), because a SQL
  `UNION` requires matching column lists.

## Add and configure (Views UI)

1. Edit the view, open the "Add" display dropdown, add a **Union** display.
2. Configure its fields, filters, contextual filters and relationships so the field set matches the
   main display exactly (same fields, same order; same contextual filters; use the **same Sort
   Criteria** as the main display so the compiled column/expression counts line up).
3. In the union display, open **Attach to** and check the main display(s) this union should feed.

The plugin sets these behavior flags:

| Flag / method | Value | Effect |
|---|---|---|
| `$usesOptions` | `FALSE` | Union display has no per-display "display options" of its own beyond `displays`. |
| `$usesPager` | `FALSE` | No pager on the union display; paging comes from the main display. |
| `$usesMore` | `FALSE` | No "more" link. |
| `$usesAreas` | `FALSE` | No header/footer/empty areas. |
| `usesExposed()` | `TRUE` | May carry exposed filters (but see the subset rule below). |
| `displaysExposed()` | `TRUE` | Exposed form is considered. |
| `renderPager()` | `FALSE` | Union display never renders a pager. |
| `execute()` | no-op | The union display is not executed as a page; it only contributes its query. |

## The `displays` option

- Declared in `defineOptions()` as `['displays' => ['default' => []]]`.
- `buildOptionsForm()` (section `displays`, titled "Attach to") builds a `checkboxes` element whose
  `#options` are every **other** display in the view (`display_title`), each label passed through
  `\Drupal\Component\Utility\Html::escape()`.
- `submitOptionsForm()` stores `array_filter($form_state->getValue('displays'))`, i.e. only the
  checked display ids.
- `optionsSummary()` shows the "Attach to" summary: the single display's title, "Multiple displays",
  or "Not defined".

Config schema (`config/schema/views_display_union.schema.yml`), key `views.display.union`:

```yaml
views.display.union:
  type: views_display
  mapping:
    displays:            # sequence of main display ids this union attaches to
      type: sequence
      sequence:
        type: string
```

In the exported view config the union display carries `display_plugin: union` and
`display_options.displays: { page_1: page_1, ... }` naming the main display(s) it attaches to.

## Validation (`validate()`)

At save time the union display validates itself against each main display it is attached to and
returns Views errors (blocking save) when:

- `usesFields()` differs, or the **field count** differs, or any field differs by `entity_type` or
  by `field` (fields must match, in order) →
  *"The union %union does not have the same fields, in the same order, as the main display %main…"*.
- The **contextual filter (argument) count** differs, or any argument differs by `entity_type` →
  *"The union %union does not have the same contextual filters, in the same order, as the main
  display %main…"*.

## Runtime mechanism (`hook_views_pre_execute`)

Implemented in `Drupal\views_display_union\Hook\ViewsDisplayUnionHooks::viewsPreExecute()`. For the
main display currently executing, it walks `$view->display_handler->getAttachedDisplays()` and, for
each attached display whose plugin id is `union`, that `isEnabled()`, and whose `access()` passes:

1. **Clone the view** onto that union display id (`Views::executableFactory()->get($view->storage)`),
   copy the current `args` (`setArguments`) and exposed input (`setExposedInput`), and `build()` it
   to obtain the union display's compiled `build_info['query']` and `build_info['count_query']`.
2. **Exposed-filter subset check:** if the union display exposes a filter whose id is not among the
   main display's exposed filters, a messenger error is shown and no union is performed (the union's
   exposed filters must be a subset of the main's).
3. For each of `query` then `count_query`:
   - `preExecute()` the main query, collect its field and expression aliases.
   - For each attached union query: `preExecute()` it, then require an **equal field count and equal
     expression count** vs. the main (else a messenger error, hinting to use the same Sort Criteria,
     and abort).
   - Copy the main query's `distinct` flag onto the attached query.
   - For `count_query` without distinct, add a dummy `HAVING 1` to both queries (so
     `Select::prepareCountQuery()` does not collapse the union).
   - Clear the attached query's `ORDER BY`.
   - **`$main_query->union($attached_query)`** — the attached query is appended to the main query as
     a UNION.

Because each union display is built through the normal Views build pipeline (clone → `setDisplay`
→ `build`) and both queries have `preExecute()` called on them, each constituent query is a fully
compiled core `Drupal\Core\Database\Query\Select` with its own filters and query alters applied;
the module then combines them with the core query builder's `Select::union()` method (no raw SQL is
assembled by the module). The main display then executes the combined query and renders the merged
rows with its own row style, sort and pager.

## Views UI cleanup (`hook_views_ui_display_tab_alter`)

`viewsUiDisplayTabAlter()` hides UI rows that do not apply to a union display: the format's "Format"
control, and the second/third columns' header, footer, empty, pager, exposed-form, use-AJAX,
show-admin-links and CSS-class settings.

## Gotchas

- Field lists, their order, and contextual filters must match the main display exactly, or the view
  will not save (validation) — and a run-time count mismatch shows a messenger error instead of
  unioning.
- Give the union display the **same Sort Criteria** as the main display; sorts add expressions, and
  the run-time check compares field/expression counts.
- The union display has no pager or areas of its own; combined sorting and paging are the whole point
  and come from the main display.
